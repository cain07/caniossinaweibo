//
//  CSSearchBar.m
//  sina
//
//  Created by cain on 16/9/6.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSSearchBar.h"
#import "UIImage+Image.h"
#import "UIView+Frame.h"

@implementation CSSearchBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:13];
        
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        
        iv.width += 10;
        
        iv.contentMode = UIViewContentModeCenter;
        self.leftView = iv;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

@end
