//
//  YXGShowPopAnimationView.h
//  WeLearn
//
//  Created by YXG on 2017/11/7.
//  Copyright © 2017年 WeLearn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJAnimationPopView.h"

typedef void(^HandleCustomActionEnvent)(ZJAnimationPopView *popView, id customView);
@interface YXGShowPopAnimationView : NSObject

- (void)showPopAnimationWithView:(id)customView withPopStyle:(ZJAnimationPopStyle)popStyle withDismissStyle:(ZJAnimationDismissStyle)dismissStyle withHandleAction:(HandleCustomActionEnvent)handleCustomActionEnvent;

- (void)showPopAnimationWithView:(id)customView
                withClickDismiss:(BOOL)isClick
                    withPopStyle:(ZJAnimationPopStyle)popStyle
                withDismissStyle:(ZJAnimationDismissStyle)dismissStyle
                withHandleAction:(HandleCustomActionEnvent)handleCustomActionEnvent;

+ (instancetype)sharedInstance;

@end
