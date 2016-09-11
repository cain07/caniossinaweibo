//
//  CSNavigationController.m
//  sina
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSNavigationController.h"
#import "UIBarButtonItem+item.h"

@interface CSNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) id popDelegate;
@end

@implementation CSNavigationController

+(void)initialize{
    UIBarButtonItem *baritem = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [baritem setTitleTextAttributes:dict forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.interactivePopGestureRecognizer.delegate = nil;
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    
    UITabBarController *tbc = (UITabBarController *)win.rootViewController;
    
    for (UIView *baritem in tbc.tabBar.subviews) {
        if ([baritem isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [baritem removeFromSuperview];
        }
    }
}


-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count != 0) {
        NSLog(@"1111");
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backtoPre) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(bockToRoot) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [super pushViewController:viewController animated:animated];
}

-(void)backtoPre{
    [self popViewControllerAnimated:YES];
}

-(void)bockToRoot{
    [self popToRootViewControllerAnimated:YES];
}


@end
