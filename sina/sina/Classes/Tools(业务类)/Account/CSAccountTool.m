//
//  CSAccountTool.m
//  sina
//
//  Created by cain on 16/9/13.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSAccountTool.h"

#import "CSAccount.h"

#define CZAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation CSAccountTool

// 类方法一般用静态变量代替成员属性
static CSAccount *_account;

+(void)saveAccount:(CSAccount *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:CZAccountFileName];
}

+(CSAccount *)account{
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:CZAccountFileName];
        
        // 判断下账号是否过期，如果过期直接返回Nil
        // 2015 < 2017
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) { // 过期
            return nil;
        }
    }
    
    return _account;
}

@end
