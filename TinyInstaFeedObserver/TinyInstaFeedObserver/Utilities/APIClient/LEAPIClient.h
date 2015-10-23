//
//  LEAPIClient.h
//  TinyInstaFeedObserver
//
//  Created by Jack Lapin on 08.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^LESuccessBlock)(NSDictionary *response);
typedef void (^LEFailureBlock)(NSError *error);

@interface LEAPIClient : NSObject

+ (void) requestDataNextURL:(NSString *)nextURL completeBlock:(LESuccessBlock)block failure:(LEFailureBlock)failure;

@end
