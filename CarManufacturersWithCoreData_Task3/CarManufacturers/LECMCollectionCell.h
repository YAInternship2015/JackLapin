//
//  LECMCollectionCell.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LECMFactory+CoreDataProperties.h"
@class LECMFactory;

@class LECMCollectionCell;

@protocol LECMCollectionCellDelegate <NSObject>

- (void)collectionCellLongPressed:(LECMCollectionCell*)cell;

@end


@interface LECMCollectionCell : UICollectionViewCell

@property (nonatomic, weak) id <LECMCollectionCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath* indexPath;

- (void)configWithModel:(LECMFactory *)model indexPath:(NSIndexPath*)indexPath delegate:(id<LECMCollectionCellDelegate>)delegate;

@end
