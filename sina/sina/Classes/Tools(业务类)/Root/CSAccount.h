//
//  CSAccount.h
//  sina
//
//  Created by cain on 16/9/13.
//  Copyright © 2016年 cain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSAccount : NSObject<NSCoding>

/**
 *  获取数据的访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

/**
 *   过期时间 = 当前保存时间+有效期
 */
@property (nonatomic,strong) NSData *expires_date;

/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *remind_in;



+ (instancetype)accountWithDict:(NSDictionary *)dict;




@end
