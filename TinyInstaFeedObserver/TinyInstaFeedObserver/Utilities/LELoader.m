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
#import "constants.h"
#import "ColorCube/CCColorCube.h"
#import "LEAlertFactory.h"








@interface LELoader()

@property(nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) LEDataSource* dataSource;


@end

NSString *userAvURLString;

@implementation LELoader



+ (id) dataLoader
{
    const static LELoader *loader = nil;
    if (nil == loader)
    {
        loader = [[LELoader alloc] init];
        loader.sharedCache = [[NSCache alloc] init];
        loader.dataSource = [LEDataSource sharedDataSource];
        [[NSNotificationCenter defaultCenter] addObserver:loader selector:@selector(needMore)
                                                     name:NotificationNewDataNeedToDownload object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:loader selector:@selector(userAvatarPrepare)
                                                     name:NotificationLoginWasAcquired object:nil];
        
    }
    return loader;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) userAvatarPrepare {
    NSURL *imgURL = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults] stringForKey:@"userAvURLString"]];
    NSData *userAvData = [NSData dataWithContentsOfURL:imgURL];
    UIImage *image = [UIImage imageWithData:userAvData];
    
    CCColorCube *colorCube = [[CCColorCube alloc] init];
    NSArray *arr =[colorCube extractBrightColorsFromImage:image avoidColor:[UIColor blackColor] count:kColorsFromUserAvatar];
    
    self.individualUserColorPattern = arr;
    
}

// Скидывает данные в массив для дальнейшей обработки
//
- (void) parseDataDictionary:(NSDictionary *)dataDict
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
//    LELoader *loader = [LELoader dataLoader];
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"token"]) {
        UIAlertController * alert = [LEAlertFactory showAlertWithTitle:
                                     [NSString stringWithFormat:NSLocalizedString(@"Warning", nil)]
                                                        message:[NSString stringWithFormat:NSLocalizedString(@"To see more, you should logIn first!", nil)]];
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }
    else {
        [LEAPIClient getDataNextURL:self.nextUrl compliteBlock:^(NSDictionary *answer) {
            [self parseDataDictionary:answer];
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}


@end
