//
//  LECMValidator.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMValidator.h"


@implementation LECMValidator

+ (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error {
    if ([title length]<3){
        NSString *errorMessage;
        NSInteger errorCode = 0;
        errorMessage = @"The Name must be at least 3 characters.";
        errorCode = 77;
        
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorMessage};
        
        if (error != NULL) {
            *error = [NSError errorWithDomain:@"CarManufact" code:errorCode userInfo:userInfo];
        }
        return NO;
    }
    return YES;
}


+ (UIAlertController*)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
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
