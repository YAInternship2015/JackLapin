//
//  LECMAddNewViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMAddNewViewController.h"
#import "LECMValidator.h"
#import "LEDataSource.h"

@interface LECMAddNewViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

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
        
        UIAlertController * alert = [LECMValidator showAlertWithTitle:@"Error" message:[error localizedDescription]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        
        [LEDataSource addCM:[LECMFactory modelWithName:name]];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
@end
