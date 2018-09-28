//
//  CALayer+Extension.h
//  FHMall
//
//  Created by 马立志 on 16/4/26.
//  Copyright © 2016年 FangLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CALayer (Extension)

@property (nonatomic, assign) UIColor* borderIBColor;
@property (nonatomic, assign) UIColor* shadowIBColor;
@property (nonatomic, assign) UIColor* selectedColor;

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGPoint center;      ///< Shortcut for center.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic, getter=frameSize, setter=setFrameSize:) CGSize  size;


+ (CALayer *)creatLineLayerWithFrame:(CGRect )layerFrame color:(UIColor *)color;

+ (CALayer *)lineWithOriginY:(CGFloat)originY;

+ (CALayer *)navLineLayerWithOriginY:(CGFloat)originY;

@end
