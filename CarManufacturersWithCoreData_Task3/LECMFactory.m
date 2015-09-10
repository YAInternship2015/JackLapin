//
//  LECMFactory.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMFactory.h"
#import "CMconstants.h"


@interface LECMFactory ()

//@property (nonatomic, strong) NSString *name;

@end

@implementation LECMFactory
+ (LECMFactory *)modelWithName:(NSString *)name {
    LECMFactory *model = [LECMFactory new];
    model.name = name;
    model.imageName = NoImage;
    return model;
}

@end
