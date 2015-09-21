//
//  LECMFactory+CoreDataProperties.h
//  CarManufacturersWithCoreData
//
//  Created by Jack Lapin on 21.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LECMFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface LECMFactory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *imageName;

@end

NS_ASSUME_NONNULL_END
