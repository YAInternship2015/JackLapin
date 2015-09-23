//
//  LECMAddNewViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMAddNewViewController.h"
#import "LEAlertFactory.h"
#import "LECMValidator.h"
#import "CMconstants.h"

@interface LECMAddNewViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;

#warning это можно удалить
- (IBAction)saveButtonPressed:(id)sender;

@end

@implementation LECMAddNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)hideKeyboard {
    [self.textField resignFirstResponder];
}


- (IBAction)saveButtonPressed:(id)sender {
    NSError *error = NULL;
    NSString * name = self.textField.text;
    
    if (![LECMValidator isValidModelTitle:name error:&error]) {
        UIAlertController * alert = [LEAlertFactory showAlertWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Error", nil)] message:[error localizedDescription]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        [self.dataSource addnewCMWithName:name imageName:NoImage];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
