//
//  JYXShareEarningsViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXShareEarningsViewController.h"
#import "JYXShareEarningsContentView.h"
#import "JYXHomeBasicMyShareApi.h"
#import "JYXWithdrawViewController.h"

@interface JYXShareEarningsViewController ()
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) JYXShareEarningsContentView *contentView;
@property (nonatomic ,strong) NSDictionary * dic_data;
@end

@implementation JYXShareEarningsViewController
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
    self.navigationItem.title = NSLocalizedString(@"共享收益", nil);
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
    
    [self.contentView.applyBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeBasicMyShareApi *api = [[JYXHomeBasicMyShareApi alloc] initWithUserid:user.userId WithToken:user.token];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        self.dic_data = [api fetchDataWithReformer:request];
        [self.contentView configShareEarningViewWithData:self.dic_data];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

- (void)applyBtnAction{
//    if ([[self.dic_data objectForKey:@"c4"] doubleValue] < 100) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"低于100元不可以提现" preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//
//        }];
//        [alert addAction:cancel];
//        [self presentViewController:alert animated:YES completion:nil];
//    }else{
//        JYXWithdrawViewController *vc = [[JYXWithdrawViewController alloc] init];
//        vc.money = [[self.dic_data objectForKey:@"c4"] doubleValue];
//        vc.tixianfangshi = 5;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    JYXWithdrawViewController *vc = [[JYXWithdrawViewController alloc] init];
    vc.money = [[self.dic_data objectForKey:@"c4"] doubleValue];
    vc.tixianfangshi = 5;
    [self.navigationController pushViewController:vc animated:YES];
   
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
        _mScrollView.backgroundColor = [UIColor clearColor];
    }
    return _mScrollView;
}

- (JYXShareEarningsContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[JYXShareEarningsContentView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

@end
