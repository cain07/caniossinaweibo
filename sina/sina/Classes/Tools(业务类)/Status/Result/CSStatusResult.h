//
//  CSStatusResult.h
//  sina
//
//  Created by cain on 16/9/30.
//  Copyright © 2016年 cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface CSStatusResult : NSObject<MJKeyValue>

/**
 *  用户的微博数组（CZStatus）
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  用户最近微博总数
 */
@property (nonatomic, assign) int *total_number;

@end
