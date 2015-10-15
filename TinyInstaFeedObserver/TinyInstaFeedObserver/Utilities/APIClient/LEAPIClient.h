//
//  LEAPIClient.h
//  TinyInstaFeedObserver
//
//  Created by Jack Lapin on 08.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "constants.h"

typedef void (^LESuccesBlock)(NSDictionary *answer);
typedef void (^LEFailureBlock)(NSError *error);

@interface LEAPIClient : NSObject

+ (void)loginToInstagram;
+ (void)getTokenWithCode:(NSString *)code complite:(LESuccesBlock)complBlock failure:(LEFailureBlock)failure;
+ (void) getDataNextURL:(NSString *)nextURL compliteBlock:(LESuccesBlock)block failure:(LEFailureBlock)failure;

@end
