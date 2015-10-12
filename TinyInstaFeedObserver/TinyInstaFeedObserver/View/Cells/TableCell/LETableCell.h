
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FOModel+CoreDataProperties.h"

static NSInteger SPTableCellIndent = 15;
static NSInteger SPTableCellIndentLabel = 8;
static NSInteger SPTableCellX = 6;

@interface LETableCell : UITableViewCell

- (void)configWithModel:(FOModel *)model;

@end
