//
//  LECMCollectionCell.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LECMCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *CMImage;

- (void)configWithModel:(NSDictionary *)model;

@end
