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
#import "CSProfileViewController.h"
#import "CSMessageViewController.h"
#import "CSDiscoverViewController.h"
#import "CSHomeViewController.h"
#import "CSUserTool.h"
#import "CSNavigationController.h"

@interface CSTabBarController ()<CSTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) CSHomeViewController *home;
@property (nonatomic, weak) CSProfileViewController *profile;
@property (nonatomic,weak) CSMessageViewController *message;


@end

@implementation CSTabBarController

-(NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    for (UIView *baritem in self.tabBar.subviews) {
//        if ([baritem isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [baritem removeFromSuperview];
//        }
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpTabBarChildView];
    
    [self setupTabBar];
    
    //[self getUnRead];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(getUnRead) userInfo:nil repeats:YES];
}

-(void)getUnRead{
    [CSUserTool unreadWithSuccess:^(CSUserResult *result) {
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totoalCount;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)setupTabBar
{
    CSTabBar *tabbar = [[CSTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabbar.backgroundColor = [UIColor whiteColor];
    tabbar.delegate = self;
    
    tabbar.items = self.items;
    [self.tabBar addSubview:tabbar];
    
    //[self.tabBar removeFromSuperview];
    
}

-(void) setUpTabBarChildView{
    //首页
    CSHomeViewController *home = [[CSHomeViewController alloc]init];
 
    [self SetCSTabbarItemWithName:home title:@"首页" barImage:[UIImage imageNamed:@"tabbar_home"] selImage:[UIImage ImageWithOriganalName:@"tabbar_home_selected"]];
    _home = home;

    //消息
    CSMessageViewController *message = [[CSMessageViewController alloc]init];
    
   
    [self SetCSTabbarItemWithName:message title:@"消息" barImage:[UIImage imageNamed:@"tabbar_message_center"] selImage:[UIImage ImageWithOriganalName:@"tabbar_message_center_selected"]];
    //[/self addChildViewController:message];
    _message = message;
    //发现
    CSDiscoverViewController *discover = [[CSDiscoverViewController alloc]init];

    [self SetCSTabbarItemWithName:discover title:@"发现" barImage:[UIImage imageNamed:@"tabbar_discover"] selImage:[UIImage ImageWithOriganalName:@"tabbar_discover_selected"]];
   // [self addChildViewController:discover];
    //我的
//    UIViewController *profile = [[UIViewController alloc]init];
//    profile.view.backgroundColor = [UIColor yellowColor];
    
    CSProfileViewController *profile = [[CSProfileViewController alloc]init];
    
    [self SetCSTabbarItemWithName:profile title:@"我的" barImage:[UIImage imageNamed:@"tabbar_profile"] selImage:[UIImage ImageWithOriganalName:@"tabbar_profile_selected"]];
    //[self addChildViewController:profile];
    _profile = profile;
    
}

-(void)SetCSTabbarItemWithName:(UIViewController *)vc title: (NSString *)title barImage:(UIImage *)barImage selImage:(UIImage *)selImage{
    
    vc.title = title;
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = barImage;
    
    //vc.tabBarItem.badgeValue = @"29";
    vc.tabBarItem.selectedImage = selImage;
    
    [self.items addObject:vc.tabBarItem];
    CSNavigationController *nvc = [[CSNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nvc];
}

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(CSTabBar *)tabBar didClickButton:(NSInteger)index
{
    if (index == 0 && self.selectedIndex == index) { // 点击首页，刷新
        [_home refresh];
    }
    self.selectedIndex = index;
}


@end
