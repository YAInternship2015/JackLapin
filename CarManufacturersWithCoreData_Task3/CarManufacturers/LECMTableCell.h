//
//  LECMTableCell.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LECMFactory+CoreDataProperties.h"

@interface LECMTableCell : UITableViewCell

- (void)configWithModel:(LECMFactory *)model;

@end
