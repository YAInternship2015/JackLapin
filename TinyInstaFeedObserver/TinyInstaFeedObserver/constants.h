//
//  constants.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark UI constants and dimentions

static NSString *const NoImage = @"NoImage";
static int const kCellImagePreferedSize = 99;
static int const kColorsFromUserAvatar = 8;

#pragma mark Data Model Attributes names

static NSString *const kModelId = @"modelID";
static NSString *const kModelDecription = @"caption";
static NSString *const kModelImg = @"imageURL";
static NSString *const kModelDateAdded = @"dateAdded";

#pragma mark Instagram connect 

static NSString *const kTokenRequestURL = @"https://api.instagram.com/oauth/access_token";
static NSString *const kBaseRequestURL = @"https://api.instagram.com/v1/tags/automotive/media/recent?";
static NSString *const kAuthRequestURL = @"https://api.instagram.com/oauth/authorize/";
static NSString *const kClientID = @"26b5f5babdea4c788158b2e892094435";
static NSString *const kClientSecret = @"5d8c265251f0435cb910e1b74745840e";
static NSString *const kGrant_type = @"authorization_code";
static NSString *const kRedirectURI = @"tinyInstaFeedObserver://";
static NSString *const kScope = @"basic+likes";
static NSString *const kResponseType = @"code&scope=basic+likes";

#pragma mark - Stroryboard IDs

static NSString *const TableControllerID = @"LETableViewController";
static NSString *const CollectionControllerID = @"LECollectionViewController";
static NSString *const EmbedContainerID = @"EmbedContainer";

#pragma mark - Notifications

static NSString *const NotificationDataFileContentDidChange = @"NotificationDataFileContentDidChange";
static NSString *const NotificationLoginWasAcquired= @"NotificationLoginWasAcquired";
static NSString *const NotificationNewDataNeedToDownload= @"NotificationNewDataNeedToDownload";
static NSString *const NotificationUserAvatarPrepare= @"NotificationUserAvatarPrepare";
