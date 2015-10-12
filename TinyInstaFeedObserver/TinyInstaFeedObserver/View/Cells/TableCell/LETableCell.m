
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LETableCell.h"
#import "constants.h"

@interface LETableCell ()

@property (nonatomic, weak) IBOutlet UIImageView *FOImage;
@property (nonatomic, weak) IBOutlet UILabel *FOName;

@end

@implementation LETableCell

- (void)configWithModel:(FOModel *)model {
    self.FOName.text = [model valueForKey:@"name"];
    self.FOImage.image =  ([model valueForKey:@"imageName"])?[UIImage imageNamed:[model valueForKey:@"imageName"]]:[UIImage imageNamed:NoImage];
}

-(void)awakeFromNib {
    self.backgroundColor = [UIColor greenColor];
}

@end
