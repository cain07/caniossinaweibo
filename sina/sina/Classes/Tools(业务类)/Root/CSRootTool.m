//
//  CSRootTool.m
//  sina
//
//  Created by cain on 16/9/13.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSRootTool.h"
#import "CSTabBarController.h"
#import "CSNewFeatureController.h"

#define CSVersionKey @"version"

@implementation CSRootTool

+(void)chooseRootViewController:(UIWindow *)window{
    //版本号
    NSString *versionNo = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:CSVersionKey];
    
    if ([versionNo isEqualToString:lastVersion]) {
        //创建tabbar
        CSTabBarController *tbc = [[CSTabBarController alloc]init];
        //tbc.view.backgroundColor = [UIColor redColor];
        window.rootViewController = tbc;
    }else{
        CSNewFeatureController *newF = [[CSNewFeatureController alloc]init];
        
        window.rootViewController = newF;
        
        [[NSUserDefaults standardUserDefaults] setObject:versionNo forKey:CSVersionKey];
    }

}
@end
