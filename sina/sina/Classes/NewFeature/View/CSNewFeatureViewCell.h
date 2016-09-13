//
//  CSNewFeatureViewCell.h
//  sina
//
//  Created by mac on 16/9/11.
//  Copyright © 2016年 cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSNewFeatureViewCell : UICollectionViewCell

@property (nonatomic,weak) UIImage *image;

// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end
