//
//  constants.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const NoImage = @"NoImage";

static NSInteger countOfBackgroundColors = 20;
//NSInteger const kTableCellImagePreferedSize = 99;

static int const kColorsFromUserAvatar = 8;


#pragma mark - Stroryboard IDs

static NSString *const TableControllerID = @"LETableViewController";
static NSString *const CollectionControllerID = @"LECollectionViewController";
static NSString *const EmbedContainerID = @"EmbedContainer";

#pragma mark - Notifications

static NSString *const NotificationDataFileContentDidChange = @"NotificationDataFileContentDidChange";
static NSString *const NotificationLoginWasAcquired= @"NotificationLoginWasAcquired";
static NSString *const NotificationNewDataNeedToDownload= @"NotificationNewDataNeedToDownload";
