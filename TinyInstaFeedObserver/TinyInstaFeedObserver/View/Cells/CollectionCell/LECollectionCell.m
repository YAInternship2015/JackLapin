
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//



#import "constants.h"
#import "FOModel.h"
#import "LECollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface LECollectionCell()

@property (nonatomic, weak) IBOutlet UIImageView *FOImage;
@property (nonatomic, weak) IBOutlet UILabel *FOComment;

@end

@implementation LECollectionCell

- (void)configWithModel:(FOModel *)model
{
    self.FOComment.text = [model valueForKey:@"caption"];
    NSURL *imageURL = [model valueForKey:@"imageURL"];
    
   [self.FOImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:NoImage]];

}

@end
