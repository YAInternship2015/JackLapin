//
//  LECMTableCell.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMTableCell.h"
#import "constants.h"

@implementation LECMTableCell

#warning следующие два метода нужно удалить
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configWithCM:(NSDictionary *)model {
    self.backgroundColor = [UIColor greenColor];
    self.CMName.text = model[@"name"];
    self.CMImage.image = [UIImage imageNamed:model[@"imageName"]];
}

@end
