//
//  JYXLoginViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXLoginViewController.h"
#import "JYXLoginView.h"
#import "JYXUserDelegateViewController.h"

@interface JYXLoginViewController ()
@property (nonatomic, strong) UIImageView *topBarView;
@property (nonatomic, strong) UILabel *welcomeLabel;
@property (nonatomic, strong) UILabel *visionLabel;
@property (nonatomic, strong) JYXLoginView *loginView;
@property (nonatomic, strong) UIButton *appProtocolBtn;
@end

@implementation JYXLoginViewController
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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topBarView];
    [self.topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
    }];
    
    [self.view addSubview:self.welcomeLabel];
    [self.welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Iphone6ScaleHeight(190));
        make.centerX.equalTo(self.view);
    }];
    
    [self.view addSubview:self.visionLabel];
    [self.visionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.welcomeLabel.mas_bottom).offset(17);
    }];
    
    [self.view addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(50);
    }];
    
    [self.view addSubview:self.appProtocolBtn];
    [self.appProtocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-Iphone6ScaleHeight(66));
        make.centerX.equalTo(self.view);
    }];
    
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    WeakSelf(weakSelf);
    [self.loginView setLoginSuccessBlock:^{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IsLogin];
        if (kAppDelegate.window.rootViewController == appdelegate.firstVC) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        } else {
            kAppDelegate.window.rootViewController = appdelegate.firstVC;
        }
    }];
}

- (void)loadData
{
    
}

- (void)appProtocolBtnAction{
    JYXUserDelegateViewController *vc = [[JYXUserDelegateViewController alloc]init];
    JYXBaseNavigationController *nav = [[JYXBaseNavigationController alloc]initWithRootViewController:vc];
    vc.str_title = @"用户协议";
    vc.str_url = [NSString stringWithFormat:@"%@API_DOC/help/agreement.html",API_Login];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (UIImageView *)topBarView
{
    if (!_topBarView) {
        _topBarView = [[UIImageView alloc] init];
        _topBarView.image = [UIImage imageNamed:@"Login_topBar"];
        [_topBarView sizeToFit];
    }
    return _topBarView;
}

- (UILabel *)welcomeLabel
{
    if (!_welcomeLabel) {
        _welcomeLabel = [[UILabel alloc] init];
        _welcomeLabel.textColor = [UIColor colorWithHex:0x1aabfd];
        _welcomeLabel.font = FONT_SIZE(20);
        _welcomeLabel.text = NSLocalizedString(@"欢迎您加入教予学", nil);
        [_welcomeLabel sizeToFit];
    }
    return _welcomeLabel;
}

- (UILabel *)visionLabel
{
    if (!_visionLabel) {
        _visionLabel = [[UILabel alloc] init];
        _visionLabel.text = NSLocalizedString(@"改变你的教学方式", nil);
        _visionLabel.font = FONT_SIZE(14);
        _visionLabel.textColor = [UIColor colorWithHex:0x1AABFD];
        [_visionLabel sizeToFit];
    }
    return _visionLabel;
}

- (JYXLoginView *)loginView
{
    if (!_loginView) {
        _loginView = [[JYXLoginView alloc] init];
    }
    return _loginView;
}

- (UIButton *)appProtocolBtn
{
    if (!_appProtocolBtn) {
        _appProtocolBtn = [[UIButton alloc] init];
        NSString * aStr = @"登录视为认可《教予学APP许可协议》";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",aStr]];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0] range:NSMakeRange(0,6)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#474747"]range:NSMakeRange(0,6)];
        
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0] range:NSMakeRange(6,12)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x67C8FF] range:NSMakeRange(6,12)];
        

        [_appProtocolBtn setAttributedTitle:str forState:UIControlStateNormal];
        [_appProtocolBtn setTitleColor:[UIColor colorWithHex:0x67C8FF] forState:UIControlStateNormal];
//        _appProtocolBtn.titleLabel.font = FONT_SIZE(14);
//        [_appProtocolBtn sizeToFit];
        [_appProtocolBtn addTarget:self action:@selector(appProtocolBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appProtocolBtn;
}

@end
