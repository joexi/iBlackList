//
//  BLAppDelegate.m
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLAppDelegate.h"
#import "BLRootViewController.h"
@implementation BLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [BLBlackListManager addObserver];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    BLRootViewController *rootViewController = [[BLRootViewController alloc]init];
    self.window.rootViewController = rootViewController;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /* runnning in background */
    if ([[UIDevice currentDevice] isMultitaskingSupported]) {
        //Check if device supports mulitasking
        UIApplication *application = [UIApplication sharedApplication];
        //Get the shared application instance
        __block UIBackgroundTaskIdentifier background_task;
        //Create a task object
        background_task = [application beginBackgroundTaskWithExpirationHandler: ^ {
            [application endBackgroundTask: background_task];
            /** Tell the system that we are done with the tasks **/
            background_task = UIBackgroundTaskInvalid;
            /** Set the task to be invalid **/
            /** System will be shutting down the app at any point in time now **/
        }];
        /** Background tasks require you to use asyncrous tasks **/
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"\n\nRunning in the background!\n\n");
        });
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
