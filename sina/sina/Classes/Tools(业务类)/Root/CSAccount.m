//
//  CSAccount.m
//  sina
//
//  Created by cain on 16/9/13.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSAccount.h"
#import "MJExtension.h"

#define CZAccountTokenKey @"token"
#define CZUidKey @"uid"
#define CZExpires_inKey @"exoires"
#define CZExpires_dateKey @"date"

@implementation CSAccount

MJCodingImplementation
+(instancetype)accountWithDict:(NSDictionary *)dict{
    CSAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    return account;
}


//-(void)encodeWithCoder:(NSCoder *)aCoder{
//    [aCoder encodeObject:_access_token forKey:CZAccountTokenKey];
//    [aCoder encodeObject:_expires_in forKey:CZExpires_inKey];
//    [aCoder encodeObject:_uid forKey:CZUidKey];
//    [aCoder encodeObject:_expires_date forKey:CZExpires_dateKey];
//}
//
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super init]) {
//        
//        // 一定要记得赋值
//        _access_token =  [aDecoder decodeObjectForKey:CZAccountTokenKey];
//        _expires_in = [aDecoder decodeObjectForKey:CZExpires_inKey];
//        _uid = [aDecoder decodeObjectForKey:CZUidKey];
//        _expires_date = [aDecoder decodeObjectForKey:CZExpires_dateKey];
//    }
//    return self;
//}


-(void)setExpires_in:(NSString *)expires_in{
    _expires_in = expires_in;
    // 计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

@end
