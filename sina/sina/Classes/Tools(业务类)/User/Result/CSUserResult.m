//
//  CSUserResult.m
//  sina
//
//  Created by cain on 16/9/30.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSUserResult.h"

@implementation CSUserResult

-(int)messageCount{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

-(int)totoalCount{
    return self.messageCount + _status + _follower;
}

@end
