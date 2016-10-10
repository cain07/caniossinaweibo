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

#import "CSHttpTools.h"

#import "CSStatusTools.h"
#import "CSUserTool.h"
#import "CSStatusCell.h"

@interface CSHomeViewController ()<CSCoverDelegate>

@property (nonatomic,weak) CSTitleButton *titleButton;

@property (nonatomic, strong) CSOneViewController *one;

@property (nonatomic, strong) NSMutableArray *statuses;

/**
 *  ViewModel:CZStatusFrame
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation CSHomeViewController


- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

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
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus) ];
    [self.tableView headerBeginRefreshing];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    [CSUserTool userInfoWithSuccess:^(CSUser *user) {
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 获取当前的账号
        CSAccount *account = [CSAccountTool account];
        account.name = user.name;
        
        // 保存用户的名称
        [CSAccountTool saveAccount:account];

        
    } failure:^(NSError *error) {
        
    }];
    
   }

-(void)loadMoreStatus{
    
    NSString *maxIdStr = nil;
    if (self.statuses.count) {
        long long maxId = [[[self.statuses lastObject] idstr] longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
    }
    
    [CSStatusTools moreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        // 模型转换视图模型 CZStatus -> CZStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (CSStatus *status in statuses) {
            CSStatusFrame *statusF = [[CSStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        // 把数组中的元素添加进去
        [self.statusFrames addObjectsFromArray:statusFrames];
        
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 刷新最新的微博
- (void)refresh{
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
}

#pragma mark - 请求更多旧的微博
-(void)loadNewStatus{
    
    NSString *sinceId = nil;
    if (self.statuses.count) {
        sinceId = [self.statuses[0] idstr];
    }
    
    [CSStatusTools newStatusWithSinceId:sinceId success:^(NSArray *statuses) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        [self.tableView headerEndRefreshing];
        
        [self showNewStatusCount:statuses.count];
        
        // 模型转换视图模型 CZStatus -> CZStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (CSStatus *status in statuses) {
            CSStatusFrame *statusF = [[CSStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
 
}

#pragma mark - 展示最新的微博数
-(void)showNewStatusCount:(int)count
{
    if (count == 0) return;
    
    // 展示最新的微博数
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat x = 0;
    CGFloat w = self.view.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"最新微博数%d",count];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    // 插入导航控制器下导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    
    // 动画往下面平移
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
        
    } completion:^(BOOL finished) {
        
        
        // 往上面平移
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            
            // 还原
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
    
}


-(void) setUpBarView{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearh) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // titleView
    CSTitleButton *titleButton = [CSTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    NSString *title = [CSAccountTool account].name?:@"首页";
    
    [titleButton setTitle:title forState:UIControlStateNormal];
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
    return self.statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *ID = @"cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
    
    // 创建cell
    CSStatusCell *cell = [CSStatusCell cellWithTableView:tableView];
    
    // 获取status模型
    CSStatusFrame *statusF = self.statusFrames[indexPath.row];
    
    // 给cell传递模型
    cell.statusF = statusF;

    
    
//    // 用户昵称
//    cell.textLabel.text = status.user.name;
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    cell.detailTextLabel.text = status.text;

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 获取status模型
    CSStatusFrame *statusF = self.statusFrames[indexPath.row];
    
    return statusF.cellHeight;
}



@end
