//
//  LECMContainerViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

float const animationDuration = 0.5f;

#import "CMconstants.h"
#import "LECMContainerViewController.h"
#import "LECMCollectionViewController.h"
#import "LECMTableViewController.h"



@interface LECMContainerViewController ()

@property (nonatomic, strong) LECMTableViewController *tableController;
@property (nonatomic, strong) LECMCollectionViewController *collectionController;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, assign) BOOL isCollectionControllerActivated;

@end

@implementation LECMContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isCollectionControllerActivated = NO;
    
    self.tableController = [self.storyboard instantiateViewControllerWithIdentifier:TableControllerID];
    self.collectionController = [self.storyboard instantiateViewControllerWithIdentifier:CollectionControllerID];
    
    [self presentController:self.tableController];
}

#pragma mark - ContainerViewController methods

- (void)presentController:(UIViewController *)controller {
    UIViewController *prewVC = self.currentViewController;
    self.currentViewController = controller;
    [self.currentViewController willMoveToParentViewController:self];
    [self addChildViewController:controller];
    controller.view.frame = self.view.bounds;
    [self.view addSubview:controller.view];
    [self.currentViewController didMoveToParentViewController:self];
    
    if (prewVC) {
        UIViewAnimationOptions flipDirection = controller == self.tableController ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
        [UIView transitionFromView:prewVC.view toView:controller.view duration:animationDuration options:flipDirection completion:^(BOOL finished) {
            //#comment проверка на завершение анимации прежде чем убивать вьюху
            if (finished) {
                [prewVC.view removeFromSuperview];
                [prewVC removeFromParentViewController];
            }
        }];
    }
}

#pragma mark - Actions

- (void)swapViewControllers:(UINavigationItem *)navigationItem {
    if (!self.isCollectionControllerActivated) {
        [self presentController:self.collectionController];
        self.isCollectionControllerActivated = YES;
    } else {
        [self presentController:self.tableController];
        self.isCollectionControllerActivated = NO;
    }
}

@end
