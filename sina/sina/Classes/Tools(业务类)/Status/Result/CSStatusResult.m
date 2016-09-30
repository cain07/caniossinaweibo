//
//  CSStatusResult.m
//  sina
//
//  Created by cain on 16/9/30.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSStatusResult.h"
#import "CSStatus.h"

@implementation CSStatusResult

+(NSDictionary *)objectClassInArray{
    return  @{@"statuses":[CSStatus class]};
}
@end
