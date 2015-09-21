//
//  LECMValidator.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMValidator.h"

NSInteger const minLenghAllowed = 3;

@implementation LECMValidator

+ (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error {
    if ([title length]<minLenghAllowed){
        NSInteger errorCode = 77;
        NSString *errorMessage =[NSString stringWithFormat:NSLocalizedString(@"The Name must be at least 3 characters.", nil)];
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorMessage};
        
        if (error != NULL) {
            *error = [NSError errorWithDomain:@"CarManufact" code:errorCode userInfo:userInfo];
        }
        return NO;
    }
    return YES;
}


@end
