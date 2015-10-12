
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//



#import "constants.h"
#import "FOModel.h"
#import "LECollectionCell.h"


@interface LECollectionCell()

@property (nonatomic, weak) IBOutlet UIImageView *CMImage;
@property (nonatomic, weak) IBOutlet UILabel *CMName;

@end

@implementation LECollectionCell

- (void)configWithModel:(FOModel *)model
{
    self.CMName.text = [model valueForKey:@"name"];
    self.CMImage.image =  ([model valueForKey:@"imageName"])?[UIImage imageNamed:[model valueForKey:@"imageName"]]:[UIImage imageNamed:NoImage];

}

@end
