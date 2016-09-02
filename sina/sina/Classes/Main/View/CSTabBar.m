//
//  CSTabBar.m
//  sina
//
//  Created by cain on 16/9/2.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSTabBar.h"

@interface CSTabBar()

@property (nonatomic,weak) UIButton *pushBtn;

@end
@implementation CSTabBar

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
