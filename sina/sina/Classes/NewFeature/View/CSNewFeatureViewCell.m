//
//  CSNewFeatureViewCell.m
//  sina
//
//  Created by mac on 16/9/11.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSNewFeatureViewCell.h"

@interface CSNewFeatureViewCell()

@property (nonatomic,weak) UIImageView *imageView;

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

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}


@end
