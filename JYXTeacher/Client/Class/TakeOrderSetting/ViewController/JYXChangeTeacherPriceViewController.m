//
//  JYXChangeTeacherPriceViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXChangeTeacherPriceViewController.h"
#import "JYXHomeTeacherTeacherEditApi.h"

@interface JYXChangeTeacherPriceViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *priceTextField;
@property (nonatomic, strong) UIButton *saveButton;
@end

@implementation JYXChangeTeacherPriceViewController
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
    self.navigationItem.title = [NSString stringWithFormat:@"%@价格预设",self.parameter[@"title"]];
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.priceTextField];
    [self.priceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
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
    self.priceTextField.text = [NSString stringWithFormat:@"%@",self.parameter[@"price"]];
}

#pragma mark - eventResponse                - Method -
- (void)saveAction:(UIButton *)btn
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    switch ([self.parameter[@"id"] integerValue]) {
        case 1:
            user.citypriceone = self.priceTextField.text;
            break;
        case 2:
            user.citypricetwo = self.priceTextField.text;
            break;
        case 3:
            user.citypricethree = self.priceTextField.text;
            break;
        case 4:
            user.citypricefour = self.priceTextField.text;
            break;
        case 5:
            user.citypricefive = self.priceTextField.text;
            break;
        case 6:
            user.citypricesix = self.priceTextField.text;
            break;
        case 7:
            user.citypriceseven = self.priceTextField.text;
            break;
        case 8:
            user.citypriceeight = self.priceTextField.text;
            break;
        case 9:
            user.citypricenine = self.priceTextField.text;
            break;
        case 10:
            user.citypriceten = self.priceTextField.text;
            break;
        case 11:
            user.citypriceeleven = self.priceTextField.text;
            break;
        case 12:
            user.citypricetwelve = self.priceTextField.text;
            break;
        default:
            break;
    }
    
    JYXHomeTeacherTeacherEditApi *api = [[JYXHomeTeacherTeacherEditApi alloc] initWithUserid:user.userId token:user.token cardname:user.cardname citypriceone:user.citypriceone citypricetwo:user.citypricetwo citypricethree:user.citypricethree citypricefour:user.citypricefour citypricefive:user.citypricefive citypricesix:user.citypricesix citypriceseven:user.citypriceseven citypriceeight:user.citypriceeight citypricenine:user.citypricenine citypriceten:user.citypriceten citypriceeleven:user.citypriceeleven citypricetwelve:user.citypricetwelve];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSNumber *isSuccess = [api fetchDataWithReformer:request];
        if (isSuccess.boolValue) {
            [MBProgressHUD showInfoMessage:@"修改成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - customDelegate               - Method -
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *price = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//    if (price.doubleValue <= [self.parameter[@"price"] doubleValue]) {
////        [MBProgressHUD showInfoMessage:@"设置价格不能比平台默认价格低"];
//        price = self.parameter[@"price"];
//    }
    textField.text = price;
}

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (UITextField *)priceTextField
{
    if (!_priceTextField) {
        _priceTextField = [[UITextField alloc] init];
        _priceTextField.delegate = self;
        _priceTextField.keyboardType = UIKeyboardTypeNumberPad;
        _priceTextField.backgroundColor = [UIColor whiteColor];
        _priceTextField.font = FONT_SIZE(18);
        _priceTextField.textColor = [UIColor colorWithHex:0x5d5d5d];
        _priceTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 0)];
        _priceTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _priceTextField;
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
