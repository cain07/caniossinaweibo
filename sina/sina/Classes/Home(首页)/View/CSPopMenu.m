//
//  CSPopMenu.m
//  sina
//
//  Created by cain on 16/9/7.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSPopMenu.h"

@implementation CSPopMenu

+(instancetype)showInRect:(CGRect)rect{
    CSPopMenu *menu = [[CSPopMenu alloc] initWithFrame:rect];
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithStretchableName:@"popover_background"];
    
    [CSKeyWindow addSubview:menu];
    return menu;
}

+(void)hide{
    for (UIView *popview in CSKeyWindow.subviews) {
        if ([popview isKindOfClass:self]) {
            [popview removeFromSuperview];
        }
    }
}

-(void)setContentView:(UIView *)contentView{
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 计算内容视图尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);

}


@end
