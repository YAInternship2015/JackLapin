//
//  LECMFactory+DictionaryRepresentation.h
//  CarManufacturers
//
//  Created by Jack Lapin on 10.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMFactory.h"

@interface LECMFactory (DictionaryRepresentation)

- (NSDictionary *)dictionaryFromModelRepresentation:(LECMFactory *)model;

@end
