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
    self.navigationItem.title = NSLocalizedString(@"联系我们", nil);
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.emailTitleLabel];
    [self.emailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(7);
        make.top.equalTo(self.view).offset(13);
    }];
    
    [self.view addSubview:self.emailBtn];
    [self.emailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.emailTitleLabel.mas_bottom).offset(13);
        make.height.offset(46);
    }];
    
    [self.view addSubview:self.phoneNumberTitleLabel];
    [self.phoneNumberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(7);
        make.top.equalTo(self.emailBtn.mas_bottom).offset(13);
    }];
    
    [self.view addSubview:self.phoneNumberBtn];
    [self.phoneNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
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
        [_emailBtn setTitle:NSLocalizedString(@"  service@jiaoyuxuevip.com", nil) forState:UIControlStateNormal];
        [_emailBtn setTitleColor:[UIColor colorWithHex:0x6f6e6e6e] forState:UIControlStateNormal];
        _emailBtn.titleLabel.font = FONT_SIZE(14);
    }
    return _emailBtn;
}

- (UIButton *)phoneNumberBtn
{
    if (!_phoneNumberBtn) {
        _phoneNumberBtn = [[UIButton alloc] init];
        _phoneNumberBtn.backgroundColor = [UIColor whiteColor];
        _phoneNumberBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_phoneNumberBtn setTitle:NSLocalizedString(@"  010-57214966（周一至周日：9:00-18:00）", nil) forState:UIControlStateNormal];
        [_phoneNumberBtn setTitleColor:[UIColor colorWithHex:0x6f6e6e6e] forState:UIControlStateNormal];
        _phoneNumberBtn.titleLabel.font = FONT_SIZE(14);
        [_phoneNumberBtn addTarget:self action:@selector(tellAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneNumberBtn;
}

@end
