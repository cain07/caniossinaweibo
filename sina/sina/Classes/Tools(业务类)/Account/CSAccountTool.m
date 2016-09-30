//
//  CSAccountTool.m
//  sina
//
//  Created by cain on 16/9/13.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSAccountTool.h"
#import "CSAccountParam.h"
#import "CSAccount.h"
#import "CSHttpTools.h"
#import "MJExtension.h"

#define CZAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

#define CZAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define CZClient_id     @"2389394849"
#define CZRedirect_uri  @"http://www.baidu.com"
#define CZClient_secret @"03729d16a4cd277c7da26398f7a01282"

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

+(void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure{
    // 创建参数模型
    CSAccountParam *param = [[CSAccountParam alloc] init];
    param.client_id = CZClient_id;
    param.client_secret = CZClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = CZRedirect_uri;
    
    [CSHttpTools Post:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        // 字典转模型
        CSAccount *account = [CSAccount accountWithDict:responseObject];
        
        // 保存账号信息:
        // 数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        // 以后我不想归档，用数据库，直接改业务类
        [CSAccountTool saveAccount:account];
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
