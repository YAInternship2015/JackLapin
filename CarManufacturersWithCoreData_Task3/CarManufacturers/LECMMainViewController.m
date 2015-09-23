//
//  MainViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMMainViewController.h"
#import "LECMContainerViewController.h"
#import "LECMAddNewViewController.h"



@interface LECMMainViewController ()

@property (nonatomic, strong) LECMContainerViewController *containerViewController;

@end

@implementation LECMMainViewController

#pragma mark - UIViewController methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
#warning AddNewViewControllerID вынести в константы, а @"EmbedContainer" почему-то нет
    if ([segue.identifier isEqualToString:@"EmbedContainer"]) {
        self.containerViewController = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:AddNewViewControllerID]) {
        ((LECMAddNewViewController*)segue.destinationViewController).dataSource = [self.containerViewController.tableController dataSource];
    }
}

- (IBAction)changeView:(id)sender {
    [self.containerViewController swapViewControllers:self.navigationItem];
}

@end
