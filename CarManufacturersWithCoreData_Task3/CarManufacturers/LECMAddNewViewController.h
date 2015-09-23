//
//  LECMAddNewViewController.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEDataSource.h"

@interface LECMAddNewViewController : UIViewController

#warning свойство перенесите в *.m, а в *.h оставьте только сеттер
@property (nonatomic, strong) LEDataSource* dataSource;

@end
