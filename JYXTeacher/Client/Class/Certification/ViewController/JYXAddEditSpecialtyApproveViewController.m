//
//  JYXAddEditSpecialtyApproveViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAddEditSpecialtyApproveViewController.h"
#import "JYXAddEditSpecialtyApproveContentView.h"

@interface JYXAddEditSpecialtyApproveViewController ()
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) JYXAddEditSpecialtyApproveContentView *contentView;
@end

@implementation JYXAddEditSpecialtyApproveViewController
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
    if (self.specialtyApprove == SpecialtyApproveAdd) {
        self.navigationItem.title = NSLocalizedString(@"添加专业认证", nil);
    } else {
        self.navigationItem.title = NSLocalizedString(@"修改专业认证", nil);
    }
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.mScrollView];
    [self.mScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.mScrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mScrollView);
        make.width.equalTo(self.mScrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
}

- (void)loadData
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:self.parameter];
    [dictM setValue:@(self.specialtyApprove) forKey:@"source"];
    [self.contentView configAddEditSpecialtyApproveViewWithData:dictM];
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (UIScrollView *)mScrollView
{
    if (!_mScrollView) {
        _mScrollView = [[UIScrollView alloc] init];
        _mScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _mScrollView;
}

- (JYXAddEditSpecialtyApproveContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[JYXAddEditSpecialtyApproveContentView alloc] init];
    }
    return _contentView;
}

@end
