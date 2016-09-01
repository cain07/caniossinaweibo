//
//  CSTabBarController.m
//  sina
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSTabBarController.h"
#import "UIImage+Image.h"

@interface CSTabBarController ()

@end

@implementation CSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpTabBarChildView];
    
    
}

-(void) setUpTabBarChildView{
    //首页
    UIViewController *home = [[UIViewController alloc]init];
    home.view.backgroundColor = [UIColor greenColor];
    
    home.tabBarItem.title = @"首页";
    home.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    
    //home.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    
    home.tabBarItem.selectedImage = [UIImage ImageWithOriganalName:@"tabbar_home_selected"];
    
    [self addChildViewController:home];
    //消息
    UIViewController *message = [[UIViewController alloc]init];
    message.view.backgroundColor = [UIColor greenColor];
    message.tabBarItem.title = @"消息";
    message.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
    [self addChildViewController:message];
    //首页
    UIViewController *discover = [[UIViewController alloc]init];
    discover.view.backgroundColor = [UIColor greenColor];
    discover.tabBarItem.title = @"发现";
     discover.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    [self addChildViewController:discover];
    //我的
    UIViewController *profile = [[UIViewController alloc]init];
    profile.view.backgroundColor = [UIColor greenColor];
    profile.tabBarItem.title = @"我的";
     profile.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    [self addChildViewController:profile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
