//
//  AppDelegate.m
//  sina
//
//  Created by cain on 16/9/1.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "AppDelegate.h"
#import "CSTabBarController.h"
#import "CSNewFeatureController.h"
#import "CSOAuthViewController.h"
#import "CSAccountTool.h"
#import "CSRootTool.h"

#define CSVersionKey @"version"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //self.window.backgroundColor = [UIColor yellowColor];
    // 选择根控制器
    // 判断下有没有授权
    // 进行授权

    if ([CSAccountTool account]) {
        [CSRootTool chooseRootViewController:self.window];
    }else{
        CSOAuthViewController *oauthVc = [[CSOAuthViewController alloc] init];
        // 设置窗口的根控制器
        self.window.rootViewController = oauthVc;
    }
    
    [self.window makeKeyAndVisible];

    return YES;
}



@end
