//
//  LECMCollectionCell.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMCollectionCell.h"
#import "constants.h"

@implementation LECMCollectionCell

- (void)configWithModel:(NSDictionary *)model {
    self.backgroundColor = [UIColor grayColor];
    self.CMImage.image = [UIImage imageNamed:model[@"imageName"]];
}

@end
