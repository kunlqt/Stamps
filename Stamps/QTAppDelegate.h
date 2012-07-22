//
//  QTAppDelegate.h
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <LiveSDK/LiveConnectClient.h>

@interface QTAppDelegate : UIResponder <UIApplicationDelegate, LiveAuthDelegate, LiveOperationDelegate, LiveDownloadOperationDelegate, LiveUploadOperationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) LiveConnectClient *liveClient;

@end
