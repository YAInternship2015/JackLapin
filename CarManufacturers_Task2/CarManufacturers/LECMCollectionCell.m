//
//  LECMCollectionCell.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMCollectionCell.h"
#import "CMconstants.h"
#import "LECMFactory.h"

@interface LECMCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *CMImage;

@end

@implementation LECMCollectionCell

- (void)configWithModel:(LECMFactory *)model {
    self.CMImage.image = [UIImage imageNamed:model.imageName];
}

@end
