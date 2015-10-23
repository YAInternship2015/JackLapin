//
//  InstaUser.h
//  TinyInstaFeedObserver
//
//  Created by Jack Lapin on 21.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning у этого класса должен быть префикс приложения
@interface InstaUser : NSObject

#warning NSString *login, и так далее
@property (nonatomic, strong, readonly) NSString* login;
@property (nonatomic, strong, readonly) NSString* name;
@property (nonatomic, strong, readonly) NSString* avatarURL;

#warning есть лишние пробелы в именах методов
+ (InstaUser *)createUserWithLogin :(NSString *)login name:(NSString *)name avatarURLstring:(NSString *)avURLString;

- (NSArray *) colorsFromUserAvatar;

@end
