//
//  WLPageView.m
//  WeLearn
//
//  Created by liruixuan on 17/4/21.
//  Copyright © 2017年 WeLearn. All rights reserved.
//

#import "WLPageView.h"
#import "DLSlideView.h"
#import "DLLRUCache.h"

@interface WLPageView () <DLSlideViewDataSource, DLSlideViewDelegate>

@property (nonatomic, strong) DLSlideView *slideView;
@property (nonatomic, strong) DLLRUCache *cache;

@end

@implementation WLPageView

#pragma mark - lifeCycle                    - Method -

- (void)dealloc
{
    NSLog(@"WLPageView -----> dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
//    [self addSubview:self.toolBar];
    
    self.slideView = [[DLSlideView alloc] init];
    self.slideView.dataSource = self;
    self.slideView.delegate = self;
    [self addSubview:self.slideView];
    [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.cache = [[DLLRUCache alloc] initWithCount:4];
}

//- (void)segmentedControlChangedValue:(HMSegmentedControl *)sender
//{
//    [self setSelectedIndex:sender.selectedSegmentIndex];
//}

#pragma mark - eventResponse                - Method -
- (void)reloadData
{
    self.slideView.baseViewController = [self.dataSource baseViewControllerInWLPageView:self];
//    self.toolBar.sectionTitles = [self.dataSource tabbatItemsInWLPageView:self];
}

#pragma mark - customDelegate               - Method -

#pragma mark - DLSlideViewDataSource
- (NSInteger)numberOfControllersInDLSlideView:(DLSlideView *)sender
{
    return [self.dataSource numberOfControllersInWLPageView:self];
}

- (UIViewController *)DLSlideView:(DLSlideView *)sender controllerAt:(NSInteger)index
{
    NSString *key = [NSString stringWithFormat:@"%ld", (long)index];
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    } else {
        UIViewController *vc = [self.dataSource WLPageView:self controllerAt:index];
        [self.cache setObject:vc forKey:key];
        return vc;
    }
}

- (void)DLSlideView:(DLSlideView *)slide didSwitchTo:(NSInteger)index
{
    if ([_delegae respondsToSelector:@selector(WLPageView:didSwitchTo:)]) {
        [_delegae WLPageView:self didSwitchTo:index];
    }
}

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -

- (void)setSwitchSlide:(BOOL)switchSlide
{
    self.slideView.switchSlide = switchSlide;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    self.slideView.selectedIndex = selectedIndex;
}

@end
