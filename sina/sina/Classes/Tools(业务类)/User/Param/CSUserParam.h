//
//  CSUserParam.h
//  sina
//
//  Created by cain on 16/9/30.
//  Copyright © 2016年 cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSBaseParam.h"
@interface CSUserParam : CSBaseParam

/**
 *  当前登录用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

@end
