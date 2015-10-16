//
//  LELoader.h
//  TinyInstaFeedObserver
//
//  Created by Jack Lapin on 02.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEDataSource.h"

@interface LELoader : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *token;

@property NSArray *individualUserColorPattern;


@property(nonatomic, strong) NSURLConnection *tokenRequestConnection;

+ (id) dataLoader;

- (void) parseDataDictionary:(NSDictionary *)dataDict;
@end
