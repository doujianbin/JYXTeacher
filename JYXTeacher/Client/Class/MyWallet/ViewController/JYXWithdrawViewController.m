//
//  JYXWithdrawViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXWithdrawViewController.h"
#import "JYXWithdrawContentView.h"
#import "MyHandler.h"
#import "JYXAccountManageViewController.h"

@interface JYXWithdrawViewController ()
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) JYXWithdrawContentView *contentView;
@property (nonatomic, assign) int selectIndex;  // 支付宝1 微信2
@end

@implementation JYXWithdrawViewController
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
    self.navigationItem.title = NSLocalizedString(@"提现", nil);
    [self loadData];
}

- (void)setupViews
{
    self.selectIndex = 999;
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
    [self.contentView.totalAmountLabel setText:[NSString stringWithFormat:@"可提现金额：￥%.2f",self.money]];
    
    [self.contentView.alipayButton addTarget:self action:@selector(alipayButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView.alipaySelectBtn addTarget:self action:@selector(alipayButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView.wechatPayButton addTarget:self action:@selector(wechatButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView.wechatPaySelectBtn addTarget:self action:@selector(wechatButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView.submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData
{
    
}

#pragma mark - eventResponse                - Method -

- (void)alipayButtonAction{
    self.selectIndex = 1;
//    [self.contentView.alipaySelectBtn setBackgroundImage:[UIImage imageNamed:@"paymentBtn_Sel"] forState:UIControlStateNormal];
    [self.contentView.alipaySelectBtn setImage:[UIImage imageNamed:@"paymentBtn_Sel"] forState:UIControlStateNormal];
    [self.contentView.wechatPaySelectBtn setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
}

- (void)wechatButtonAction{
    self.selectIndex = 2;
//    [self.contentView.alipaySelectBtn setBackgroundImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
//    [self.contentView.wechatPaySelectBtn setBackgroundImage:[UIImage imageNamed:@"paymentBtn_Sel"] forState:UIControlStateNormal];
    [self.contentView.wechatPaySelectBtn setImage:[UIImage imageNamed:@"paymentBtn_Sel"] forState:UIControlStateNormal];
    [self.contentView.alipaySelectBtn setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
}

- (void)submitBtnAction{
    if ([self.contentView.inputMoneyField.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请输入提现金额"];
        return;
    }
    if (self.selectIndex == 999) {
        [MBProgressHUD showInfoMessage:@"请选择提现方式"];
        return;
    }
    if ([self.contentView.inputMoneyField.text floatValue] > self.money) {
        [MBProgressHUD showInfoMessage:@"提现金额不能大于可提现金额"];
        return;
    }    

    [MyHandler teacherCashTargettype:2 accounttype:self.tixianfangshi money:self.contentView.inputMoneyField.text account:self.selectIndex prepare:^{
        
    } success:^(id obj) {
        NSDictionary *dic = (NSDictionary *)obj;
        if ([[dic objectForKey:@"code"] intValue] == 1000) {
            [MBProgressHUD showSuccessMessage:@"申请提现成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([[dic objectForKey:@"code"] intValue] == 1001){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未设置提现账户" message:@"是否立即设置？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *again = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                JYXAccountManageViewController *vc = [[JYXAccountManageViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }];
            [again setValue:[UIColor colorWithHexString:@"#bebebe"] forKey:@"titleTextColor"];
            [cancel setValue:[UIColor colorWithHexString:@"#1caafe"] forKey:@"titleTextColor"];
            [alert addAction:again];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showInfoMessage:[dic objectForKey:@"msg"]];
        }
        
    } failed:^(NSInteger statusCode, id json) {
        
    }];
    
    
}

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

- (JYXWithdrawContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[JYXWithdrawContentView alloc] init];
    }
    return _contentView;
}

@end
