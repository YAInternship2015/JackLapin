//
//  LEDataSource.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//
#import "CMconstants.h"
#import "LEDataSource.h"
#import "LECMFactory.h"

@interface LEDataSource ()

@property (strong, nonatomic) NSArray *CMfactoriesArray;

@end


@implementation LEDataSource

#pragma mark - Lifecycle

- (instancetype)initWithDelegate:(id<CMDataSourceDelegate>)delegate {
    self = [self init];
    if (self) {
        self.delegate = delegate;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadArrayWithPlist)
                                                     name:NotificationDataFileContentDidChange object:nil];
        [self loadArrayWithPlist];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - DataSource methods

- (void)loadArrayWithPlist {
    _CMfactoriesArray = [NSArray arrayWithContentsOfFile:[NSString documentsFolderPath]];
#warning перед тем, как вызвать у делегата метод, который был объявлен в протоколе делегата, необходимо убедиться, что делегат действительно реализовал этот метод. Для этого существует метод respondsToSelector:... , иначе можно словить креш
    [self.delegate dataWasChanged:self];
}

- (NSUInteger)countModels {
    return [self.CMfactoriesArray count];
}

- (NSDictionary *)modelForIndex:(NSInteger)index {
    return self.CMfactoriesArray[index];
}

- (void)reloadArrayWithPlist {
    [self loadArrayWithPlist];
}

+ (void)copyPlistToAppDocumentsFolder {
    NSString *documentsPath = [NSString documentsFolderPath];
    NSString *resourcesPath = [NSString resourcesFolderPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    if ([fileManager fileExistsAtPath:documentsPath] == NO) {
        [fileManager copyItemAtPath:resourcesPath toPath:documentsPath error:&error];
    }
}

#pragma mark - DataManage methods

+ (void)addCM:(LECMFactory *)cmObject {
#warning преобразование модели в NSDictionary должно быть реализовано в категории на модель в методе -dictionaryRepresentation
    NSDictionary *newModel = @{@"name" : cmObject.name,@"imageName" : NoImage};
    
    NSMutableArray *tempModelsArray = [NSMutableArray arrayWithContentsOfFile:[NSString documentsFolderPath]];
    [tempModelsArray addObject:newModel];
    
    if ([tempModelsArray writeToFile:[NSString documentsFolderPath] atomically:YES]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationDataFileContentDidChange object:nil];
    } else {
        NSLog(@"New object not added");
    }
}

@end
