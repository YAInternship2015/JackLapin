//
//  LECMValidator.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LECMFactory.h"
#import <UIKit/UIKit.h>


@interface LECMValidator : NSObject

+ (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error;
+ (UIAlertController*)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
