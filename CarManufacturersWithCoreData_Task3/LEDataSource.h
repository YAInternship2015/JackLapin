//
//  LEDataSource.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+ApplcationPathes.h"
#import <CoreData/CoreData.h>
#import "LECMFactory+CoreDataProperties.h"

@protocol LEDataSourceDelegate;

@interface LEDataSource : NSObject <NSFetchedResultsControllerDelegate>

+ (LEDataSource*) sharedDataSource;

@property (nonatomic, strong) id<LEDataSourceDelegate> delegate;

- (NSUInteger)countModels;
- (LECMFactory *)modelForIndex:(NSIndexPath*)indexPath;
- (void)addnewCMWithName:(NSString *)name imageName:(NSString *)imageName;
- (void)deleteModelForIndex:(NSIndexPath *)index;


+ (void)copyPlistToAppDocumentsFolder;

@end

@protocol LEDataSourceDelegate <NSObject>

@required

-(void)dataWasChanged:(LEDataSource *)dataSource withType:(NSFetchedResultsChangeType)changeType atIndex:(NSIndexPath *) indexPath newIndexPath:(NSIndexPath *)newIndexPath ;
-(void)dataWillChange;
-(void)dataDidChangeContent;


@end