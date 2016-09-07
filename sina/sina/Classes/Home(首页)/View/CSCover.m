//
//  CSCover.m
//  sina
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSCover.h"

@implementation CSCover

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setDimBackgroup:(BOOL)dimBackgroup
{
    _dimBackgroup = dimBackgroup;
    
    if (dimBackgroup) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    }else{
        self.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
    }
}

+(instancetype)show{
    CSCover *cover = [[CSCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    
    [CSKeyWindow addSubview:cover];
    
    return cover;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 移除蒙板
    [self removeFromSuperview];
    
    // 通知代理移除菜单
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        
        [_delegate coverDidClickCover:self];
        
    }
}

@end
