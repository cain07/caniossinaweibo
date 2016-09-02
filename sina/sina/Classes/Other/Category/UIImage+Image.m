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
@end
