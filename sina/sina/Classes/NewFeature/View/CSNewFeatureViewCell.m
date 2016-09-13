//
//  CSNewFeatureViewCell.m
//  sina
//
//  Created by mac on 16/9/11.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSNewFeatureViewCell.h"
#import "CSTabBarController.h"

@interface CSNewFeatureViewCell()

@property (nonatomic,weak) UIImageView *imageView;

@property (nonatomic, weak) UIButton *shareButton;
@property (nonatomic, weak) UIButton *startButton;

@end

@implementation CSNewFeatureViewCell

-(UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imgview = [[UIImageView alloc]init];
        
        _imageView = imgview;
        
        [self.contentView addSubview:imgview];
    }
    
    return _imageView;
}

//分享
- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        
        [self.contentView addSubview:btn];
        
        _shareButton = btn;
        
    }
    return _shareButton;
}
//开始
- (UIButton *)startButton
{
    if (_startButton == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn sizeToFit];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startButton = startBtn;
        
    }
    return _startButton;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    // 分享按钮
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    // 开始按钮
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9);
}

-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count{
    if (indexPath.row == count - 1) { // 最后一页,显示分享和开始按钮
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
        
    }else{ // 非最后一页，隐藏分享和开始按钮
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}

// 点击开始微博的时候调用
- (void)start
{
    // 进入tabBarVc
    CSTabBarController *tabBarVc = [[CSTabBarController alloc] init];
    // 切换根控制器:可以直接把之前的根控制器清空
    CSKeyWindow.rootViewController = tabBarVc;
    
}


@end
