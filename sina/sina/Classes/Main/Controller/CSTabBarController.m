//
//  CSTabBarController.m
//  sina
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSTabBarController.h"
#import "UIImage+Image.h"
#import "CSTabBar.h"

@interface CSTabBarController ()

@end

@implementation CSTabBarController

+(void)load{
    //NSLog(@"%s",__func__);
}

+(void)initialize{
    //NSLog(@"%s",__func__);
    
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //[dic setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [item setTitleTextAttributes:dic forState:UIControlStateSelected];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CSTabBar *csTabBar = [[CSTabBar alloc] initWithFrame:self.tabBar.frame];
    
    //NSLog(@"%@",self.tabBar);
    [self setValue:csTabBar forKey:@"tabBar"];
    //NSLog(@"%@",self.tabBar);
    
    [self setUpTabBarChildView];
}

-(void) setUpTabBarChildView{
    //首页
    UIViewController *home = [[UIViewController alloc]init];
    home.view.backgroundColor = [UIColor greenColor];
 
    [self SetCSTabbarItemWithName:home title:@"首页" barImage:[UIImage imageNamed:@"tabbar_home"] selImage:[UIImage ImageWithOriganalName:@"tabbar_home_selected"]];
    
    [self addChildViewController:home];
    //消息
    UIViewController *message = [[UIViewController alloc]init];
    message.view.backgroundColor = [UIColor blueColor];
   
    [self SetCSTabbarItemWithName:message title:@"消息" barImage:[UIImage imageNamed:@"tabbar_message_center"] selImage:[UIImage ImageWithOriganalName:@"tabbar_message_center_selected"]];
    [self addChildViewController:message];
    
    //发现
    UIViewController *discover = [[UIViewController alloc]init];
    discover.view.backgroundColor = [UIColor orangeColor];

    [self SetCSTabbarItemWithName:discover title:@"发现" barImage:[UIImage imageNamed:@"tabbar_discover"] selImage:[UIImage ImageWithOriganalName:@"tabbar_discover_selected"]];
    [self addChildViewController:discover];
    //我的
    UIViewController *profile = [[UIViewController alloc]init];
    profile.view.backgroundColor = [UIColor yellowColor];
    
    [self SetCSTabbarItemWithName:profile title:@"我的" barImage:[UIImage imageNamed:@"tabbar_profile"] selImage:[UIImage ImageWithOriganalName:@"tabbar_profile_selected"]];
    [self addChildViewController:profile];
    
}

-(void)SetCSTabbarItemWithName:(UIViewController *)vc title: (NSString *)title barImage:(UIImage *)barImage selImage:(UIImage *)selImage{
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = barImage;
    
    vc.tabBarItem.badgeValue = @"29";
    vc.tabBarItem.selectedImage = selImage;
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
