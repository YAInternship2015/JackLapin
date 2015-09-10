//
//  LEDataSource.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+ApplcationPathes.h"

@class LECMFactory;

@protocol CMDataSourceDelegate;

@interface LEDataSource : NSObject

@property (weak, nonatomic) id<CMDataSourceDelegate>delegate;

- (instancetype)initWithDelegate:(id<CMDataSourceDelegate>)delegate;

- (NSUInteger)countModels;

//#warning датасорс должен возвращать модель, а не NSDictionary

- (LECMFactory *)modelForIndex:(NSInteger)index;


//#warning методы, которые не вызываются извне, не стоит показывать в *.h файле

+ (void)copyPlistToAppDocumentsFolder;
+ (void)addCM:(LECMFactory *)cmObject;

@end

@protocol CMDataSourceDelegate <NSObject>

@required

- (void)dataWasChanged:(LEDataSource *)dataSource;

@end
