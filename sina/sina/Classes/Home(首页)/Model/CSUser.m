//
//  CSUser.m
//  sina
//
//  Created by cain on 16/9/14.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSUser.h"

@implementation CSUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end
