//
//  LECMFactory+DictionaryRepresentation.m
//  CarManufacturers
//
//  Created by Jack Lapin on 10.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMFactory+DictionaryRepresentation.h"

@implementation LECMFactory (DictionaryRepresentation)

-(NSDictionary *)dictionaryFromModelRepresentation:(LECMFactory *)model {
    NSDictionary *dictModel = @{@"name" : model.name,@"imageName" : model.imageName};
    return dictModel;
}

@end
