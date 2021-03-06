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

@property (readonly) NSArray *individualUserColorPattern;

+ (id)dataLoader;

- (void)requestTokenWithRecievedUrl:(NSURL *)url;


@end
