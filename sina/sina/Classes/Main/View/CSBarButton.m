//
//  CSBarButton.m
//  sina
//
//  Created by mac on 16/9/5.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSBarButton.h"

#define CSImageRidio 0.7

@implementation CSBarButton

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
        //设置颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        //图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}


//设置每一个
-(void)setItem:(UITabBarItem *)item{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    
//    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
}
// 只要监听的属性一有新值，就会调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //image
    CGFloat imagex = 0;
    CGFloat imagey = 0;
    CGFloat imagew = self.bounds.size.width;
    CGFloat imageh = self.bounds.size.height * CSImageRidio;
    self.imageView.frame = CGRectMake(imagex, imagey, imagew, imageh);
    //title
    CGFloat titlex = 0;
    CGFloat titley = imageh - 3;
    CGFloat titlew = self.bounds.size.width;
    CGFloat titleh = self.bounds.size.height - titley;
    self.titleLabel.frame = CGRectMake(titlex, titley, titlew, titleh);
    //badageview
    
}



@end
