//
//  CSHomeViewController.m
//  sina
//
//  Created by cain on 16/9/6.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSHomeViewController.h"
#import "UIBarButtonItem+item.h"
#import "CSOneViewController.h"

#import "CSTitleButton.h"
#import "CSPopMenu.h"
#import "CSCover.h"
#import "CSThirdViewController.h"
#import "CSStatus.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "CSAccountTool.h"

@interface CSHomeViewController ()<CSCoverDelegate>

@property (nonatomic,weak) CSTitleButton *titleButton;

@property (nonatomic, strong) CSOneViewController *one;

@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation CSHomeViewController


-(CSOneViewController *)one{
    if (_one == nil) {
        _one = [[CSOneViewController alloc] init];
    }
    
    return _one;
}

- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpBarView];
    
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus) ];
    [self.tableView headerBeginRefreshing];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
   }

-(void)loadMoreStatus{
    AFHTTPRequestOperationManager *http = [AFHTTPRequestOperationManager manager];
    NSString *geturl =  @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [CSAccountTool account].access_token;
    
    if (self.statuses.count) {
        long long maxId = [[[self.statuses lastObject] idstr] longLongValue] - 1;
        params[@"max_id"] = [NSString stringWithFormat:@"%lld",maxId];
    }
    
    [http GET: geturl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
        NSArray *dictArr = responseObject[@"statuses"];
        NSArray *statuses = (NSMutableArray *)[CSStatus objectArrayWithKeyValuesArray:dictArr];
        
        // 把数组中的元素添加进去
        [self.statuses addObjectsFromArray:statuses];
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //ss
    }];
}

#pragma mark - 请求更多旧的微博
-(void)loadNewStatus{
    AFHTTPRequestOperationManager *http = [AFHTTPRequestOperationManager manager];
    NSString *geturl =  @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [CSAccountTool account].access_token;
    
    if (self.statuses.count) {
        params[@"since_id"] = [self.statuses[0] idstr];
    }
    
    [http GET: geturl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //ss
        [self.tableView headerEndRefreshing];
        NSArray *dictArr = responseObject[@"statuses"];
        NSArray *statuses = (NSMutableArray *)[CSStatus objectArrayWithKeyValuesArray:dictArr];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        [self.statuses insertObjects:statuses atIndexes:indexSet];

        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       //ss
    }];
}

-(void) setUpBarView{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearh) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // titleView
    CSTitleButton *titleButton = [CSTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];

    titleButton.adjustsImageWhenHighlighted = NO;
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

-(void)titleClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    NSLog(@"titleClick");
    
    // 弹出蒙板
    CSCover *cover = [CSCover show];
    cover.delegate = self;
    
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    CSPopMenu *menu = [CSPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
}

-(void)pop{
    //NSLog(@"titleClick");
    
    CSOneViewController *one = [[CSOneViewController alloc] initWithNibName:nil bundle:nil];
    one.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:one animated:YES];
    
//    CSThirdViewController * vc = [[CSThirdViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)friendsearh{
   // NSLog(@"titleClick");
    CSLog(@"message");
}

-(void)coverDidClickCover:(CSCover *)cover{
    [CSPopMenu hide];
    _titleButton.selected = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 获取status模型
    CSStatus *status = self.statuses[indexPath.row];
    
    // 用户昵称
    cell.textLabel.text = status.user.name;
    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    cell.detailTextLabel.text = status.text;

    
    return cell;
}









@end
