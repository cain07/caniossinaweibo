//
//  CSStatus.m
//  sina
//
//  Created by cain on 16/9/14.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSStatus.h"
#import "CSPhoto.h"

@implementation CSStatus

+(NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[CSPhoto class]};
}

@end
