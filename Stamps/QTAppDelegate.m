//
//  QTAppDelegate.m
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import "QTAppDelegate.h"

@implementation QTAppDelegate
@synthesize window;
@synthesize liveClient;


#pragma mark - Skydrive Authentication
- (void)authCompleted:(LiveConnectSessionStatus) status
              session:(LiveConnectSession *) session
            userState:(id) userState
{
    if ([userState isEqual:@"initialize"])
    {
//        [self.infoLabel setText:@"Initialized."];
//        [self.liveClient login:self
//                        scopes:[NSArray arrayWithObjects:@"wl.signin", nil]
//                      delegate:self
//                     userState:@"signin"];
    }
    if ([userState isEqual:@"signin"])
    {
        if (session != nil)
        {
//            [self.infoLabel setText:@"Signed in."];
        }
    }
}

- (void)authFailed:(NSError *) error
         userState:(id)userState
{
//    [self.infoLabel setText:[NSString stringWithFormat:@"Error: %@", [error localizedDescription]]];
}


#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.liveClient = [[LiveConnectClient alloc] initWithClientId:@"000000004C0C5C04" delegate:self userState:@"initialize"];
    [Parse setApplicationId:@"qWX6ogCHsgN5HzhZ31oUSABt27iHMP0kaV2w03wx"
                  clientKey:@"4U4xif0nz8iWkK452pa9zDq7JEd8Y8nsO8vKYrpm"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
