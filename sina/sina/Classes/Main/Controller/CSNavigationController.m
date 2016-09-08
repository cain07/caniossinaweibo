//
//  CSNavigationController.m
//  sina
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSNavigationController.h"
#import "UIBarButtonItem+item.h"

@interface CSNavigationController ()

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count != 0) {
        NSLog(@"1111");
        
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backtoPre) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(bockToRoot) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
}




@end
