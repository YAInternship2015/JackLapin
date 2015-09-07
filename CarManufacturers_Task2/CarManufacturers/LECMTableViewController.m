//
//  LECMTableViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMTableViewController.h"
#import "LEDataSource.h"
#import "LECMTableCell.h"

@interface LECMTableViewController () <CMDataSourceDelegate>

@property (strong, nonatomic) LEDataSource *dataSource;

@end

@implementation LECMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[LEDataSource alloc] initWithDelegate:self];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource countModels];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LECMTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LECMTableCell class])];
    if (!cell) {
        cell = [LECMTableCell new];
    }
    [cell configWithCM:[self.dataSource modelForIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - DDModelsDataSourceDelegate

- (void)dataWasChanged:(LEDataSource *)dataSource {
    [self.tableView reloadData];
}


@end
