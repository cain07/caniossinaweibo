//
//  CSUserTool.h
//  sina
//
//  Created by cain on 16/9/30.
//  Copyright © 2016年 cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSUserResult.h"

@interface CSUserTool : NSObject

/**
 *  请求用户的未读书
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(CSUserResult *result))success failure:(void(^)(NSError *error))failure;

@end
