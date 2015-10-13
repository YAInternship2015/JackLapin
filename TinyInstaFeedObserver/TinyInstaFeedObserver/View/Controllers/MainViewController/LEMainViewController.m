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
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) LEDataSource *dataSource;

@end

@implementation LEMainViewController

#pragma mark - UIViewController methods

-(void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCaptionToLoginButton:)
                                                 name:NotificationLoginWasAcquired object:nil];
    self.dataSource = [LEDataSource sharedDataSource];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:EmbedContainerID]) {
        self.containerViewController = segue.destinationViewController;
    }
}

- (void) setCaptionToLoginButton :(NSNotification *) notification{
    NSString *loggedUserName = [@"Logged as - " stringByAppendingString:[notification object]];
    self.loginButton.titleLabel.text = loggedUserName;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (IBAction)deleteAllInLocalDB :(id)sender {
    [self.dataSource deleteAll];
}

@end
