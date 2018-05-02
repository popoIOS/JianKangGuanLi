//
//  AppDelegate.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/23.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [NSThread sleepForTimeInterval:10];
    self.window.backgroundColor = [UIColor whiteColor];
    /*
     设置IQKeyBoard键盘
     */
    [self setIQKeyBoard];
    /*
     主页面展示
     */
    [self setMainViewController];
    
    return YES;
}

#pragma mark------IQKeyBoard
-(void)setIQKeyBoard{
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
#pragma mark------主页面展示
-(void)setMainViewController{
    
    HomeViewController *home = [[HomeViewController alloc]init];
    home.tabBarItem.title = @"首页";
    home.title = @"首页";
    home.tabBarItem.image = [UIImage imageNamed:@"d1_h"];
    home.tabBarItem.selectedImage = [UIImage imageNamed:@"d1"];
    BaseNavigationController *navHome = [[BaseNavigationController alloc]initWithRootViewController:home];
    
    
    HealthDataViewController *healthData = [[HealthDataViewController alloc]init];
    healthData.tabBarItem.title = @"健康数据";
//    healthData.title = @"健康数据";
    healthData.tabBarItem.image = [UIImage imageNamed:@"d2_h"];
    healthData.tabBarItem.selectedImage = [UIImage imageNamed:@"d2"];
    BaseNavigationController *navhealthData = [[BaseNavigationController alloc]initWithRootViewController:healthData];
    
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.tabBarItem.title = @"个人中心";
    personal.title = @"个人中心";
    personal.tabBarItem.image = [UIImage imageNamed:@"d4_h"];
    personal.tabBarItem.selectedImage = [UIImage imageNamed:@"d4"];
    BaseNavigationController *navPersonal = [[BaseNavigationController alloc]initWithRootViewController:personal];
    
    UITabBarController *tabBar =[[UITabBarController alloc]init];
    tabBar.viewControllers = @[navHome,navhealthData,navPersonal];
    self.window.rootViewController = tabBar;
    [self.window makeKeyWindow];
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
