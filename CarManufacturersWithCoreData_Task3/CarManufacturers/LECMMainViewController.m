//
//  MainViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMMainViewController.h"
#import "LECMContainerViewController.h"

@interface LECMMainViewController ()

@property (strong, nonatomic) LECMContainerViewController *containerViewController;

@end

@implementation LECMMainViewController

#pragma mark - UIViewController methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    if ([segue.identifier isEqualToString:@"EmbedContainer"]) {
        self.containerViewController = segue.destinationViewController;
    }
}

- (IBAction)changeView:(id)sender {
    [self.containerViewController swapViewControllers:self.navigationItem];
}

@end
