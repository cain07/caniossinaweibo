//
//  CSUser.h
//  sina
//
//  Created by cain on 16/9/14.
//  Copyright © 2016年 cain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSUser : NSObject

/**
 *  微博昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  微博头像
 */
@property (nonatomic, strong) NSURL *profile_image_url;

@end
