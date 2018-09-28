//
//  UIButton+Extension.h
//  YiXiuGe
//
//  Created by liruixuan on 17/3/30.
//  Copyright © 2017年 YiXiuGe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

typedef void (^TouchedBlock)(NSInteger tag);

@interface UIButton (Extension)

/**
 *  Click on the button how much time interval is not responding
 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

/**
 *  With the background color of different color Settings button state (the default background color is not change with state)
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor
                  forState:(UIControlState)state;
/**
 *  Add block repalce addtarget
 */
- (void)addActionHandler:(TouchedBlock)touchHandler;

/**
 *  图片居上 title居下
 */
- (void)verticalImageAndTitle:(CGFloat)spacing;

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
