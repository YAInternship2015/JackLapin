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

#warning не используйте в именах CM, достаточно названия модели, configWithFactory или configWithModel:
- (void)configWithCM:(LECMFactory *)model;

@end
