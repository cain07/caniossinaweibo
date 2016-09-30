//
//  CSStatusTools.m
//  sina
//
//  Created by cain on 16/9/30.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSStatusTools.h"
#import "CSHttpTools.h"
#import "CSAccountTool.h"
#import "CSStatus.h"
#import "CSStatusParam.h"
#import "CSStatusResult.h"

@implementation CSStatusTools

+(void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    NSString *geturl =  @"https://api.weibo.com/2/statuses/friends_timeline.json";
    
    CSStatusParam *params = [[CSStatusParam alloc]init];
    params.access_token = [CSAccountTool account].access_token;
    
    //NSMutableDictionary *params = [NSMutableDictionary dictionary];
   // params[@"access_token"] = [CSAccountTool account].access_token;
    
    if (sinceId) {
        //params[@"since_id"] = sinceId;
        params.since_id = sinceId;
    }
    
    [CSHttpTools GET:geturl parameters:params.keyValues success:^(id responseObject) {
        
        CSStatusResult *result = [CSStatusResult objectWithKeyValues:responseObject];
//        NSArray *dictArr = responseObject[@"statuses"];
//        NSArray *statuses = (NSMutableArray *)[CSStatus objectArrayWithKeyValuesArray:dictArr];
        
        if (success) {
            success(result.statuses);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
      
}

+(void)moreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    CSStatusParam *params = [[CSStatusParam alloc]init];
    params.access_token = [CSAccountTool account].access_token;

    NSString *geturl =  @"https://api.weibo.com/2/statuses/friends_timeline.json";
    
    if (maxId) {
        params.max_id = maxId;
    }

    [CSHttpTools GET:geturl parameters:params.keyValues success:^(id responseObject) {
        // 结束上拉刷新

        CSStatusResult *result = [CSStatusResult objectWithKeyValues:responseObject];

        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        //
        if (failure) {
            failure(error);
        }
    }];
    
}


@end
