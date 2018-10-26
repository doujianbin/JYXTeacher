//
//  JYXPhoneBindingViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXPhoneBindingViewController.h"
#import "GetVerifyCodeView.h"
#import "JYXHomeLoginSendsmsApi.h"
#import "MyHandler.h"

@interface JYXPhoneBindingViewController ()
@property (nonatomic, strong) UITextField *phoneNumberField;
@property (nonatomic, strong) UITextField *verificationCodeField;
@property (nonatomic, strong) GetVerifyCodeView *getCodeBtn;
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
    
    [self.view addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    //获取验证码
    WeakSelf(weakSelf);
    [self.getCodeBtn setGetCodeBlock:^{
        StrongSelf(strongSelf);
        
        if (self.phoneNumberField.text.length != 11) {
            [MBProgressHUD showInfoMessage:@"请输入正确的手机号!"];
            return NO;
        }
        if ([[self.phoneNumberField.text substringToIndex:1] intValue] != 1) {
            [MBProgressHUD showInfoMessage:@"请输入正确的手机号!"];
            return NO;
        }
        [strongSelf getPhoneCode];
        return YES;
    }];
}

//获取验证码
- (void)getPhoneCode
{
    
    [self.phoneNumberField resignFirstResponder];
    JYXHomeLoginSendsmsApi *api = [[JYXHomeLoginSendsmsApi alloc] initWithPhone:self.phoneNumberField.text];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        
    } failure:^(__kindof RXBaseRequest *request) {
        
    }];
}

- (void)submitBtnAction
{
    [MyHandler changePhoneNumWith:self.phoneNumberField.text sms:self.verificationCodeField.text prepare:^{
        
    } success:^(id obj) {
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD showInfoMessage:@"修改成功！"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    } failed:^(NSInteger statusCode, id json) {
        
    }];
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
        _phoneNumberField.keyboardType = UIKeyboardTypeNumberPad;
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

- (GetVerifyCodeView *)getCodeBtn
{
    if (!_getCodeBtn) {
        _getCodeBtn = [[GetVerifyCodeView alloc] init];
        JYXViewBorderRadius(_getCodeBtn, 10, 1, [UIColor colorWithHex:0xbebebe]);
    }
    return _getCodeBtn;
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
        [_submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

@end
