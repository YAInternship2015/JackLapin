//
//  LECMFactory.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LECMFactory : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, strong) NSString *imageName;

+ (LECMFactory *)modelWithName:(NSString *)name;

@end
