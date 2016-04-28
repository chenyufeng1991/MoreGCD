//
//  AppDelegate.m
//  MoreGCD
//
//  Created by chenyufeng on 16/4/28.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    self.tabController = [[UITabBarController alloc] init];

    FirstViewController *first = [[FirstViewController alloc] init];
    first.title = @"第一页";
    SecondViewController *second = [[SecondViewController alloc] init];
    second.title = @"第二页";

    UINavigationController *naviFirst = [[UINavigationController alloc] initWithRootViewController:first];
    UINavigationController *naviSecond = [[UINavigationController alloc] initWithRootViewController:second];

    self.tabController.viewControllers = @[naviFirst,naviSecond];
    self.window.rootViewController = self.tabController;

    [self.window makeKeyAndVisible];

    return YES;
}

@end
