//
//  UIImage+Image.m
//  sina
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
+(instancetype)ImageWithOriganalName:(NSString *)imageName{
    UIImage *img = [UIImage imageNamed:imageName];
    
    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+(instancetype)imageWithStretchableName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
