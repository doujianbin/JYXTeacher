//
//  MJRefreshHealthStateHeader.m
//  DocChat-C-iphone
//
//  Created by lixiao on 2017/10/16.
//  Copyright © 2017年 juliye. All rights reserved.
//

#import "MJRefreshAnimationStateHeader.h"
//#import "PrefixHeader.pch"

@interface MJRefreshAnimationStateHeader()
@property (weak, nonatomic) UIImageView *gifView;
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;
@end

@implementation MJRefreshAnimationStateHeader

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations
{
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}

#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.mj_h) {
        self.mj_h = image.size.height;
    }
}

- (void)setImages:(NSArray *)images forState:(MJRefreshState)state
{
    [self setImages:images duration:images.count * 0.04 forState:state];
}

#pragma mark - 实现父类的方法
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    if ([self.scrollView isDragging]) {
        if (self.headerTag == MJHeaderNormal) {
            [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        }else if (self.headerTag == MJHeaderHealth){
             [self setTitle:@"下拉推荐" forState:MJRefreshStateIdle];
        }
    }else{
        if (self.headerTag == MJHeaderNormal) {
            [self setTitle:@"正在刷新数据中..." forState:MJRefreshStateIdle];
        }else if (self.headerTag == MJHeaderHealth){
            [self setTitle:@"推荐中" forState:MJRefreshStateIdle];
        }
    }
    NSArray *images = self.stateImages[@(MJRefreshStateIdle)];
    if (self.state != MJRefreshStateIdle || images.count == 0) return;
    // 停止动画
    [self.gifView stopAnimating];
    // 设置当前需要显示的图片
    NSUInteger index =  images.count * pullingPercent;
    if (index >= images.count) index = images.count - 1;
    self.gifView.image = images[index];
}


- (void)placeSubviews
{
    [super placeSubviews];
    
    self.gifView.frame = self.bounds;
    self.gifView.contentMode = UIViewContentModeCenter;

}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
    }
}

- (void)prepare{
    [super prepare];
    self.mj_h = 61;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.stateLabel.frame = CGRectMake(0,self.mj_h - 12 - 12, self.mj_w, 12);
    self.stateLabel.font = [UIFont systemFontOfSize:10];
    self.stateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.gifView.frame = CGRectMake(self.mj_w/2 - 20,self.mj_h - 12 - 12 - 7 - 20, 40, 20);
}

@end
