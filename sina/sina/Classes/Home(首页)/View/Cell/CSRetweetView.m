//
//  CSRetweetView.m
//  sina
//
//  Created by cain on 16/10/10.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSRetweetView.h"

#import "CSStatus.h"
#import "CSStatusFrame.h"
#import "CSPhotosView.h"

@interface CSRetweetView()

// 昵称
@property (nonatomic, weak) UILabel *nameView;

// 正文
@property (nonatomic, weak) UILabel *textView;

// 配图
@property (nonatomic, weak) CSPhotosView *photosView;

@end

@implementation CSRetweetView

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
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
        
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
    // 昵称
    UILabel *nameView = [[UILabel alloc]init];
    nameView.font = CZNameFont;
    nameView.textColor = [UIColor blueColor];
    [self addSubview:nameView];
    _nameView = nameView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    
    textView.font = CZTextFont;
    textView.numberOfLines = 0;
    
    [self addSubview:textView];
    _textView = textView;
    
    // 配图
    CSPhotosView *photosView = [[CSPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
    
}


- (void)setStatusF:(CSStatusFrame *)statusF
{
    _statusF = statusF;
    
    CSStatus *status = statusF.status;
    // 昵称
    _nameView.frame = statusF.retweetNameFrame;
    _nameView.text = status.retweetName;
    
    // 正文
    _textView.frame = statusF.retweetTextFrame;
    _textView.text = status.retweeted_status.text;
    
    // 配图
    _photosView.frame = statusF.retweetPhotosFrame;
    
    _photosView.pic_urls = status.retweeted_status.pic_urls;

}



@end
