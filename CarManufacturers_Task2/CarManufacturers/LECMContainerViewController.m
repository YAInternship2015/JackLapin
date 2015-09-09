//
//  LECMContainerViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "constants.h"
#warning два одинаковых импорта
#import "LECMContainerViewController.h"
#import "LECMContainerViewController.h"
#import "LECMCollectionViewController.h"
#import "LECMTableViewController.h"



@interface LECMContainerViewController ()

@property (strong, nonatomic) LECMTableViewController *tableController;
@property (strong, nonatomic) LECMCollectionViewController *collectionController;
@property (strong, nonatomic) UIViewController *currentViewController;
#warning не лучшее название переменной - переименойте
@property (assign, nonatomic) BOOL isChange;

@end

@implementation LECMContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isChange = NO;
    
    self.tableController = [self.storyboard instantiateViewControllerWithIdentifier:TableControllerID];
    self.collectionController = [self.storyboard instantiateViewControllerWithIdentifier:CollectionControllerID];
    
    [self presentController:self.tableController];
}

#pragma mark - ContainerViewController methods

- (void)presentController:(UIViewController *)controller {
    if (self.currentViewController) {
        [self removeCurrentViewController];
    }
    [self addChildViewController:controller];
    controller.view.frame = self.view.bounds;
    [self.view addSubview:controller.view];
    self.currentViewController = controller;
    [controller didMoveToParentViewController:self];
}

- (void)removeCurrentViewController {
    [self.currentViewController willMoveToParentViewController:nil];
    [self.currentViewController.view removeFromSuperview];
    [self.currentViewController removeFromParentViewController];
}

- (void)swapCurrentControllerWith:(UIViewController *)controller {
    
    [self.currentViewController willMoveToParentViewController:nil];
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    
    UIViewAnimationOptions opt = UIViewAnimationOptionCurveLinear;
#warning продолжительность анимации следует вынести в локальные константы
    [UIView animateWithDuration:2.0f delay:0.0f options:opt animations:^{
            } completion:^(BOOL finished) {
        
        [self.currentViewController.view removeFromSuperview];
        [self.currentViewController removeFromParentViewController];
        self.currentViewController = controller;
        [self.currentViewController didMoveToParentViewController:self];
    }];
}

#pragma mark - Actions

- (void)swapViewControllers:(UINavigationItem *)navigationItem {
    if (!self.isChange) {
        [self swapCurrentControllerWith:self.collectionController];
        self.isChange = YES;
    } else {
        [self swapCurrentControllerWith:self.tableController];
        self.isChange = NO;
    }
}

@end
