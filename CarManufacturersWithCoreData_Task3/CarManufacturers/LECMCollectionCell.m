//
//  LECMCollectionCell.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMCollectionCell.h"
#import "CMconstants.h"
#import "LECMFactory.h"



@interface LECMCollectionCell()

@property (nonatomic, weak) IBOutlet UIImageView *CMImage;
@property (nonatomic, weak) IBOutlet UILabel *CMName;

@end

@implementation LECMCollectionCell

- (void)configWithModel:(LECMFactory *)model indexPath:(NSIndexPath *)indexPath delegate:(id<LECMCollectionCellDelegate>)delegate
{
    self.CMName.text = [model valueForKey:@"name"];
    self.CMImage.image =  ([model valueForKey:@"imageName"])?[UIImage imageNamed:[model valueForKey:@"imageName"]]:[UIImage imageNamed:NoImage];
    self.indexPath = indexPath;
    self.delegate = delegate;
}

#warning этот метод кто-то вызывает? Если нет, то не нужны ни делегат, ни indexPath
- (void)logTapSelector {
    if ([self.delegate respondsToSelector:@selector(collectionCellLongPressed:)]) {
        [self.delegate collectionCellLongPressed:self];
    }
}

@end
