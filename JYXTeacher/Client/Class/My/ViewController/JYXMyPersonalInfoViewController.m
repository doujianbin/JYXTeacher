//
//  JYXMyPersonalInfoViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMyPersonalInfoViewController.h"
#import "JYXPersonalInfoView.h"
#import "JYXHomeTeacherTeacherEditApi.h"

@interface JYXMyPersonalInfoViewController ()
@property (nonatomic, strong) JYXPersonalInfoView *personalInfoView;
@end

@implementation JYXMyPersonalInfoViewController
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
    [self.personalInfoView configPersonalInfoViewWithData:@{}];
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
    self.navigationItem.title = NSLocalizedString(@"个人信息", nil);
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.personalInfoView];
    [self.personalInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadData
{
    
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (JYXPersonalInfoView *)personalInfoView
{
    if (!_personalInfoView) {
        _personalInfoView = [[JYXPersonalInfoView alloc] init];
        _personalInfoView.backgroundColor = [UIColor clearColor];
    }
    return _personalInfoView;
}

@end
