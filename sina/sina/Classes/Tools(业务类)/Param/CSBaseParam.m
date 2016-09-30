//
//  CSBaseParam.m
//  sina
//
//  Created by cain on 16/9/30.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSBaseParam.h"
#import "CSAccountTool.h"

@implementation CSBaseParam

+(instancetype)param{
    CSBaseParam *param = [[self alloc] init];
    
    param.access_token = [CSAccountTool account].access_token;
    
    return param;
}

@end
