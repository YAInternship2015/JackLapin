//
//  LEAlertFactoryViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 10.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LEAlertFactory.h"

@interface LEAlertFactory ()

@end

@implementation LEAlertFactory

#warning + (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message {
+ (UIAlertController*)showAlertWithTitle:(NSString *)title message:(NSString *)message {
#warning здесь уплыло выравнивание кода
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
#warning текст @"OK" должен быть в Localizable.strings
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    return alert;
}

@end
