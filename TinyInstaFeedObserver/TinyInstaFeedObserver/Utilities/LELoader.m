//
//  LELoader.m
//  TinyInstaFeedObserver
//
//  Created by Jack Lapin on 02.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//


#import "LELoader.h"
#import "FOModel+CoreDataProperties.h"
#import "AFNetworking.h"
#import "NSDictionary+UrlEncoding.h"
#import "ColorCube/CCColorCube.h"
#import "LEAlertFactory.h"
#import "InstaUser.h"
#import "LELoginService.h"


@interface LELoader()

@property (nonatomic, strong) LEDataSource* dataSource;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *nextUrl;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSURLConnection *tokenRequestConnection;
@property (nonatomic, strong) NSString *token;

@end

NSString *userAvURLString;

@implementation LELoader

+ (id) dataLoader
{
#warning рпавильное объявление синглтона у вас есть в LEDataSource, сделайте здесь по аналогии
    const static LELoader *loader = nil;
    if (nil == loader)
    {
        loader = [[LELoader alloc] init];
#warning вся дальнейшая инициализация объекта loader должна происходить в методе init
        loader.dataSource = [LEDataSource sharedDataSource];
        [[NSNotificationCenter defaultCenter] addObserver:loader selector:@selector(needMore)
                                                     name:NotificationNewDataNeedToDownload object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:loader selector:@selector(userAvatarPrepare)
                                                     name:NotificationLoginWasAcquired object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:loader selector:@selector(parseDataWithNotification:)
                                                     name:NotificationTokenWasAcquiredReadyToParce object:nil];
        
    }
    return loader;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#warning вместо get лучше "load" или "request", так как операция длительная, а не мгновенная. И также в имени метода урл пишется либо уже весь капсом, либо camel case'ом
-(void)getTokenWithRecievedURl:(NSURL *)url{
    [LELoginService loginWithUrl:url];
}

- (void)userAvatarPrepare {
    NSString *imgURLstring = [[NSUserDefaults standardUserDefaults] stringForKey:@"userAvURLString"];
    NSString *userLogin = [[NSUserDefaults standardUserDefaults] stringForKey:@"userLogin"];
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"fullUserName"];
    InstaUser *user = [InstaUser createUserWithLogin:userLogin name:userName avatarURLstring:imgURLstring];
    self.individualUserColorPattern = [user colorsFromUserAvatar];
}

- (void)parseDataWithNotification:(NSNotification *)notification{
    NSDictionary * dictFromNotification = [NSDictionary dictionary];
    dictFromNotification = notification.object;
#warning зачем нужна переменная dictFromNotification, если можно передать в следующий метод сразу notification.object?
    [self parseDataDictionary:dictFromNotification];
}

- (void)parseDataDictionary:(NSDictionary *)dataDict
{
    NSArray *tempArray = [dataDict objectForKey:@"data"];
    self.dataArray = tempArray;
    self.nextUrl = [[dataDict objectForKey:@"pagination"] objectForKey:@"next_url"];
    for (int i = 0; i < [self.dataArray count]; i++) {
        if (!modelIDObject(i, self.dataArray, self.dataSource)){
            [self.dataSource insertModelWithCaption:captionObject(i, self.dataArray) imageURL:imageSRObject(i, self.dataArray) modelID:idStringObject(i, self.dataArray)];
        }
    }
}

- (void) needMore{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"token"]) {
        NSLog(@"Need to get token first");
    }
    else {
        [LEAPIClient getDataNextURL:self.nextUrl completeBlock:^(NSDictionary *answer) {
#warning здесь нужен weakSelf
            [self parseDataDictionary:answer];
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}


@end
