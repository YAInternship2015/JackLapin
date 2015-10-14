//
//  LEAPIClient.m
//  TinyInstaFeedObserver
//
//  Created by Jack Lapin on 08.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LEAPIClient.h"

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

@end
