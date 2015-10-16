//
//  LECMTableViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LETableViewController.h"
#import "LETableCell.h"

NSInteger const kValueToUploadTable = 3;

@interface LETableViewController () <UITableViewDataSource,
UITableViewDelegate,
LEDataSourceDelegate>
@property (nonatomic, strong) LEDataSource *dataSource;

@end

@implementation LETableViewController

@synthesize dataSource = _dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [LEDataSource sharedDataSource];
    
}

#warning этот метод можно удалить
- (LEDataSource *) dataSource {
    return _dataSource;
}

-(void)viewWillAppear:(BOOL)animated {
    self.dataSource.delegate = self;
    [self.tableView reloadData];
}

#pragma mark -  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource countOfModels];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([LETableCell class]);
    LETableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell configWithModel:[self.dataSource modelAtIndex:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSource deleteModelAtIndex:indexPath];
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
  //  [self.tableView scrollToRowAtIndexPath:newIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (([self.dataSource countOfModels] - indexPath.row) == kValueToUploadTable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNewDataNeedToDownload object:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [[self.dataSource modelAtIndex:indexPath] valueForKey:kModelDecription];
    NSString *identifier = NSStringFromClass([LETableCell class]);
    LETableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSDictionary *attributes = @{NSFontAttributeName: cell.FOCaption.font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(cell.FOCaption.frame.size.width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil].size;
    if (size.height > kCellImagePreferedSize){
        return size.height;
    }
    else{
        return kCellImagePreferedSize;
    }
}

@end

