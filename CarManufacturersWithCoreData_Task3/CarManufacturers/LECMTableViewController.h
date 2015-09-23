//
//  LECMTableViewController.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEDataSource.h"


@interface LECMTableViewController : UITableViewController

#warning это свойство должно быть в *.m
@property (nonatomic, strong) LEDataSource *dataSource;

@end
