//
//  LECMTableCell.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LECMTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *CMImage;

@property (weak, nonatomic) IBOutlet UILabel *CMName;

- (void)configWithCM:(NSDictionary *)model;

@end
