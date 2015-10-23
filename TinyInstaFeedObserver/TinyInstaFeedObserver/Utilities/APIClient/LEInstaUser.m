//
//  InstaUser.m
//  TinyInstaFeedObserver
//
//  Created by Jack Lapin on 21.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LEInstaUser.h"
#import "CCColorCube.h"

@interface LEInstaUser ()

@property (readwrite) NSString *login;
@property (readwrite) NSString *name;
@property (readwrite) NSString *avatarURL;

@end

@implementation LEInstaUser

+ (LEInstaUser *)createUserWithLogin:(NSString *)login name:(NSString *)name avatarURLstring:(NSString *)avURLString {
    LEInstaUser * user = [[LEInstaUser alloc] init];
    user.login = login;
    user.name = name;
    user.avatarURL = avURLString;
    return user;
}

- (NSArray *)colorsFromUserAvatar{
    NSURL *imgURL =[NSURL URLWithString:self.avatarURL];
    NSData *userAvData = [NSData dataWithContentsOfURL:imgURL];
    UIImage *image = [UIImage imageWithData:userAvData];
    CCColorCube *colorCube = [[CCColorCube alloc] init];
    NSArray *arr =[colorCube extractBrightColorsFromImage:image avoidColor:[UIColor blackColor] count:kColorsFromUserAvatar];
    return arr;
}

@end
