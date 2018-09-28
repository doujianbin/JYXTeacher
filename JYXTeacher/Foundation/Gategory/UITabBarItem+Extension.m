//
//  UITabBarItem+Extension.m
//  WeLearn
//
//  Created by liruixuan on 17/4/25.
//  Copyright © 2017年 WeLearn. All rights reserved.
//

#import "UITabBarItem+Extension.h"

static void *itemSize;

@implementation UITabBarItem (Extension)

- (void)setItemCustom:(NSNumber *)itemCustom
{
    objc_setAssociatedObject(self, &itemSize, itemCustom, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)itemCustom
{
    return objc_getAssociatedObject(self, &itemSize);
}

@end
