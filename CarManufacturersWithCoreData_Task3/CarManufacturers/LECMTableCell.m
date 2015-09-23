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

- (void)configWithCM:(LECMFactory *)model {
#warning цвет фона вы задаете единожды, это не стоит делать каждый раз при задании новой модели. Цвет можно установить либо в сториборде, либо в метоже awakeFromNib
    self.backgroundColor = [UIColor greenColor];
    self.CMName.text = [model valueForKey:@"name"];
    self.CMImage.image =  ([model valueForKey:@"imageName"])?[UIImage imageNamed:[model valueForKey:@"imageName"]]:[UIImage imageNamed:NoImage];
    
}

@end
