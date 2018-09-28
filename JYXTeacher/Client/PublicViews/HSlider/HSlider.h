//
//  HSlider.h
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HSlider;

@protocol HSliderDelegate <NSObject>

- (void)HSlider:(HSlider *)hSlider didScrollValue:(int)value;

@end


@interface HSlider : UIView

/**
 *  是否显示触摸视图(圆形触摸视图)
 */
@property (nonatomic) BOOL showTouchView;

/**
 *  触摸视图颜色
 */
@property (nonatomic) UIColor *touchViewColor;

/**
 *  当前数值 初始值从15开始
 */
@property (nonatomic) CGFloat currentSliderValue;

/**
 *  当前数值颜色
 */
@property (nonatomic) UIColor *currentValueColor;

/**
 *  数值显示颜色
 */
@property (nonatomic) UIColor *showTextColor;

/**
 *  滑块最大取值
 */
@property (nonatomic) CGFloat maxValue;

/**
 *  是否一直隐藏滑动数值显示视图
 */
@property (nonatomic) BOOL showScrollTextView;


/**
 *  协议
 */
@property (nonatomic,weak) id <HSliderDelegate> delegate;

@end
