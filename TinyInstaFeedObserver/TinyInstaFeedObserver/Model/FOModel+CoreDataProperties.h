//
//  InstaFeedObserver+CoreDataProperties.h
//  TinyInstaFeedObserver
//
//  Created by Jack Lapin on 01.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FOModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FOModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *modelID;
@property (nullable, nonatomic, retain) NSString *caption;
@property (nullable, nonatomic, retain) NSString *imageURL;

@end

NS_ASSUME_NONNULL_END
