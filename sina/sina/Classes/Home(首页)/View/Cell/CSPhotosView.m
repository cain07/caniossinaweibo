//
//  CSPhotosView.m
//  sina
//
//  Created by cain on 16/10/11.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSPhotosView.h"
#import "CSPhoto.h"
#import "UIImageView+WebCache.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "CSPhotoView.h"

@implementation CSPhotosView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //        self.backgroundColor = [UIColor redColor];
        
        // 添加9个子控件
        
        [self setUpAllChildView];
        
    }
    return self;
}


// 添加9个子控件
- (void)setUpAllChildView
{
    for (int i = 0; i < 9; i++) {
            #warning TODO：设置配图的内容模式
        CSPhotoView *imageV = [[CSPhotoView alloc] init];

        imageV.contentMode = UIViewContentModeScaleAspectFill;
        // 裁剪图片，超出控件的部分裁剪掉
        imageV.clipsToBounds = YES;
        
        imageV.tag = i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [imageV addGestureRecognizer:tap];
        
        [self addSubview:imageV];
    }
}

#pragma mark - 点击图片的时候调用
- (void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView = tap.view;
    // CZPhoto -> MJPhoto
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (CSPhoto *photo in _pic_urls) {
        
        MJPhoto *p = [[MJPhoto alloc] init];
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url = [NSURL URLWithString:urlStr];
        p.index = i;
        p.srcImageView = tapView;
        [arrM addObject:p];
        i++;
    }
    
    
    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    // MJPhoto
    brower.photos = arrM;
    brower.currentPhotoIndex = tapView.tag;
    [brower show];
}


- (void)setPic_urls:(NSArray *)pic_urls
{
    // 4
    _pic_urls = pic_urls;
    int count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        
        UIImageView *imageV = self.subviews[i];
        
        if (i < _pic_urls.count) { // 显示
            imageV.hidden = NO;
            
            // 获取CZPhoto模型
            CSPhoto *photo = _pic_urls[i];
            
            // 赋值
            [imageV sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            
        }else{
            imageV.hidden = YES;
        }
        
    }
    
}

// 计算尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count==4?2:3;
    // 计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
    
    
}


@end
