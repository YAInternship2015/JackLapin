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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needMore)
                                                     name:NotificationNewDataNeedToDownload object:nil];
        
    }
    return loader;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) userAvatarPrepare : (NSString *) URLString {
    NSURL *imgURL = [NSURL URLWithString:URLString];
    NSData *userAvData = [NSData dataWithContentsOfURL:imgURL];
    UIImage *image = [UIImage imageWithData:userAvData];
    
    CCColorCube *colorCube = [[CCColorCube alloc] init];
    NSArray *arr =[colorCube extractBrightColorsFromImage:image avoidColor:[UIColor blackColor] count:kColorsFromUserAvatar];
    
    self.individualUserColorPattern = arr;
    
}

// Метод запрашивает access_token на основании полученного урл, после получения его вызывает метод по обработке полученных данных

- (void) getToken
{
    __block NSString *userName = @"";
    NSDictionary *params =
    @{@"code":self.code,
      @"client_id":kClientID,
      @"client_secret":kClientSecret,
      @"grant_type":kGrant_type,
      @"redirect_uri":kRedirectURI
      };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:kTokenRequestURL
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"%@", responseObject);
              self.token = [responseObject objectForKey:@"access_token"];
              userName = [[responseObject objectForKey:@"user"] objectForKey:@"username"];
              if (userName.length > 0 ) {
                  [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginWasAcquired object:userName];
              }
              userAvURLString = [[responseObject objectForKey:@"user"] objectForKey:@"profile_picture"];
              [self userAvatarPrepare:userAvURLString];
              [self getData];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

- (void) getData {
    NSString *urlString = kBaseRequestURL;
    if (self.nextUrl) {
        urlString = self.nextUrl;
    }
    NSDictionary *params = @{@"access_token":self.token, @"count":@"10"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:urlString
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *temp = responseObject;
             self.dataDict = temp;
             [self parseData];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

// Скидывает данные в массив для дальнейшей обработки
//
- (void) parseData
{
    
    NSArray *tempArray = [self.dataDict objectForKey:@"data"];
    self.dataArray = tempArray;
    
    self.nextUrl = [[self.dataDict objectForKey:@"pagination"] objectForKey:@"next_url"];
    
    for (int i = 0; i < [self.dataArray count]; i++) {
        NSString *idString = [self.dataArray[i] objectForKey:@"id"];
        NSString *userName = [[self.dataArray[i] objectForKey:@"user"] objectForKey:@"full_name"];
        NSString *userAvatar = [[self.dataArray[i] objectForKey:@"user"] objectForKey:@"profile_picture"];
        NSString *imageSR = [[[self.dataArray[i] objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
        NSNumber *liked = [self.dataArray[i] objectForKey:@"user_has_liked"];
        NSNumber *comments = [[self.dataArray[i] objectForKey:@"comments"] objectForKey:@"count"];
        NSNumber *numberOfLikes = [[self.dataArray[i] objectForKey:@"likes"] objectForKey:@"count"];
        NSString *caption = [[self.dataArray[i] objectForKey:@"caption"] objectForKey:@"text"];
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        [temp setObject:idString forKey:@"id"];
        [temp setObject:imageSR forKey:@"imageSR"];
        [temp setObject:caption forKey:@"caption"];
        [temp setObject:liked forKey:@"liked"];
        [temp setObject:userName forKey:@"userName"];
        [temp setObject:userAvatar forKey:@"userAvatar"];
        [temp setObject:comments forKey:@"comments"];
        [temp setObject:numberOfLikes forKey:@"numberOfLikes"];
        [self.parsedData addObject:temp];
        
        if (![[self.dataSource modelWithID:idString] valueForKey:@"modelID"]){
            [self.dataSource insertModelWithCaption:caption imageURL:imageSR modelID:idString];
        }
    }
    
}

+ (void) needMore{
    LELoader *loader = [LELoader dataLoader];
    if (!loader.token) {
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
        [loader getData];
    }
}


@end
