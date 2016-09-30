//
//  CSAccountTool.h
//  sina
//
//  Created by cain on 16/9/13.
//  Copyright © 2016年 cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSAccount.h"

@interface CSAccountTool : NSObject

+ (void)saveAccount:(CSAccount *)account;

+ (CSAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
