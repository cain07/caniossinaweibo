//
//  CSCover.h
//  sina
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSCover;

@protocol CSCoverDelegate <NSObject>

@optional

// 点击蒙板的时候调用
- (void)coverDidClickCover:(CSCover *)cover;

@end


@interface CSCover : UIView
+(instancetype) show;

@property(nonatomic,assign) BOOL dimBackgroup;

@property(nonatomic,weak) id<CSCoverDelegate> delegate;

@end
