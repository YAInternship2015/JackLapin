//
//  LECMFactory.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LECMFactory : NSObject

#warning по нашим гайдлайнам следует писать (nonatomic, strong). Также, не стоит в *.h показывать свойства с доступом readwrite, тогда его смодет изменить кто угодно извне. В *.h следует их показывать как readonly, а уже в *.m - readwrite
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, strong) NSString *imageName;

#warning init методы всегда методы экземпляра (-). Если хотите метод класса (+), то называться он должен modelWithName:
// правильно сказано. так просто не принято писать
+ (LECMFactory *)modelWithName:(NSString *)name;
//+ (LECMFactory *)initModelWithName:(NSString *)name;

@end
