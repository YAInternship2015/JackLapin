
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LETableCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+placeHolderImage.h"
#import "LELoader.h"
@interface LETableCell ()

@property (nonatomic, weak) IBOutlet UIImageView *modelImage;
@property (nonatomic, weak) IBOutlet UILabel *modelCaption;



@end

@implementation LETableCell

#warning зачем нужна эта переменная?
NSInteger labelTextWidth;
#warning эта переменная должна быть статической? Или почему она объявлена именно здесь?
int countOfColor = 0;

- (void)configWithModel:(FOModel *)model {
    self.modelCaption.text = [model valueForKey:kModelDecription];
    NSURL *imageURL = [model valueForKey:kModelImg];
    [self.modelImage sd_setImageWithURL:imageURL placeholderImage:[UIImage setPlaceholderImage]];
    
    LELoader *loader = [LELoader dataLoader];
    if (countOfColor >= kColorsFromUserAvatar - 1) { countOfColor = 0; }
    if (loader.individualUserColorPattern.count > 0) {
        self.backgroundColor = [loader.individualUserColorPattern objectAtIndex: countOfColor];
        countOfColor++;
    }
}


-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor lightGrayColor];
}

@end
