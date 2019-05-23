//
//  KKAppDelegate.m
//  KKWechatPayHelper
//
//  Created by BradBin on 05/19/2019.
//  Copyright (c) 2019 BradBin. All rights reserved.
//

#import "KKAppDelegate.h"
#import <KKWechatPayHelper/KKWechatPayHelper.h>

@implementation KKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [KKWechatPayManager.shared setWechatPayMode:KKWechatPayModeDetail];
    [KKWechatPayManager.shared registerApp:@"wxb4ba3c02aa476ea1" enableMTA:false];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [KKWechatPayManager.shared handleOpenURL:url options:options];
}
#else
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url NS_DEPRECATED_IOS(2_0, 9_0){
    return [KKWechatPayManager.shared handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0){
    return [KKWechatPayManager.shared handleOpenURL:url sourceApplication:sourceApplication];
}
#endif

@end
