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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //self.window.backgroundColor = [UIColor yellowColor];
    
    CSNewFeatureController *newF = [[CSNewFeatureController alloc]init];
    
    self.window.rootViewController = newF;
    
    //创建tabbar
//    CSTabBarController *tbc = [[CSTabBarController alloc]init];
    
    //tbc.view.backgroundColor = [UIColor redColor];
    
//    self.window.rootViewController = tbc;
    
    
    //NSLog(@"%@",application.windows);
    
    [self.window makeKeyAndVisible];
    
    //NSLog(@"%@",application.windows);
    
    return YES;
}



@end
