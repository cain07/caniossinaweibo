//
//  CSTabBar.h
//  sina
//
//  Created by cain on 16/9/2.
//  Copyright © 2016年 cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSTabBar;

@protocol CSTabBarDelegate <NSObject>
@optional
- (void)tabBar:(CSTabBar *)tabBar didClickButton:(NSInteger)index;

@end


@interface CSTabBar : UIView


@property(nonatomic,strong) NSArray *items;

@property(nonatomic,weak) id<CSTabBarDelegate> delegate;

@end
