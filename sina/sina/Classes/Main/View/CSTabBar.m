//
//  CSTabBar.m
//  sina
//
//  Created by cain on 16/9/2.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSTabBar.h"

#include "CSBarButton.h"

@interface CSTabBar()

@property (nonatomic,weak) UIButton *pushBtn;

@property (nonatomic,weak) UIButton *selectedButton;
@property (nonatomic,strong) NSMutableArray *buttons;

@end
@implementation CSTabBar

-(NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}


-(void)setItems:(NSArray *)items{
    _items = items;
    
    for (UITabBarItem *baritem in items ) {
        CSBarButton *btn = [CSBarButton buttonWithType:UIButtonTypeCustom];
        btn.item = baritem;
        
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
        
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
    
}

// 点击tabBarButton调用
-(void)btnClick:(UIButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    // 通知tabBarVc切换控制器，
    
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}


-(UIButton *)pushBtn{
    if (_pushBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        
        _pushBtn = btn;
        
        [_pushBtn sizeToFit];
        [self addSubview:_pushBtn];
    }
    
    return _pushBtn;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"%@",self.subviews);
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.bounds.size.width/(self.items.count + 1);
    CGFloat btnH = self.bounds.size.height;
    int i = 0;
    for (UIView *tabbarBtn in self.subviews) {
        if ([tabbarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i==2) {
                i=3;
            }
            btnX = i * btnW;
            tabbarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
            
        }
    }
    
    //按钮的位置
    
    self.pushBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height *0.5);
}

@end
