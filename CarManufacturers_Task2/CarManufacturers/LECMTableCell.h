//
//  LECMTableCell.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

#warning здесь справедливы все замечания из LECMCollectionCell

@interface LECMTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *CMImage;

@property (weak, nonatomic) IBOutlet UILabel *CMName;

- (void)configWithCM:(NSDictionary *)model;

@end
