//
//  CMModel+CoreDataProperties.h
//  CarManufacturers
//
//  Created by Jack Lapin on 11.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CMModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *imageName;

@end

NS_ASSUME_NONNULL_END
