//
//  CSStatusCell.m
//  sina
//
//  Created by cain on 16/10/10.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSStatusCell.h"
#import "CSOriginalView.h"
#import "CSRetweetView.h"
#import "CSStatusToolBar.h"
#import "CSStatusFrame.h"

@interface CSStatusCell()

@property (nonatomic,weak) CSOriginalView *originalView;
@property (nonatomic,weak) CSRetweetView *retweetView;
@property (nonatomic,weak) CSStatusToolBar *statusToolBar;

@end

@implementation CSStatusCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加所有子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setUpAllChildView{
    CSOriginalView *originalView = [[CSOriginalView alloc]init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    CSRetweetView *retweetView = [[CSRetweetView alloc]init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    CSStatusToolBar *statusToolBar = [[CSStatusToolBar alloc]init];
    [self addSubview:statusToolBar];
    _statusToolBar = statusToolBar;
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

/*
 问题：1.cell的高度应该提前计算出来
 2.cell的高度必须要先计算出每个子控件的frame，才能确定
 3.如果在cell的setStatus方法计算子控件的位置，会比较耗性能
 
 解决:MVVM思想
 M:模型
 V:视图
 VM:视图模型（模型包装视图模型，模型+模型对应视图的frame）
 
 
 */
- (void)setStatusF:(CSStatusFrame *)statusF
{
    _statusF = statusF;
    
    // 设置原创微博frame
    _originalView.frame = statusF.originalViewFrame;
    _originalView.statusF = statusF;
    
    // 设置原创微博frame
    _retweetView.frame = statusF.retweetViewFrame;
    _retweetView.statusF = statusF;
    
    // 设置工具条frame
    _statusToolBar.frame = statusF.toolBarFrame;
}

@end
