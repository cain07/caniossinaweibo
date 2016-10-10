//
//  CSStatusToolBar.m
//  sina
//
//  Created by cain on 16/10/10.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSStatusToolBar.h"

@implementation CSStatusToolBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpAllChildView];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
    
}

@end
