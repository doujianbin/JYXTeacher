//
//  JYXServiceViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXServiceViewController.h"

@interface JYXServiceViewController ()
@property (nonatomic, strong) UILabel *emailTitleLabel;
@property (nonatomic, strong) UIButton *emailBtn;
@property (nonatomic, strong) UILabel *phoneNumberTitleLabel;
@property (nonatomic, strong) UIButton *phoneNumberBtn;
@property (nonatomic, strong) UIView *vback_btnMail;
@property (nonatomic, strong) UIView *vback_btnPhone;
@end

@implementation JYXServiceViewController
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
    self.navigationItem.title = NSLocalizedString(@"联系客服", nil);
    [self loadData];
}

- (void)setupViews
{

    
    [self.view addSubview:self.emailTitleLabel];
    [self.emailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(7);
        make.top.equalTo(self.view).offset(13);
    }];
    
    [self.view addSubview:self.vback_btnMail];
    [self.vback_btnMail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.emailTitleLabel.mas_bottom).offset(13);
        make.height.offset(46);
    }];
    
    [self.view addSubview:self.emailBtn];
    [self.emailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view);
        make.top.equalTo(self.emailTitleLabel.mas_bottom).offset(13);
        make.height.offset(46);
    }];
    
    [self.view addSubview:self.phoneNumberTitleLabel];
    [self.phoneNumberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(7);
        make.top.equalTo(self.emailBtn.mas_bottom).offset(13);
    }];
    
    
    self.vback_btnPhone = [[UIView alloc]init];
    [self.vback_btnPhone setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.vback_btnPhone];
    [self.vback_btnPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.phoneNumberTitleLabel.mas_bottom).offset(13);
        make.height.offset(46);
    }];
    
    [self.view addSubview:self.phoneNumberBtn];
    [self.phoneNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view);
        make.top.equalTo(self.phoneNumberTitleLabel.mas_bottom).offset(13);
        make.height.offset(46);
    }];
}

- (void)loadData
{
    
}

- (void)tellAction{
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:010-57214966"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)mailAction{
    NSMutableString *mailUrl = [[NSMutableString alloc] init];
    //添加收件人：
    NSArray *toRecipients = @[@"service@jiaoyuxuevip.com"];
    // 注意：如有多个收件人，可以使用componentsJoinedByString方法连接，连接符为@","
    [mailUrl appendFormat:@"mailto:%@", toRecipients[0]];
    //添加抄送人：
//    NSArray *ccRecipients = @[@"1780575208@qq.com"];
//    [mailUrl appendFormat:@"?cc=%@", ccRecipients[0]];
    // 添加密送人：
//    NSArray *bccRecipients = @[@"1780575208@qq.com"];
//    [mailUrl appendFormat:@"&bcc=%@", bccRecipients[0]];
    
    //添加邮件主题和邮件内容：
//    [mailUrl appendString:@"&subject=my email"];
//    [mailUrl appendString:@"&body=<b>Hello</b> World!"];
    //打开地址，这里会跳转至邮件发送界面：
    NSString *emailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailPath]];
    
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -


- (UILabel *)emailTitleLabel
{
    if (!_emailTitleLabel) {
        _emailTitleLabel = [[UILabel alloc] init];
        _emailTitleLabel.text = NSLocalizedString(@"客服邮箱", nil);
        _emailTitleLabel.textColor = [UIColor colorWithHex:0xb5b5b5];
        _emailTitleLabel.font = FONT_SIZE(15);
        [_emailTitleLabel sizeToFit];
    }
    return _emailTitleLabel;
}

- (UIView *)vback_btnMail
{
    if (!_vback_btnMail) {
        _vback_btnMail = [[UIView alloc] init];
        [_vback_btnMail setBackgroundColor:[UIColor whiteColor]];
    }
    return _vback_btnMail;
}

//- (UIView *)_vback_btnPhone
//{
//    if (!_vback_btnPhone) {
//        _vback_btnPhone = [[UIView alloc] init];
//        [_vback_btnPhone setBackgroundColor:[UIColor redColor]];
//    }
//    return _vback_btnPhone;
//}

- (UILabel *)phoneNumberTitleLabel
{
    if (!_phoneNumberTitleLabel) {
        _phoneNumberTitleLabel = [[UILabel alloc] init];
        _phoneNumberTitleLabel.text = NSLocalizedString(@"客服电话", nil);
        _phoneNumberTitleLabel.textColor = [UIColor colorWithHex:0xb5b5b5];
        _phoneNumberTitleLabel.font = FONT_SIZE(15);
        [_phoneNumberTitleLabel sizeToFit];
    }
    return _phoneNumberTitleLabel;
}

- (UIButton *)emailBtn
{
    if (!_emailBtn) {
        _emailBtn = [[UIButton alloc] init];
        _emailBtn.backgroundColor = [UIColor whiteColor];
        _emailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_emailBtn setTitle:NSLocalizedString(@"service@jiaoyuxuevip.com", nil) forState:UIControlStateNormal];
        [_emailBtn setImage:[UIImage imageNamed:@"youxiang"] forState:UIControlStateNormal];
        [_emailBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -4, 0.0, 0.0)];
        [_emailBtn setTitleColor:[UIColor colorWithHex:0x6f6e6e6e] forState:UIControlStateNormal];
        _emailBtn.titleLabel.font = FONT_SIZE(14);
        [_emailBtn addTarget:self action:@selector(mailAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emailBtn;
}

- (UIButton *)phoneNumberBtn
{
    if (!_phoneNumberBtn) {
        _phoneNumberBtn = [[UIButton alloc] init];
        _phoneNumberBtn.backgroundColor = [UIColor whiteColor];
        _phoneNumberBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_phoneNumberBtn setTitle:NSLocalizedString(@"010-57214966（周一至周日：9:00-18:00）", nil) forState:UIControlStateNormal];
        [_phoneNumberBtn setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
        [_phoneNumberBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -4, 0.0, 0.0)];
        [_phoneNumberBtn setTitleColor:[UIColor colorWithHex:0x6f6e6e6e] forState:UIControlStateNormal];
        _phoneNumberBtn.titleLabel.font = FONT_SIZE(14);
        [_phoneNumberBtn addTarget:self action:@selector(tellAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneNumberBtn;
}

@end
