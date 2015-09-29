//
//  LECMCollectionCell.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LECMFactory+CoreDataProperties.h"
@class LECMFactory;

@class LECMCollectionCell;


@interface LECMCollectionCell : UICollectionViewCell

- (void)configWithModel:(LECMFactory *)model;

@end
