//
//  JYXChangeNicknameViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/31.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXChangeNicknameViewController.h"
#import "JYXHomeTeacherTeacherEditApi.h"

@interface JYXChangeNicknameViewController ()
@property (nonatomic, strong) UITextField *nicknameTextField;
@property (nonatomic, strong) UIButton *saveButton;
@end

@implementation JYXChangeNicknameViewController
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
    self.navigationItem.title = NSLocalizedString(@"修改昵称", nil);
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.nicknameTextField];
    [self.nicknameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.offset(50);
    }];
    [self.view addSubview:self.saveButton];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.offset(50);
    }];
}

- (void)loadData
{
    self.nicknameTextField.text = [NSString stringWithFormat:@"%@",self.parameter[@"nickname"]];
}

#pragma mark - eventResponse                - Method -
- (void)saveAction:(UIButton *)btn
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherTeacherEditApi *api = [[JYXHomeTeacherTeacherEditApi alloc] initWithUserid:user.userId token:user.token cardname:user.cardname nick:self.nicknameTextField.text sex:nil];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSNumber *isSuccess = [api fetchDataWithReformer:request];
        if (isSuccess.boolValue) {
            [WLToast show:@"修改成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (UITextField *)nicknameTextField
{
    if (!_nicknameTextField) {
        _nicknameTextField = [[UITextField alloc] init];
//        _nicknameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _nicknameTextField.backgroundColor = [UIColor whiteColor];
        _nicknameTextField.font = FONT_SIZE(18);
        _nicknameTextField.textColor = [UIColor colorWithHex:0x5d5d5d];
        _nicknameTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 0)];
        _nicknameTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _nicknameTextField;
}

- (UIButton *)saveButton
{
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] init];
        _saveButton.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        [_saveButton setTitle:NSLocalizedString(@"保存", nil) forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveButton.titleLabel.font = FONT_SIZE(18);
        [_saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        [_saveButton sizeToFit];
    }
    return _saveButton;
}

@end
