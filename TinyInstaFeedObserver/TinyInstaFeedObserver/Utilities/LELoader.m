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
#import "LEInstaUser.h"
#import "LELoginService.h"


@interface LELoader()

@property (nonatomic, strong) LEDataSource* dataSource;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *nextUrl;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSURLConnection *tokenRequestConnection;
@property (nonatomic, strong) NSString *token;
@property (readwrite) NSArray *individualUserColorPattern;

@end

NSString *userAvURLString;

@implementation LELoader

+ (id)dataLoader
{
    static LELoader * loader ;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        if (!loader) {
            loader = [[LELoader alloc] init];
        }
    });
    return loader;
}

- (LELoader *)init{
   LELoader *loader = [super init];
    loader.dataSource = [LEDataSource sharedDataSource];
    [[NSNotificationCenter defaultCenter] addObserver:loader selector:@selector(needMore)
                                                 name:NotificationNewDataNeedToDownload object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:loader selector:@selector(userAvatarPrepare)
                                                 name:NotificationLoginWasAcquired object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:loader selector:@selector(parseDataWithNotification:)
                                                 name:NotificationTokenWasAcquiredReadyToParce object:nil];
    return loader;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)requestTokenWithRecievedUrl:(NSURL *)url{
    [LELoginService loginWithUrl:url];
}

- (void)userAvatarPrepare {
    NSString *imgURLstring = [[NSUserDefaults standardUserDefaults] stringForKey:@"userAvURLString"];
    NSString *userLogin = [[NSUserDefaults standardUserDefaults] stringForKey:@"userLogin"];
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"fullUserName"];
    LEInstaUser *user = [LEInstaUser createUserWithLogin:userLogin name:userName avatarURLstring:imgURLstring];
    self.individualUserColorPattern = [user colorsFromUserAvatar];
}

- (void)parseDataWithNotification:(NSNotification *)notification{
    [self parseDataDictionary:notification.object];
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
        __weak typeof(self) weakSelf = self;
        [LEAPIClient requestDataNextURL:self.nextUrl completeBlock:^(NSDictionary *response) {
            [weakSelf parseDataDictionary:response];
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}


@end
