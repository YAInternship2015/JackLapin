//
//  LECMCollectionViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMCollectionViewController.h"
#import "LECMContainerViewController.h"
#import "LECMCollectionViewController.h"
#import "LEDataSource.h"
#import "LECMCollectionCell.h"

int const quantityOfCellsInRow = 4;
int const preferesCellSize = 100;
float const cellSpacing = 30.f;



@interface LECMCollectionViewController () <LECMCollectionCellDelegate, UICollectionViewDataSource, UICollectionViewDelegate, LEDataSourceDelegate>

@property (nonatomic, strong) LEDataSource *dataSource;
@property (nonatomic, strong) NSMutableArray *itemChanges;

@end

@implementation LECMCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [LEDataSource sharedDataSource];
}

-(void)viewWillAppear:(BOOL)animated {
    self.dataSource.delegate = self;
    [self.collectionView reloadData];
}

#pragma mark UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat mainScreen = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat cellSize = (mainScreen / preferesCellSize < quantityOfCellsInRow) ? (mainScreen - cellSpacing) / (quantityOfCellsInRow -1) : (mainScreen - cellSpacing-5) / quantityOfCellsInRow;
    return CGSizeMake(cellSize, cellSize);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource countModels];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LECMCollectionCell *cell = (LECMCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LECMCollectionCell class]) forIndexPath:indexPath];
    [cell configWithModel:[self.dataSource modelForIndex:indexPath] indexPath:indexPath delegate:self];
    return cell;
}


#pragma mark - LECMCollectionCellDelegate

- (void)collectionCellLongPressed:(LECMCollectionCell *)cell{
    
}

#pragma mark - IBactions

- (IBAction)handleLongPressAction:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [sender locationInView:self.collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.3f animations:^{
            UICollectionViewCell *cell = [weakSelf.collectionView cellForItemAtIndexPath:indexPath];
            cell.layer.transform = CATransform3DMakeRotation(M_PI,1.0,0.0,0.0);;
        } completion:^(BOOL finished) {
            [weakSelf.collectionView performBatchUpdates:^{
                [weakSelf.dataSource deleteModelForIndex:indexPath];
            } completion:nil];
        }];
    }
}

- (void)dataWillChange{
    self.itemChanges = [[NSMutableArray alloc] init];
}

-(void)dataWasChanged:(LEDataSource *)dataSource withType:(NSFetchedResultsChangeType)changeType atIndex:(NSIndexPath *)indexPath newIndexPath:(NSIndexPath *)newIndexPath {
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    switch(changeType) {
        case NSFetchedResultsChangeInsert:
            change[@(changeType)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(changeType)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            break;
        case NSFetchedResultsChangeMove:
            break;
    }
    [self.itemChanges addObject:change];
}

-(void)dataDidChangeContent{
    [self.collectionView performBatchUpdates:^{
        for (NSDictionary *change in self.itemChanges) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeUpdate:
                        break;
                    case NSFetchedResultsChangeMove:
                        break;
                }
            }];
        }
    } completion:^(BOOL finished) {
        self.itemChanges = nil;
    }];
}

@end
