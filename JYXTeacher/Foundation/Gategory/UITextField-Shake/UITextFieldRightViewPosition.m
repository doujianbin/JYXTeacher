//
//  UITextFieldRightViewPosition.m
//  FHMall
//
//  Created by wgs on 16/5/12.
//  Copyright © 2016年 FangLin. All rights reserved.
//

#import "UITextFieldRightViewPosition.h"

/**
 *  改变TF RightViewPosition位置  不紧贴边框
 */

@implementation UITextFieldRightViewPosition

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self) {
        self = [super initWithFrame:frame];
        
        self.leftView = [self placeView];
        self.leftView.frame = CGRectMake(0, 0, 10, 13);
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.layer.borderWidth = 1.0f;
        self.borderStyle = UITextBorderStyleNone;
        self.layer.cornerRadius = 2;
    }
    return self;
}

//重写来重置文字区域
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    bounds.origin.x = bounds.origin.x+10;
    bounds.size.width = bounds.size.width-35;
    return bounds;
}


- (CGRect) rightViewRectForBounds:(CGRect)bounds {
    
    CGRect textRect = [super rightViewRectForBounds:bounds];
    textRect.origin.x -= 15;
    return textRect;
}

/**
 *  添加一个左边试图 
 *  光标不至于 紧贴边框
 */
- (UIView *)placeView
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

@end
