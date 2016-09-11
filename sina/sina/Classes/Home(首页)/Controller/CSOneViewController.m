//
//  CSOneViewController.m
//  sina
//
//  Created by cain on 16/9/9.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSOneViewController.h"
#import "CSTwoViewController.h"

@interface CSOneViewController ()

@end

@implementation CSOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    NSLog(@"%@",self.view.subviews);
}
- (IBAction)btn1click:(id)sender {
    CSTwoViewController *two = [[CSTwoViewController alloc]init];
    [self.navigationController pushViewController:two animated:YES];
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
