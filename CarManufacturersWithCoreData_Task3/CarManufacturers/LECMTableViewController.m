//
//  LECMTableViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMTableViewController.h"

#import "LECMTableCell.h"

@interface LECMTableViewController () <UITableViewDataSource,
                                        UITableViewDelegate,
                                        LEDataSourceDelegate>

@end

@implementation LECMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [LEDataSource sharedDataSource];
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.dataSource.delegate = self;
    [self.tableView reloadData];
}

#pragma mark -  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource countModels];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([LECMTableCell class]);
    LECMTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell configWithCM:[self.dataSource modelForIndex:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSource deleteModelForIndex:indexPath];
    }
}

-(void)dataWasChanged:(LEDataSource *)dataSource withType:(NSFetchedResultsChangeType)changeType atIndex:(NSIndexPath *)indexPath newIndexPath:(NSIndexPath *)newIndexPath{
    [self.tableView beginUpdates];
    switch(changeType) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            break;
        case NSFetchedResultsChangeMove:
            break;
    }
    [self.tableView endUpdates];
    [self.tableView scrollToRowAtIndexPath:newIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}


-(void)dataDidChangeContent{
    
}

-(void)dataWillChange {
    
}


@end

