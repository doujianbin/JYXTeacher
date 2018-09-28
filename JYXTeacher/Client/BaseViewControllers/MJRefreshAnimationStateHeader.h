//
//  MJRefreshHealthStateHeader.h
//  DocChat-C-iphone
//
//  Created by lixiao on 2017/10/16.
//  Copyright © 2017年 juliye. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

typedef NS_ENUM(NSUInteger, MJHeaderTag) {
    MJHeaderNormal,
    MJHeaderHealth,
};
@interface MJRefreshAnimationStateHeader : MJRefreshStateHeader

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state;

@property (nonatomic,assign)MJHeaderTag   headerTag;

@end
