//
//  JYXPhoneBindingViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXPhoneBindingViewController.h"

@interface JYXPhoneBindingViewController ()
@property (nonatomic, strong) UITextField *phoneNumberField;
@property (nonatomic, strong) UITextField *verificationCodeField;
@property (nonatomic, strong) UIButton *getVerificationCodeBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation JYXPhoneBindingViewController
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
    self.navigationItem.title = NSLocalizedString(@"手机号绑定", nil);
    [self loadData];
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.phoneNumberField];
    [self.phoneNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.height.offset(43);
        make.top.equalTo(self.view).offset(13);
    }];
    
    [self.view addSubview:self.verificationCodeField];
    [self.verificationCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneNumberField);
        make.top.equalTo(self.phoneNumberField.mas_bottom).offset(22);
        make.height.offset(43);
    }];
    
    [self.view addSubview:self.getVerificationCodeBtn];
    [self.getVerificationCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.phoneNumberField);
        make.height.offset(43);
        make.centerY.equalTo(self.verificationCodeField);
        make.left.equalTo(self.verificationCodeField.mas_right).offset(15);
        make.width.offset(130);
    }];
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verificationCodeField.mas_bottom).offset(22);
        make.left.right.equalTo(self.phoneNumberField);
        make.height.offset(43);
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
- (UITextField *)phoneNumberField
{
    if (!_phoneNumberField) {
        _phoneNumberField = [[UITextField alloc] init];
        JYXViewBorderRadius(_phoneNumberField, 10, 1, [UIColor colorWithHex:0xbababa]);
        _phoneNumberField.placeholder = NSLocalizedString(@"请输入新手机号", nil);
        _phoneNumberField.textAlignment = NSTextAlignmentCenter;
        _phoneNumberField.font = FONT_SIZE(18);
        _phoneNumberField.textColor = [UIColor colorWithHex:0x666666];
    }
    return _phoneNumberField;
}

- (UITextField *)verificationCodeField
{
    if (!_verificationCodeField) {
        _verificationCodeField = [[UITextField alloc] init];
        JYXViewBorderRadius(_verificationCodeField, 10, 1, [UIColor colorWithHex:0xbababa]);
        _verificationCodeField.placeholder = NSLocalizedString(@"请输入验证码", nil);
        _verificationCodeField.textAlignment = NSTextAlignmentCenter;
        _verificationCodeField.font = FONT_SIZE(18);
        _verificationCodeField.textColor = [UIColor colorWithHex:0x666666];
    }
    return _verificationCodeField;
}

- (UIButton *)getVerificationCodeBtn
{
    if (!_getVerificationCodeBtn) {
        _getVerificationCodeBtn = [[UIButton alloc] init];
        JYXViewBorderRadius(_getVerificationCodeBtn, 10, 1, [UIColor colorWithHex:0xbababa]);
        [_getVerificationCodeBtn setTitle:NSLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
        _getVerificationCodeBtn.titleLabel.font = FONT_SIZE(18);
        [_getVerificationCodeBtn setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];
    }
    return _getVerificationCodeBtn;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        JYXViewBorderRadius(_submitBtn, 10, 0, [UIColor clearColor]);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:NSLocalizedString(@"完成", nil) forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = FONT_SIZE(18);
    }
    return _submitBtn;
}

@end
