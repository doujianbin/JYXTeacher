//
//  JYXShareListViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXShareListViewController.h"
#import "HMSegmentedControl.h"
#import "WLPageView.h"
#import "JYXShareListChildViewController.h"

@interface JYXShareListViewController ()<WLPageViewDataSource, WLPageViewDelegate>
@property (nonatomic, strong) WLPageView *pageView;
@property (nonatomic, strong) NSMutableArray *vcArrM;
@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@end

@implementation JYXShareListViewController
#pragma mark - lifeCycle                    - Method -

- (void)dealloc
{
    
}

- (void)loadView
{
    [super loadView];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"已共享列表", nil);
    NSArray *titleArray = @[@"直接共享",@"间接共享"];
    self.segmentedControl.sectionTitles = titleArray;
    for (int i=0; i<titleArray.count; i++) {
        JYXShareListChildViewController *vc = [[JYXShareListChildViewController alloc] init];
        [self.vcArrM addObject:vc];
    }
    
    [self.pageView reloadData];
    [self.pageView setSelectedIndex:0];
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.topBarView];
    [self.topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.offset(38);
    }];
    
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.offset(38);
    }];
    
    [self.view addSubview:self.pageView];
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)loadData
{
    
}

#pragma mark - eventResponse                - Method -
#pragma mark HMSegmentedControlAction
- (void)segmentedControlChangedValue:(HMSegmentedControl *)sender
{
    [self.pageView setSelectedIndex:sender.selectedSegmentIndex];
}


#pragma mark - customDelegate               - Method -
#pragma mark WLPageVeiwDataSource
- (NSInteger)numberOfControllersInWLPageView:(WLPageView *)pageView
{
    return self.vcArrM.count;
}

- (UIViewController *)baseViewControllerInWLPageView:(WLPageView *)pageView
{
    return self;
}

- (UIViewController *)WLPageView:(WLPageView *)pageView controllerAt:(NSInteger)index
{
    return self.vcArrM[index];
}

#pragma mark WLPageVeiwDelegate
- (void)WLPageView:(WLPageView *)slide didSwitchTo:(NSInteger)index
{
    [self.segmentedControl setSelectedSegmentIndex:index animated:YES];
}

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (HMSegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:nil];
        [_segmentedControl addTarget:self
                              action:@selector(segmentedControlChangedValue:)
                    forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectionIndicatorHeight = 2.0f;
        _segmentedControl.backgroundColor = [UIColor clearColor];
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:FONT_SIZE(15)};
        _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithHex:0xfefefe Alpha:0.4], NSFontAttributeName:FONT_SIZE(15)};
        _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.shouldAnimateUserSelection = YES;
    }
    return _segmentedControl;
}

- (WLPageView *)pageView
{
    if (!_pageView) {
        _pageView = [[WLPageView alloc] init];
        _pageView.dataSource = self;
        _pageView.delegae = self;
        _pageView.switchSlide = YES;
    }
    return _pageView;
}

- (UIView *)topBarView
{
    if (!_topBarView) {
        _topBarView = [[UIView alloc] init];
        _topBarView.layer.contents = (id)[UIImage imageNamed:@"navBarBg"].CGImage;
    }
    return _topBarView;
}

- (NSMutableArray *)vcArrM
{
    if (!_vcArrM) {
        _vcArrM = [NSMutableArray array];
    }
    return _vcArrM;
}

@end
