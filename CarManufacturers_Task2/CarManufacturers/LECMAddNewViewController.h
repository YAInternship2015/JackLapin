//
//  LECMAddNewViewController.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LECMAddNewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)saveButtonPressed:(id)sender;

@end
