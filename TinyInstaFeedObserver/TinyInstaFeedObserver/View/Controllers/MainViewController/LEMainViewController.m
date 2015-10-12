//
//  MainViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LEMainViewController.h"
#import "LEContainerViewController.h"

static NSString *const redirectUri = @"tinyInstaFeedObserver://";
static NSString *const clientID = @"26b5f5babdea4c788158b2e892094435";
static NSString *const authUrlString = @"https://api.instagram.com/oauth/authorize/";
static NSString *const responseType = @"code&scope=basic+likes";




@interface LEMainViewController ()

@property (nonatomic, strong) LEContainerViewController *containerViewController;

@end

@implementation LEMainViewController

#pragma mark - UIViewController methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:EmbedContainerID]) {
        self.containerViewController = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"AddNewViewControllerID"]) {
//        [((LECMAddNewViewController*)segue.destinationViewController) setDataSorce:(self.containerViewController.tableController.dataSource)];
    }
}

- (IBAction)changeView:(id)sender {
    [self.containerViewController swapViewControllers:self.navigationItem];
}

- (IBAction)loginAction:(id)sender{
    NSString *fullAuthUrlString = [[NSString alloc]
                                   initWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=%@",
                                   authUrlString,
                                   clientID,
                                   redirectUri,
                                   responseType];
    NSURL *authUrl = [NSURL URLWithString:fullAuthUrlString];
    
    [[UIApplication sharedApplication] openURL:authUrl];
}

@end
