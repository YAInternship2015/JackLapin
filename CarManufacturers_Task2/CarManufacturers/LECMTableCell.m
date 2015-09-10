//
//  LECMTableCell.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMTableCell.h"
#import "CMconstants.h"

@interface LECMTableCell ()

@property (nonatomic, weak) IBOutlet UIImageView *CMImage;

@property (nonatomic, weak) IBOutlet UILabel *CMName;

@end

@implementation LECMTableCell

- (void)configWithCM:(NSDictionary *)model {
    self.backgroundColor = [UIColor greenColor];
    self.CMName.text = model[@"name"];
    self.CMImage.image = [UIImage imageNamed:model[@"imageName"]];
}

@end
