//
//  LELoader.h
//  TinyInstaFeedObserver
//
//  Created by Jack Lapin on 02.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LELoader : NSObject

@property (nonatomic, strong) NSDictionary *userData;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSDictionary *dataDict;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *parsedData;
@property (nonatomic, strong) NSString *nextUrl;
@property (nonatomic, strong) NSCache *sharedCache;
@property int detailViewTag;
@property int flag;

@property(nonatomic, strong) NSURLConnection *tokenRequestConnection;

+ (id) dataLoader;
- (void) getToken;
- (void) getMoreData;
- (void) getData;

@end
