//
//  LELoader.h
//  TinyInstaFeedObserver
//
//  Created by Jack Lapin on 02.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEDataSource.h"

@interface LELoader : NSObject

#warning здесь есть свойства, которые не нужны в *.h, перенесите их в *.m
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *token;

@property NSArray *individualUserColorPattern;

@property(nonatomic, strong) NSURLConnection *tokenRequestConnection;

+ (id) dataLoader;
#warning этот метод вообще не должен быть виден наружу, он чисто внутренний. Загрузка постов всегда должна начинаться всегда не с прямого обращения к api клиенту, а через данный класс
- (void) parseDataDictionary:(NSDictionary *)dataDict;
@end
