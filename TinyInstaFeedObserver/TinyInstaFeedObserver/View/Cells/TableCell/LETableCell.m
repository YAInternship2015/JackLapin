
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LETableCell.h"
#import "constants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LELoader.h"

@interface LETableCell ()

@property (nonatomic, weak) IBOutlet UIImageView *FOImage;


@end

@implementation LETableCell

NSInteger labelTextWidth;
int countOfColor = 0;

- (void)configWithModel:(FOModel *)model {
    self.FOCaption.text = [model valueForKey:@"caption"];
    NSURL *imageURL = [model valueForKey:@"imageURL"];
    
    [self cellWidthMessage:[model valueForKey:@"caption"]];
    
    [self.FOImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:NoImage]];
    
    LELoader *loader = [LELoader dataLoader];
    
    if (countOfColor >= kColorsFromUserAvatar) { countOfColor = 0; }
    
    if (loader.individualUserColorPattern.count > 0) {
        self.backgroundColor = [loader.individualUserColorPattern objectAtIndex: countOfColor];
        countOfColor++;
    }
    
    //  self.backgroundColor = [arrOfBrigthColors objectAtIndex: 0];
    
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor lightGrayColor];
    labelTextWidth = self.FOCaption.frame.size.width;
    
}

- (void)cellWidthMessage:(NSString *)message {
    
    CGSize size = [self heightCellWith:message];
    
    [self setNeedsUpdateConstraints];
    if (size.height > 99) {
      //  self.FOCaption.adjustsFontSizeToFitWidth = true;
        
    }
    [self layoutIfNeeded];
    
}

- (CGSize)heightCellWith:(NSString *)message {
    NSString *text = (message && message.length > 0) ? message : @"some text";
    NSDictionary *attributes = @{NSFontAttributeName: self.FOCaption.font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(labelTextWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

@end
