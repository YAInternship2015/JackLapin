//
//  LEAPIClient.m
//  TinyInstaFeedObserver
//
//  Created by Jack Lapin on 08.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LEAPIClient.h"
#import <AFNetworking.h>

@implementation LEAPIClient

+(void)loginToInstagram {
    NSString *fullAuthUrlString = [[NSString alloc]
                                   initWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=%@",
                                   kAuthRequestURL,
                                   kClientID,
                                   kRedirectURI,
                                   kResponseType];
    NSURL *authUrl = [NSURL URLWithString:fullAuthUrlString];
    [[UIApplication sharedApplication] openURL:authUrl];
}

+ (void) getTokenWithCode:(NSString *)code complite:(LESuccesBlock)complBlock failure:(LEFailureBlock)failure
{
    __block NSString *userName = @"";
    NSDictionary *params =
    @{@"code":code,
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
              NSString *token = [responseObject objectForKey:@"access_token"];
              
              [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
              [[NSUserDefaults standardUserDefaults] setObject:[[responseObject objectForKey:@"user"] objectForKey:@"profile_picture"] forKey:@"userAvURLString"];

              userName = [[responseObject objectForKey:@"user"] objectForKey:@"username"];
              if (userName.length > 0 ) {
                  [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginWasAcquired object:userName];
              }
              [self getDataNextURL:nil compliteBlock:complBlock failure:failure];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
              failure(error);
          }];
}

+ (void) getDataNextURL:(NSString *)nextURL compliteBlock:(LESuccesBlock)block failure:(LEFailureBlock)failure {
    NSString *urlString = nextURL ? nextURL : kBaseRequestURL;
    
    NSDictionary *params = @{@"access_token": [[NSUserDefaults standardUserDefaults] stringForKey:@"token"], @"count":@"10"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:urlString
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             block(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             failure(error);
         }];
}

@end
