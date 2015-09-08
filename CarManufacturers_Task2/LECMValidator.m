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
#warning цифру 3 следует вынести в локальные константы, чтобы было ясно, что это
    if ([title length]<3){
        NSString *errorMessage;
        NSInteger errorCode = 0;
#warning тексты, которые создаются в коде и которые увидит юзер в UI, должны быть объявлены в файле Localizable.strings. Что это за файл и зачем он нужен очень легко найти в гугле
#warning также, зачем вначале объявлять переменную и затем только задавать ей начальное значение? Инициализируйте уже со значением
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

#warning создавать алерт - никак не ответственность валидатора, это необходимо делать либо в самом вью контроллере, либо в фабрике алертов
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
