//
//  UIView+HExtension.m
//  WeLearn
//
//  Created by YXG on 2018/1/11.
//  Copyright © 2018年 WeLearn. All rights reserved.
//

#import "UIView+HExtension.h"

@implementation UIView (HExtension)

- (CGFloat)h_top {
    return self.frame.origin.y;
}

- (void)setH_top:(CGFloat)h_top {
    CGRect frame = self.frame;
    frame.origin.y = h_top;
    self.frame = frame;
}

- (CGFloat)h_left {
    return self.frame.origin.x;
}

- (void)setH_left:(CGFloat)h_left {
    CGRect frame = self.frame;
    frame.origin.x = h_left;
    self.frame = frame;
}


- (CGFloat)h_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setH_right:(CGFloat)h_right {
    self.h_x = h_right - self.h_width;
}


- (CGFloat)h_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setH_bottom:(CGFloat)h_bottom {
    self.h_y = h_bottom - self.h_height;
}

- (void)setH_x:(CGFloat)h_x {
    CGRect frame = self.frame;
    frame.origin.x = h_x;
    self.frame = frame;
}

- (void)setH_y:(CGFloat)h_y
{
    CGRect frame = self.frame;
    frame.origin.y = h_y;
    self.frame = frame;
}

- (CGFloat)h_x
{
    return self.frame.origin.x;
}

- (CGFloat)h_y
{
    return self.frame.origin.y;
}

- (void)setH_centerX:(CGFloat)h_centerX
{
    CGPoint center = self.center;
    center.x = h_centerX;
    self.center = center;
}

- (CGFloat)h_centerX
{
    return self.center.x;
}

- (void)setH_centerY:(CGFloat)h_centerY
{
    CGPoint center = self.center;
    center.y = h_centerY;
    self.center = center;
}

- (CGFloat)h_centerY
{
    return self.center.y;
}

- (void)setH_width:(CGFloat)h_width
{
    CGRect frame = self.frame;
    frame.size.width = h_width;
    self.frame = frame;
}

- (void)setH_height:(CGFloat)h_height
{
    CGRect frame = self.frame;
    frame.size.height = h_height;
    self.frame = frame;
}

- (CGFloat)h_height
{
    return self.frame.size.height;
}

- (CGFloat)h_width
{
    return self.frame.size.width;
}

- (void)setH_size:(CGSize)h_size
{
    CGRect frame = self.frame;
    frame.size = h_size;
    self.frame = frame;
}

- (CGSize)h_size
{
    return self.frame.size;
}

- (void)setH_origin:(CGPoint)h_origin
{
    CGRect frame = self.frame;
    frame.origin = h_origin;
    self.frame = frame;
}

- (CGPoint)h_origin
{
    return self.frame.origin;
}
@end
