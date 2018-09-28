//
//  YXGShowPopAnimationView.m
//  WeLearn
//
//  Created by YXG on 2017/11/7.
//  Copyright © 2017年 WeLearn. All rights reserved.
//

#import "YXGShowPopAnimationView.h"
#import <libkern/OSAtomic.h>

@interface YXGShowPopAnimationView ()
@property (nonatomic, copy) HandleCustomActionEnvent handleCustomActionEnvent;
@property (nonatomic, strong) NSMutableArray *popViewMArray;
@end

@implementation YXGShowPopAnimationView

+ (instancetype)sharedInstance {
    static YXGShowPopAnimationView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [YXGShowPopAnimationView new];
    });
    return instance;
}

#pragma mark 显示弹框
- (void)showPopAnimationWithView:(id)customView withPopStyle:(ZJAnimationPopStyle)popStyle withDismissStyle:(ZJAnimationDismissStyle)dismissStyle withHandleAction:(HandleCustomActionEnvent)handleCustomActionEnvent
{
    // 1.初始化
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:customView popStyle:popStyle dismissStyle:dismissStyle];
    // 2.设置属性，可不设置使用默认值，见注解
    // 2.1 显示时点击背景是否移除弹框
    popView.isClickBGDismiss = YES;
    // 2.2 显示时背景的透明度
    popView.popBGAlpha = 0.6f;
    // 2.3 显示时是否监听屏幕旋转
    popView.isObserverOrientationChange = YES;
    // 2.4 显示时动画时长
    //    popView.popAnimationDuration = 0.8f;
    // 2.5 移除时动画时长
    //    popView.dismissAnimationDuration = 0.8f;
    // 2.6 显示完成回调
    popView.popComplete = ^{
        NSLog(@"显示完成");
    };
    // 2.7 移除完成回调
    popView.dismissComplete = ^{
        NSLog(@"移除完成");
    };
    
    // 3.处理自定义视图操作事件
    if (handleCustomActionEnvent) {
        _handleCustomActionEnvent = handleCustomActionEnvent;
    }
    
    self.handleCustomActionEnvent(popView, customView);
    
    // 4.显示弹框
    [popView pop];
}

- (void)showPopAnimationWithView:(id)customView
                    withClickDismiss:(BOOL)isClick
                    withPopStyle:(ZJAnimationPopStyle)popStyle
                withDismissStyle:(ZJAnimationDismissStyle)dismissStyle
                withHandleAction:(HandleCustomActionEnvent)handleCustomActionEnvent
{
    // 1.初始化
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:customView popStyle:popStyle dismissStyle:dismissStyle];
    [self.popViewMArray addObject:popView];
    // 2.设置属性，可不设置使用默认值，见注解
    // 2.1 显示时点击背景是否移除弹框
    popView.isClickBGDismiss = isClick;
    // 2.2 显示时背景的透明度
    popView.popBGAlpha = 0.6f;
    // 2.3 显示时是否监听屏幕旋转
    popView.isObserverOrientationChange = YES;
    // 2.4 显示时动画时长
    //    popView.popAnimationDuration = 0.8f;
    // 2.5 移除时动画时长
    //    popView.dismissAnimationDuration = 0.8f;
    // 2.6 显示完成回调
    popView.popComplete = ^{
        NSLog(@"显示完成");
    };
    // 2.7 移除完成回调
    popView.dismissComplete = ^{
        NSLog(@"移除完成");
        if (self.popViewMArray.count>0) [self.popViewMArray removeObjectAtIndex:0];
        if (self.popViewMArray.count>0) [(ZJAnimationPopView *)[self.popViewMArray firstObject] pop];//先添加的先显示
    };
    // 3.处理自定义视图操作事件
    if (handleCustomActionEnvent) {
        self.handleCustomActionEnvent = handleCustomActionEnvent;
    }
    
    self.handleCustomActionEnvent(popView, customView);
    
    if ([self.popViewMArray firstObject] == popView) {
        // 4.显示弹框
        [(ZJAnimationPopView *)[self.popViewMArray firstObject] pop];//先添加的先显示
    }
}

- (NSMutableArray *)popViewMArray
{
    if (!_popViewMArray) {
        _popViewMArray = [NSMutableArray array];
    }
    return _popViewMArray;
}


@end
