//
//  CSStatusCell.h
//  sina
//
//  Created by cain on 16/10/10.
//  Copyright © 2016年 cain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSStatus.h"
#import "CSStatusFrame.h"

@interface CSStatusCell : UITableViewCell


@property (nonatomic, strong) CSStatusFrame *statusF;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
