//
//  JYXAppraiseViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAppraiseViewController.h"
#import "JYXHomeBasicLabelListApi.h"
#import "JYXAppraiseContentView.h"
#import "JYXHomeTeacherTeachercommentAddApi.h"

@interface JYXAppraiseViewController ()
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) JYXAppraiseContentView *contentView;
@end

@implementation JYXAppraiseViewController
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
    self.navigationItem.title = NSLocalizedString(@"发表评价", nil);
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
    
    WeakSelf(weakSelf);
    [weakSelf.contentView setSubmitAppraiseBlock:^(NSDictionary *dict) {
        
    }];
}

- (void)loadData
{
    JYXHomeBasicLabelListApi *api = [[JYXHomeBasicLabelListApi alloc] init];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSArray *array = [api fetchDataWithReformer:request];
        [self.contentView configAppraiseViewWithData:@{@"classid":self.parameter[@"id"],@"label":array,@"avatar":self.parameter[@"head"],@"name":self.parameter[@"studentname"],@"gradeSubject":[NSString stringWithFormat:@"%@-%@",self.parameter[@"grade"],self.parameter[@"subject"]]}];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
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

- (JYXAppraiseContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[JYXAppraiseContentView alloc] init];
    }
    return _contentView;
}

@end

