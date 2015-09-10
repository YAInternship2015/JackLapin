//
//  LECMCollectionCell.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LECMCollectionCell : UICollectionViewCell

#warning в метод должна передаваться модель, а не NSDictionary
- (void)configWithModel:(NSDictionary *)model;

@end
