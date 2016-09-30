//
//  CSUserTool.m
//  sina
//
//  Created by cain on 16/9/30.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSUserTool.h"
#import "CSHttpTools.h"
#import "CSUserParam.h"
#import "CSAccountTool.h"
#import "CSUserResult.h"
#import "MJExtension.h"
@implementation CSUserTool

+(void)unreadWithSuccess:(void (^)(CSUserResult *))success failure:(void (^)(NSError *))failure{
    
    // 创建参数模型
    CSUserParam *param = [CSUserParam param];
    param.uid = [CSAccountTool account].uid;
    NSString *geturl = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    [CSHttpTools GET:geturl parameters:param.keyValues success:^(id responseObject) {
        
        CSUserResult *result = [CSUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
