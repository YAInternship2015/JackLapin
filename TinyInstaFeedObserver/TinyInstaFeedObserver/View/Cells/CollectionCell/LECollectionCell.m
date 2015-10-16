
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//


#import "FOModel.h"
#import "LECollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface LECollectionCell()

#warning пользуйтесь camel case'ом
@property (nonatomic, weak) IBOutlet UIImageView *FOImage;
@property (nonatomic, weak) IBOutlet UILabel *FOComment;

@end

@implementation LECollectionCell

- (void)configWithModel:(FOModel *)model
{
    self.FOComment.text = [model valueForKey:kModelDecription];
    NSURL *imageURL = [model valueForKey:kModelImg];
    
   [self.FOImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:NoImage]];

}

@end
