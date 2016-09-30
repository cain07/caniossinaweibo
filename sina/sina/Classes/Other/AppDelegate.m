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
#import <AVFoundation/AVFoundation.h>

#define CSVersionKey @"version"

@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
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

// 失去焦点
-(void)applicationWillResignActive:(UIApplication *)application{
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    [player prepareToPlay];
    
    player.numberOfLoops = -1;
    
    [player play];
    
    _player = player;
}

-(void)applicationDidEnterBackground:(UIApplication *)application{
   // 当后台任务结束的时候调用
    UIBackgroundTaskIdentifier utid = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:utid];
    }];
    
    // 如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
    
    // 但是苹果会检测你的程序当时有没有播放音乐，如果没有，有可能就干掉你
    
    // 微博：在程序即将失去焦点的时候播放静音音乐.

}



@end
