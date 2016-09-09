//
//  CSOneViewController.m
//  sina
//
//  Created by cain on 16/9/7.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSOneViewController.h"
#import "CSTitleButton.h"
#import "CSHomeViewController.h"
#import "UIBarButtonItem+item.h"
#import "CSTwoViewController.h"

@interface CSOneViewController ()

@end

@implementation CSOneViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}



//-(void)backtoPre{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//-(void)bockToRoot{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnAction:(id)sender {
    
    CSTwoViewController *two = [[CSTwoViewController alloc] init];
    
    [self.navigationController pushViewController:two animated:YES];
}
@end
