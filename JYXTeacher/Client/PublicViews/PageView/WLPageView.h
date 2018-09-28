//
//  WLPageView.h
//  WeLearn
//
//  Created by liruixuan on 17/4/21.
//  Copyright © 2017年 WeLearn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLPageView;

@protocol WLPageViewDataSource <NSObject>

@optional;
- (NSArray *)tabbatItemsInWLPageView:(WLPageView *)pageView;
- (UIViewController *)baseViewControllerInWLPageView:(WLPageView *)pageView;
- (NSInteger)numberOfControllersInWLPageView:(WLPageView *)pageView;
- (UIViewController *)WLPageView:(WLPageView *)pageView controllerAt:(NSInteger)index;

@end

@protocol WLPageViewDelegate <NSObject>

@optional;
- (void)WLPageView:(WLPageView *)slide didSwitchTo:(NSInteger)index;

@end

@interface WLPageView : UIView

@property (nonatomic, weak) id <WLPageViewDataSource> dataSource;
@property (nonatomic, weak) id <WLPageViewDelegate> delegae;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign, getter=isSwitchSlide) BOOL switchSlide;

- (void)reloadData;

@end
