//
//  UIBarButtonItem+item.h
//  sina
//
//  Created by cain on 16/9/6.
//  Copyright © 2016年 cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
