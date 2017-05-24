//
//  AppDelegate.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/25.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "AppDelegate.h"
#import "DJFMainTabBarController.h"
#import "DJFDBManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setUpConfig];
    [self openDBorCreateTable];
    _window = [[UIWindow alloc]initWithFrame:SCREEN_BOUNDS];
    _window.rootViewController = [DJFMainTabBarController new];
    [_window makeKeyAndVisible];

    
    return YES;
}

//初始化应用配置
- (void)setUpConfig{
    //测试地图
    [AMapServices sharedServices].apiKey = gaoDeMapKey;
    //开启https
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    
    
   
    
}
-(void)openDBorCreateTable{
    [[DJFDBManager sharedManager]openDB:@"healthy.db"];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
