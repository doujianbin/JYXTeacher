//
//  JYXLoginView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXLoginView.h"
#import "GetVerifyCodeView.h"
#import "JYXHomeLoginSendsmsApi.h"
#import "JYXHomeLoginTeacherloginApi.h"
#import "JYXHomeMesRongcloudApi.h"
#import "MyHandler.h"

@interface JYXLoginView ()
@property (nonatomic, strong) UIView *phoneBgView;
@property (nonatomic, strong) UIImageView *phoneImg;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UIView *verificationCodeBgView;
@property (nonatomic, strong) UIImageView *verificationCodeImg;
@property (nonatomic, strong) UITextField *verificationCodeField;
@property (nonatomic, strong) GetVerifyCodeView *getCodeBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation JYXLoginView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self addSubview:self.phoneBgView];
    [self.phoneBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.offset(38);
//        make.width.offset(SCREEN_WIDTH - 20);
    }];
    
    [self.phoneBgView addSubview:self.phoneImg];
    [self.phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.phoneBgView);
        make.left.equalTo(self.phoneBgView).offset(10);
        make.width.offset(17);
        make.height.offset(24);
    }];
    
    [self.phoneBgView addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneImg.mas_right).offset(5);
        make.top.right.bottom.equalTo(self.phoneBgView);
    }];
    
    [self addSubview:self.verificationCodeBgView];
    [self.verificationCodeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneBgView.mas_bottom).offset(19);
        make.left.equalTo(self.phoneBgView);
        make.width.offset(SCREEN_WIDTH * 0.485);
        make.height.offset(38);
    }];
    
    [self.verificationCodeBgView addSubview:self.verificationCodeImg];
    [self.verificationCodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.verificationCodeBgView);
        make.left.equalTo(self.verificationCodeBgView).offset(10);
        make.width.offset(17);
        make.height.offset(24);
    }];
    
    [self.verificationCodeBgView addSubview:self.verificationCodeField];
    [self.verificationCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verificationCodeImg.mas_right).offset(5);
        make.top.right.bottom.equalTo(self.verificationCodeBgView);
    }];
    
    [self addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verificationCodeBgView.mas_right).offset(7);
        make.right.equalTo(self.phoneBgView);
//        make.width.offset(103);
        make.height.offset(38);
        make.top.equalTo(self.verificationCodeBgView);
    }];
    
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verificationCodeBgView.mas_bottom).offset(43);
        make.left.right.equalTo(self.phoneBgView);
//        make.height.offset(40);
        make.bottom.equalTo(self);
    }];
    
    //获取验证码
    WeakSelf(weakSelf);
    [self.getCodeBtn setGetCodeBlock:^{
        StrongSelf(strongSelf);

        if (self.phoneField.text.length != 11) {
            [MBProgressHUD showInfoMessage:@"请输入正确的手机号!"];
            return NO;
        }
        if ([[self.phoneField.text substringToIndex:1] intValue] != 1) {
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
    
    [self.phoneField resignFirstResponder];
    JYXHomeLoginSendsmsApi *api = [[JYXHomeLoginSendsmsApi alloc] initWithPhone:self.phoneField.text];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        
    } failure:^(__kindof RXBaseRequest *request) {
        
    }];
}

//登录
- (void)loginAction:(UIButton *)btn
{
    if ([self.phoneField.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请输入手机号"];
        return;
    }
    if (self.phoneField.text.length != 11) {
        [MBProgressHUD showInfoMessage:@"请输入正确的手机号!"];
        return;
    }
    if ([[self.phoneField.text substringToIndex:1] intValue] != 1) {
        [MBProgressHUD showInfoMessage:@"请输入正确的手机号!"];
        return;
    }
    if ([self.verificationCodeField.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请输入验证码"];
        return;
    }
    JYXHomeLoginTeacherloginApi *api = [[JYXHomeLoginTeacherloginApi alloc] initWithPhone:self.phoneField.text withSMS:self.verificationCodeField.text];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        [[NSUserDefaults standardUserDefaults]setObject:self.phoneField.text forKey:TeacherPhone];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        NSLog(@"%@",dict);
        //上传注册id

        //上传推送注册id
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:Registionid] length] > 0) {

            [MyHandler pushJpushRegistionidWithRegistionid:[[NSUserDefaults standardUserDefaults] valueForKey:Registionid] prepare:^{

            } success:^(id obj) {

            } failed:^(NSInteger statusCode, id json) {

            }];
        }

        if (self.loginSuccessBlock) {
            self.loginSuccessBlock();
        }

        //登录成功连接融云
        [self loginRongYun];

    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

- (void)loginRongYun
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeMesRongcloudApi *api = [[JYXHomeMesRongcloudApi alloc] initWithUserId:@(user.teacherId.integerValue) username:user.nickname type:@1];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        [[RCIM sharedRCIM] connectWithToken:dict[@"token"]  success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            JYXUser *user = [JYXUserManager shareInstance].user;
            [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:user.cardname portrait:user.avatar];
            [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

- (UIView *)phoneBgView
{
    if (!_phoneBgView) {
        _phoneBgView = [[UIView alloc] init];
        JYXViewBorderRadius(_phoneBgView, 10, 1, [UIColor colorWithHex:0xbebebe]);
    }
    return _phoneBgView;
}

- (UIImageView *)phoneImg
{
    if (!_phoneImg) {
        _phoneImg = [[UIImageView alloc] init];
        _phoneImg.image = [UIImage imageNamed:@"Login_phone"];
        _phoneImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _phoneImg;
}

- (UITextField *)phoneField
{
    if (!_phoneField) {
        _phoneField = [[UITextField alloc] init];
        _phoneField.placeholder = NSLocalizedString(@"请输入你的手机号", nil);
        _phoneField.textColor = [UIColor colorWithHex:0x6d6d6d];
        _phoneField.font = FONT_SIZE(16);
        _phoneField.keyboardType = UIKeyboardTypePhonePad;
        [_phoneField sizeToFit];
    }
    return _phoneField;
}

- (UIImageView *)verificationCodeImg
{
    if (!_verificationCodeImg) {
        _verificationCodeImg = [[UIImageView alloc] init];
        _verificationCodeImg.image = [UIImage imageNamed:@"Login_password"];
        _verificationCodeImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _verificationCodeImg;
}

- (UITextField *)verificationCodeField
{
    if (!_verificationCodeField) {
        _verificationCodeField = [[UITextField alloc] init];
        _verificationCodeField.placeholder = NSLocalizedString(@"请输入验证码", nil);
        _verificationCodeField.textColor = [UIColor colorWithHex:0x6d6d6d];
        _verificationCodeField.font = FONT_SIZE(16);
        _verificationCodeField.keyboardType = UIKeyboardTypeNumberPad;
        [_verificationCodeField sizeToFit];
    }
    return _verificationCodeField;
}

- (UIView *)verificationCodeBgView
{
    if (!_verificationCodeBgView) {
        _verificationCodeBgView = [[UIView alloc] init];
        JYXViewBorderRadius(_verificationCodeBgView, 10, 1, [UIColor colorWithHex:0xbebebe]);
    }
    return _verificationCodeBgView;
}

- (GetVerifyCodeView *)getCodeBtn
{
    if (!_getCodeBtn) {
        _getCodeBtn = [[GetVerifyCodeView alloc] init];
        JYXViewBorderRadius(_getCodeBtn, 10, 1, [UIColor colorWithHex:0xbebebe]);
    }
    return _getCodeBtn;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"Login_button"] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

@end
