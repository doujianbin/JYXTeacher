//
//  JYXAccountManageViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAccountManageViewController.h"
#import "JYXAccountManageView.h"
#import "MyHandler.h"

@interface JYXAccountManageViewController ()
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) JYXAccountManageView *alipayView;
@property (nonatomic, strong) JYXAccountManageView *wechatView;
@property (nonatomic, strong) JYXAccountManageView *bankCardView;
@property (nonatomic, strong) JYXAccountManageView *nameView;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UILabel *accountRemarkLabel;
@property (nonatomic ,strong) NSDictionary *dic_data;
@end

@implementation JYXAccountManageViewController
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
    self.navigationItem.title = NSLocalizedString(@"账户管理", nil);
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
    
    [self.contentView addSubview:self.alipayView];
    [self.alipayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(19);
        make.top.equalTo(self.contentView).offset(28);
        make.right.equalTo(self.contentView).offset(-19);
        make.height.offset(58);
    }];
    
    [self.contentView addSubview:self.wechatView];
    [self.wechatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(19);
        make.top.equalTo(self.alipayView.mas_bottom).offset(25);
        make.right.equalTo(self.contentView).offset(-19);
        make.height.offset(58);
    }];
    
    [self.contentView addSubview:self.bankCardView];
    [self.bankCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(19);
        make.top.equalTo(self.wechatView.mas_bottom).offset(25);
        make.right.equalTo(self.contentView).offset(-19);
        make.height.offset(58);
    }];
    
    [self.contentView addSubview:self.nameView];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(19);
        make.top.equalTo(self.bankCardView.mas_bottom).offset(25);
        make.right.equalTo(self.contentView).offset(-19);
        make.height.offset(58);
    }];
    
    [self.contentView addSubview:self.saveBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameView.mas_bottom).offset(87);
        make.centerX.equalTo(self.contentView);
        make.width.offset(241);
        make.height.offset(46);
    }];
    
    [self.contentView addSubview:self.accountRemarkLabel];
    [self.accountRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(34);
        make.right.equalTo(self.contentView).offset(-34);
        make.top.equalTo(self.saveBtn.mas_bottom).offset(76);
        make.bottom.equalTo(self.contentView).offset(-35);
    }];
}

- (void)loadData
{
    [MyHandler teacherPayNumWithUserType:2 weixin:nil zhifubao:nil yinlian:nil cardname:nil prepare:^{
        
    } success:^(id obj) {
        self.dic_data = (NSDictionary *)obj;
        if ([self.dic_data[@"zhifubao"] length] > 0) {
            self.alipayView.accountField.text = self.dic_data[@"zhifubao"];
        }
        if ([self.dic_data[@"weixin"] length] > 0) {
            self.wechatView.accountField.text = self.dic_data[@"weixin"];
        }
        if ([self.dic_data[@"yinlian"] length] > 0) {
            self.bankCardView.accountField.text = self.dic_data[@"yinlian"];
        }
        if ([self.dic_data[@"cardname"] length] > 0) {
            self.nameView.accountField.text = self.dic_data[@"cardname"];
        }
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

#pragma mark - eventResponse                - Method -
//保存设置
- (void)saveAction:(UIButton *)btn
{
    if (self.bankCardView.accountField.text.length > 0 && self.nameView.accountField.text.length <= 0) {
        [MBProgressHUD showInfoMessage:@"请输入姓名"];
        return;
    }
    if (self.bankCardView.accountField.text.length <= 0 && self.nameView.accountField.text.length > 0) {
        [MBProgressHUD showInfoMessage:@"请输入银联卡号"];
        return;
    }
    [MyHandler teacherPayNumWithUserType:2 weixin:self.wechatView.accountField.text zhifubao:self.alipayView.accountField.text yinlian:self.bankCardView.accountField.text cardname:self.nameView.accountField.text prepare:^{
        
    } success:^(id obj) {
        [self.navigationController popViewControllerAnimated:YES];
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
        _mScrollView.backgroundColor = [UIColor clearColor];
    }
    return _mScrollView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (JYXAccountManageView *)alipayView
{
    if (!_alipayView) {
        _alipayView = [[JYXAccountManageView alloc] init];
        _alipayView.placeholderStr = NSLocalizedString(@"请输入支付宝账号", nil);
        _alipayView.iconImg = [UIImage imageNamed:@"alipay"];
    }
    return _alipayView;
}

- (JYXAccountManageView *)wechatView
{
    if (!_wechatView) {
        _wechatView = [[JYXAccountManageView alloc] init];
        _wechatView.placeholderStr = NSLocalizedString(@"请输入微信账号", nil);
        _wechatView.iconImg = [UIImage imageNamed:@"wechatPay"];
    }
    return _wechatView;
}

- (JYXAccountManageView *)bankCardView
{
    if (!_bankCardView) {
        _bankCardView = [[JYXAccountManageView alloc] init];
        _bankCardView.placeholderStr = NSLocalizedString(@"请输入银行卡账号", nil);
        _bankCardView.iconImg = [UIImage imageNamed:@"unionPay"];
    }
    return _bankCardView;
}

- (JYXAccountManageView *)nameView
{
    if (!_nameView) {
        _nameView = [[JYXAccountManageView alloc] init];
        _nameView.placeholderStr = NSLocalizedString(@"请输入您的姓名", nil);
        _nameView.iconImg = [UIImage imageNamed:@"userIcon"];
    }
    return _nameView;
}

- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc] init];
        _saveBtn.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        [_saveBtn setTitle:NSLocalizedString(@"保存", nil) forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = FONT_SIZE(18);
        JYXViewBorderRadius(_saveBtn, 23, 0, [UIColor clearColor]);
        [_saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (UILabel *)accountRemarkLabel
{
    if (!_accountRemarkLabel) {
        _accountRemarkLabel = [[UILabel alloc] init];
        _accountRemarkLabel.font = FONT_SIZE(12);
        _accountRemarkLabel.numberOfLines = 0;
        _accountRemarkLabel.textColor = [UIColor colorWithHex:0xa3a3a3];
        _accountRemarkLabel.text = NSLocalizedString(@"账户信息涉及退费，提现等操作，如因您填写错误而造成损失，平台概不负责，请认真填写。", nil);
        [_accountRemarkLabel sizeToFit];
    }
    return _accountRemarkLabel;
}

@end
