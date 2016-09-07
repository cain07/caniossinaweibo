//
//  CSPopMenu.h
//  sina
//
//  Created by cain on 16/9/7.
//  Copyright © 2016年 cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSPopMenu : UIImageView


+(instancetype)showInRect:(CGRect )rect;

+(void)hide;

@property(nonatomic,weak)UIView *contentView;

@end
