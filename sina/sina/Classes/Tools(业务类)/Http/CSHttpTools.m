//
//  CSHttpTools.m
//  sina
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSHttpTools.h"
#import "AFNetworking.h"

@implementation CSHttpTools

+(void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{

    AFHTTPRequestOperationManager *afm = [AFHTTPRequestOperationManager manager];
    
    [afm GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
