//
//  MainViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "MainViewController.h"
#import "LECMContainerViewController.h"
#import "LECMCollectionViewController.h"
#import "LECMTableViewController.h"
#import "LECMAddNewViewController.h"


@interface MainViewController ()

@property (strong, nonatomic) LECMContainerViewController *containerViewController;

@end

@implementation MainViewController

#pragma mark - UIViewController methods

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    if ([segue.identifier isEqualToString:@"EmbedContainer"]) {
        self.containerViewController = segue.destinationViewController;
    }
}

- (IBAction)changeView:(id)sender {
    [self.containerViewController swapViewControllers:self.navigationItem];
}

@end
