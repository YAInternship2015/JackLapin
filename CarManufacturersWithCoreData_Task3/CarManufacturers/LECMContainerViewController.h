//
//  LECMContainerViewController.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LECMCollectionViewController.h"
#import "LECMTableViewController.h"

@interface LECMContainerViewController : UIViewController
@property (nonatomic, strong) LECMTableViewController *tableController;
@property (nonatomic, strong) LECMCollectionViewController *collectionController;

- (void)swapViewControllers:(UINavigationItem *)navigationItem;

@end
