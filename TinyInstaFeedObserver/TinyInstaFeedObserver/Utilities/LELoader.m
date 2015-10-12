//
//  LELoader.m
//  TinyInstaFeedObserver
//
//  Created by Jack Lapin on 02.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//



#import "LELoader.h"
#import "AFNetworking.h"
#import "NSDictionary+UrlEncoding.h"

static NSString *const kTokenRequestURL = @"https://api.instagram.com/oauth/access_token";
static NSString *const kBaseRequestURL = @"https://api.instagram.com/v1/tags/automotive/media/recent?";
static NSString *const kClientID = @"26b5f5babdea4c788158b2e892094435";
static NSString *const kClientSecret = @"5d8c265251f0435cb910e1b74745840e";
static NSString *const kGrant_type = @"authorization_code";
static NSString *const kRedirectURI = @"tinyInstaFeedObserver://";
static NSString *const kScope = @"basic+likes";

@interface LELoader()

@property(nonatomic, strong) NSMutableData *data;

@end

@implementation LELoader

+ (id) dataLoader
{
    const static LELoader *loader = nil;
    if (nil == loader)
    {
        loader = [[LELoader alloc] init];
        loader.sharedCache = [[NSCache alloc] init];
        
    }
    return loader;
}


// Метод запрашивает access_token на основании полученного урл, после получения его вызывает метод по обработке полученных данных

- (void) getToken
{
    
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
              [self getData];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}


// Запрашивает последние данные из ленты авторизованного пользователя

- (void) getData
{
    NSDictionary *params = @{@"access_token":self.token,
                             @"count":@"10"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  //  manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:kBaseRequestURL
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

    if (self.parsedData == nil)
    {
        self.parsedData = [[NSMutableArray alloc] init];

    }

    self.nextUrl = [[self.dataDict objectForKey:@"pagination"] objectForKey:@"next_url"];

    for (int i = 0; i < [self.dataArray count]; i++)
    {
        NSString *idString = [self.dataArray[i] objectForKey:@"id"];
        self.flag = 0;

        for (int j = 0; j < [self.parsedData count]; j++) {
            if ([idString isEqualToString:[self.parsedData[j] objectForKey:@"id"]])
            {
                self.flag = 1;
            }
        }

        if (self.flag != 1)
        {

            NSString *imageLR = [[[self.dataArray[i] objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"];
            NSString *userName = [[self.dataArray[i] objectForKey:@"user"] objectForKey:@"full_name"];
            NSString *userAvatar = [[self.dataArray[i] objectForKey:@"user"] objectForKey:@"profile_picture"];
            NSString *imageSR = [[[self.dataArray[i] objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
            NSNumber *liked = [self.dataArray[i] objectForKey:@"user_has_liked"];
            NSNumber *comments = [[self.dataArray[i] objectForKey:@"comments"] objectForKey:@"count"];
            NSNumber *numberOfLikes = [[self.dataArray[i] objectForKey:@"likes"] objectForKey:@"count"];
            NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
            [temp setObject:idString forKey:@"id"];
            [temp setObject:imageLR forKey:@"imageLR"];
            [temp setObject:imageSR forKey:@"imageSR"];
            [temp setObject:liked forKey:@"liked"];
            [temp setObject:userName forKey:@"userName"];
            [temp setObject:userAvatar forKey:@"userAvatar"];
            [temp setObject:comments forKey:@"comments"];
            [temp setObject:numberOfLikes forKey:@"numberOfLikes"];
            [self.parsedData addObject:temp];
        }
        self.flag = 0;
    }


}

//- (void) getMoreData
//{
//    AFHTTPClient *aClient = [[AFHTTPClient alloc] init];
//    [aClient setParameterEncoding:AFFormURLParameterEncoding];
//    NSMutableURLRequest *request = [aClient requestWithMethod:@"GET"
//                                                         path:self.nextUrl
//                                                   parameters:@{@"access_token": self.token}];
//
//
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [aClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *temp = [responseObject objectFromJSONData];
//
//        self.dataDict = temp;
//        [self parseData];
//
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//    [operation start];
//}



@end
