//
//  JYXBaseInfoContentView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXBaseInfoContentView.h"
#import "JYXBaseInfoItemView.h"
#import "JYXCertificationMaterialsViewController.h"
#import "JYXHomeTeacherTeacherEditApi.h"
#import "MyHandler.h"

@interface JYXBaseInfoContentView ()<UITextFieldDelegate,UITextViewDelegate>


@property (nonatomic, strong) UIView *realNameBgView;
@property (nonatomic, strong) UILabel *realNameTitleLabel;
@property (nonatomic, strong) UITextField *realNameField;
@property (nonatomic, strong) UILabel *realNameRemarkLabel;

@property (nonatomic, strong) JYXBaseInfoItemView *sexView;
@property (nonatomic, strong) JYXBaseInfoItemView *educationView;
@property (nonatomic, strong) JYXBaseInfoItemView *workDateView;

@property (nonatomic, strong) UIView *affiliatedUnitBgView;
@property (nonatomic, strong) UILabel *affiliatedUnitTitleLabel;
@property (nonatomic, strong) UITextField *affiliatedUnitField;
@property (nonatomic, strong) UIButton *affiliatedUnitTypeBtn;

@property (nonatomic, strong) UIView *showHiddenBgView;
@property (nonatomic, strong) UILabel *showHiddenTitleLabel;
@property (nonatomic, strong) UISwitch *showHiddenSwitch;
@property (nonatomic, strong) UILabel *showHiddenRemarkLabel;

@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UITextView *introduceTextView;
@property (nonatomic, strong) UILabel *wordNumberLabel;

@property (nonatomic, strong) UILabel *introduceDetailLabel;

@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, strong) PGDatePickManager *yearAndMonthAndDayDatePickManager;
@end

@implementation JYXBaseInfoContentView
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
    [self addSubview:self.realNameBgView];
    [self.realNameBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.right.equalTo(self).offset(-7);
        make.top.equalTo(self).offset(23);
        make.height.offset(65);
    }];
    
    [self.realNameBgView addSubview:self.realNameTitleLabel];
    [self.realNameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.realNameBgView).offset(11);
        make.width.offset(130);
        make.centerY.equalTo(self.realNameBgView).offset(-10);
    }];
    
    [self.realNameBgView addSubview:self.realNameField];
    [self.realNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.realNameTitleLabel.mas_right);
        make.centerY.equalTo(self.realNameBgView).offset(-10);
        make.right.equalTo(self.realNameBgView).offset(-11);
    }];
    
    [self.realNameBgView addSubview:self.realNameRemarkLabel];
    [self.realNameRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(17);
        make.top.equalTo(self.realNameTitleLabel.mas_bottom).offset(6);
        make.right.equalTo(self).offset(-17);
    }];
    
    [self addSubview:self.sexView];
    [self.sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.right.equalTo(self).offset(-7);
        make.top.equalTo(self.realNameRemarkLabel.mas_bottom).offset(18);
        make.height.offset(45);
    }];
    
    [self addSubview:self.educationView];
    [self.educationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.right.equalTo(self).offset(-7);
        make.height.offset(45);
        make.top.equalTo(self.sexView.mas_bottom).offset(5);
    }];
    
    [self addSubview:self.workDateView];
    [self.workDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.right.equalTo(self).offset(-7);
        make.height.offset(45);
        make.top.equalTo(self.educationView.mas_bottom).offset(5);
    }];
    
    [self addSubview:self.affiliatedUnitBgView];
    [self.affiliatedUnitBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.right.equalTo(self).offset(-7);
        make.height.offset(45);
        make.top.equalTo(self.workDateView.mas_bottom).offset(10);
    }];
    
    [self.affiliatedUnitBgView addSubview:self.affiliatedUnitTitleLabel];
    [self.affiliatedUnitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.affiliatedUnitBgView).offset(11);
        make.width.offset(90);
        make.centerY.equalTo(self.affiliatedUnitBgView);
    }];
    
    [self.affiliatedUnitBgView addSubview:self.affiliatedUnitField];
    [self.affiliatedUnitField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.affiliatedUnitTitleLabel.mas_right);
        make.centerY.equalTo(self.affiliatedUnitBgView);
    }];
    
    [self.affiliatedUnitBgView addSubview:self.affiliatedUnitTypeBtn];
    [self.affiliatedUnitTypeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [self.affiliatedUnitTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.affiliatedUnitBgView);
        make.width.offset(92);
        make.left.equalTo(self.affiliatedUnitField.mas_right).offset(5);
    }];
    
    [self addSubview:self.showHiddenBgView];
    [self.showHiddenBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.right.equalTo(self).offset(-7);
        make.height.offset(70);
        make.top.equalTo(self.affiliatedUnitBgView.mas_bottom).offset(1);
    }];
    
    [self.showHiddenBgView addSubview:self.showHiddenTitleLabel];
    [self.showHiddenTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.showHiddenBgView).offset(11);
        make.top.equalTo(self.showHiddenBgView).offset(13);
    }];
    
    [self.showHiddenBgView addSubview:self.showHiddenSwitch];
    [self.showHiddenSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.showHiddenBgView).offset(-11);
        make.centerY.equalTo(self.showHiddenTitleLabel);
    }];
    
    [self.showHiddenBgView addSubview:self.showHiddenRemarkLabel];
    [self.showHiddenRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.showHiddenBgView).offset(11);
        make.bottom.equalTo(self.showHiddenBgView).offset(-13);
    }];
    
    [self addSubview:self.introduceLabel];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.right.equalTo(self).offset(-7);
        make.height.offset(45);
        make.top.equalTo(self.showHiddenBgView.mas_bottom).offset(5);
    }];
    
    [self addSubview:self.introduceTextView];
    [self.introduceTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.right.equalTo(self).offset(-7);
        make.height.offset(104);
        make.top.equalTo(self.introduceLabel.mas_bottom).offset(1);
    }];
    
    [self addSubview:self.wordNumberLabel];
    [self.wordNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.introduceTextView).offset(-5);
    }];
    
    [self addSubview:self.introduceDetailLabel];
    [self.introduceDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.right.equalTo(self).offset(-7);
        make.top.equalTo(self.introduceTextView.mas_bottom).offset(10);
    }];
    
    [self addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introduceDetailLabel.mas_bottom).offset(11);
        make.left.equalTo(self).offset(17);
        make.right.equalTo(self).offset(-17);
        make.height.offset(35);
        make.bottom.equalTo(self).offset(-26);
    }];
    
}

- (void)configBaseInfoViewWithData:(NSDictionary *)model
{

//    self.realNameField.text = model[@"cardname"];
//    self.sexView.content = model[@"sex"];
//    self.educationView.content = model[@"education"];
//    self.workDateView.content = [NSDate timeStampToDate:model[@"worktime"]];
//    self.affiliatedUnitField.text = model[@"unit"];
//    self.affiliatedUnitTypeBtn.titleLabel.text = model[@"unittype"];
//    self.showHiddenSwitch.on = [model[@"unitlook"] boolValue];
//    self.introduceTextView.text = model[@"oneselfinfo"];
    
    JYXUser *user = [JYXUserManager shareInstance].user;
    self.realNameField.text = user.cardname;
    self.sexView.content = user.sex;
    self.educationView.content = user.education;
    self.affiliatedUnitField.text = user.unit;
    if ([user.unittype isEqualToString:@""]) {
       [self.affiliatedUnitTypeBtn setTitle:@"学校" forState:UIControlStateNormal]; // 学历选择按钮
    }else{
        [self.affiliatedUnitTypeBtn setTitle:user.unittype forState:UIControlStateNormal]; // 学历选择按钮
    }
    [self.showHiddenSwitch setOn:user.unitlook.boolValue];
    self.introduceTextView.text = user.oneselfinfo;
    
    if ([user.worktime isEqualToString:@"0"]) {
        self.workDateView.content = @"2018-01-01";
    }else{
        self.workDateView.content = [NSDate timeStampToDate:user.worktime];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.realNameField) {
        JYXUser *user = [JYXUserManager shareInstance].user;
        if (![user.cardname isEqualToString:@""]) {
            [MBProgressHUD showInfoMessage:@"必填资料认证通过后不能修改"];
            return NO;
        }
    }
    return YES;
}

//性别选择
- (void)sexAction:(UITapGestureRecognizer *)gesture
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    if (![user.sex isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"必填资料认证通过后不能修改"];
        return ;
    }
    [_affiliatedUnitField resignFirstResponder];
    [_realNameField resignFirstResponder];
    WeakSelf(weakSelf);
    NSArray *array = @[@"男",@"女"];
    MSActionSheet *sexActionSheet = [[MSActionSheet alloc] initWithTitleAndCancel:nil cancel:nil cancelHandler:nil buttons:array handler:^(MSActionSheet *sheet, int btnIndex) {
        weakSelf.sexView.content = array[btnIndex];
    }];
    [sexActionSheet show];
}

//学历选择
- (void)educationAction:(UITapGestureRecognizer *)gesture
{
    if (![self.educationView.content isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"必填资料认证通过后不能修改"];
        return ;
    }
    NSArray *array = @[@"大学专科",@"大学本科",@"硕士研究生",@"博士研究生"];
    WeakSelf(weakSelf);
    DLPickerView* picker = [[DLPickerView alloc] initWithDataSource:array withSelectedItem:self.educationView.content withSelectedBlock:^(id  _Nonnull item) {
        weakSelf.educationView.content = item;
    }];
    
    [picker show];
}

//从业时间
- (void)workDateAction:(UITapGestureRecognizer *)gesture
{
//    JYXUser *user = [JYXUserManager shareInstance].user;
//    if (![user.cardname isEqualToString:@""]) {
//        [MBProgressHUD showInfoMessage:@"必填资料认证通过后不能修改"];
//        return ;
//    }
    [kAppDelegate.window.rootViewController presentViewController:self.yearAndMonthAndDayDatePickManager animated:false completion:nil];
}

//所属单位类型选择
- (void)affiliatedUnitTypeAction:(UIButton *)btn
{
    NSArray *array = @[@"小学",@"中学",@"大学",@"机构",@"学校"];
    DLPickerView* picker = [[DLPickerView alloc] initWithDataSource:array withSelectedItem:btn.titleLabel.text withSelectedBlock:^(id  _Nonnull item) {
        [btn setTitle:item forState:UIControlStateNormal];
    }];
    
    [picker show];
}

//下一步
- (void)nextAction:(UIButton *)sender
{
 
    if ([self.realNameField.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请填写姓名"];
        return;
    }
    if ([self.sexView.content isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请选择性别"];
        return;
    }
    if ([self.educationView.content isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请填写学历"];
        return;
    }
    if ([self.workDateView.content isEqualToString:@"1970-01-01"]) {
        [MBProgressHUD showInfoMessage:@"请选择从业时间"];
        return;
    }
    if ([self.affiliatedUnitField.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请填写所属单位"];
        return;
    }
    if ([self.introduceTextView.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请输入自我介绍"];
        return;
    }
    if (self.introduceTextView.text.length < 30) {
        [MBProgressHUD showInfoMessage:@"自我介绍不能少于30字"];
        return;
    }
    NSInteger workTime = [self timeSwitchTimestamp:self.workDateView.content andFormatter:@"YYYY-MM-dd"];
    [MyHandler postTeacherInfoWithCardname:self.realNameField.text sex:self.sexView.content education:self.educationView.content worktime:workTime unit:self.affiliatedUnitField.text unittype:self.affiliatedUnitTypeBtn.titleLabel.text unitlook:self.showHiddenSwitch.on oneselfinfo:self.introduceTextView.text prepare:^{
        
    } success:^(id obj) {
//        [WLToast show:@"保存成功！"];
        JYXCertificationMaterialsViewController *vc = [[JYXCertificationMaterialsViewController alloc] init];
        [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
    
//    JYXUser *user = [JYXUserManager shareInstance].user;
//    JYXHomeTeacherTeacherEditApi *api = [[JYXHomeTeacherTeacherEditApi alloc] initWithUserid:user.userId token:user.token cardname:[self.realNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] sex:self.sexView.content education:self.educationView.content worktime:[[NSDate date] getTimeStrWithString:self.workDateView.content] unit:[self.affiliatedUnitField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] unittype:self.affiliatedUnitTypeBtn.titleLabel.text unitlook:@(self.showHiddenSwitch.isOn) oneselfinfo:self.introduceTextView.text];
//    [SVProgressHUD show];
//    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
//        [SVProgressHUD dismiss];
//        NSNumber *isSuccess = [api fetchDataWithReformer:request];
//        if (isSuccess.boolValue) {
//            [WLToast show:@"保存成功！"];
//            JYXCertificationMaterialsViewController *vc = [[JYXCertificationMaterialsViewController alloc] init];
//            [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
//        }
//    } failure:^(__kindof RXBaseRequest *request) {
//        [SVProgressHUD dismiss];
//    }];
    
}

-(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}

#pragma mark        textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""] && range.length > 0) {
        //删除字符肯定是安全的
        return YES;
    } else {
        
        if (textView.text.length - range.length + text.length > 300) {
            [MBProgressHUD showInfoMessage:@"不能超过300个字"];
            return NO;
        } else {
            return YES;
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 300) {
        textView.text = [textView.text substringToIndex:300];
    }
    
    self.wordNumberLabel.text = [NSString stringWithFormat:@"%ld/300",textView.text.length];
}

- (UIView *)realNameBgView
{
    if (!_realNameBgView) {
        _realNameBgView = [[UIView alloc] init];
        _realNameBgView.backgroundColor = [UIColor whiteColor];
        _realNameBgView.layer.cornerRadius = 5;
        _realNameBgView.layer.masksToBounds = YES;
    }
    return _realNameBgView;
}

- (UILabel *)realNameTitleLabel
{
    if (!_realNameTitleLabel) {
        _realNameTitleLabel = [[UILabel alloc] init];
        _realNameTitleLabel.text = NSLocalizedString(@"真实姓名（必填）", nil);
        _realNameTitleLabel.font = FONT_SIZE(15);
        _realNameTitleLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        [_realNameTitleLabel sizeToFit];
    }
    return _realNameTitleLabel;
}

-  (UITextField *)realNameField
{
    if (!_realNameField) {
        _realNameField = [[UITextField alloc] init];
        _realNameField.placeholder = NSLocalizedString(@"请输入真实姓名", nil);
        _realNameField.font = FONT_SIZE(14);
        _realNameField.textColor = [UIColor colorWithHex:0x6d6d6d];
        _realNameField.delegate = self;
    }
    return _realNameField;
}

- (UILabel *)realNameRemarkLabel
{
    if (!_realNameRemarkLabel) {
        _realNameRemarkLabel = [[UILabel alloc] init];
        _realNameRemarkLabel.textColor = [UIColor colorWithHex:0x1aabfd];
        _realNameRemarkLabel.font = FONT_SIZE(11);
        _realNameRemarkLabel.numberOfLines = 0;
        _realNameRemarkLabel.text = NSLocalizedString(@"*真实姓名不对外公开，系统自动提取姓氏，显示为X老师。", nil);
        [_realNameRemarkLabel sizeToFit];
    }
    return _realNameRemarkLabel;
}

- (JYXBaseInfoItemView *)sexView
{
    if (!_sexView) {
        _sexView = [[JYXBaseInfoItemView alloc] init];
        _sexView.title = NSLocalizedString(@"性别（必填）", nil);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sexAction:)];
        [_sexView addGestureRecognizer:tap];
    }
    return _sexView;
}

- (JYXBaseInfoItemView *)educationView
{
    if (!_educationView) {
        _educationView = [[JYXBaseInfoItemView alloc] init];
        _educationView.title = NSLocalizedString(@"学历（必填）", nil);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(educationAction:)];
        [_educationView addGestureRecognizer:tap];
    }
    return _educationView;
}

- (JYXBaseInfoItemView *)workDateView
{
    if (!_workDateView) {
        _workDateView = [[JYXBaseInfoItemView alloc] init];
        _workDateView.title = NSLocalizedString(@"从业时间（必填）", nil);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(workDateAction:)];
        [_workDateView addGestureRecognizer:tap];
    }
    return _workDateView;
}

- (PGDatePickManager *)yearAndMonthAndDayDatePickManager
{
    [_affiliatedUnitField resignFirstResponder];
    [_realNameField resignFirstResponder];
    _yearAndMonthAndDayDatePickManager = [[PGDatePickManager alloc]init];
    _yearAndMonthAndDayDatePickManager.style = PGDatePickManagerStyle1;
    _yearAndMonthAndDayDatePickManager.isShadeBackgroud = true;
    
    PGDatePicker *datePicker = _yearAndMonthAndDayDatePickManager.datePicker;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.datePickerMode = PGDatePickerModeDate;
    [datePicker setDate:[[NSDate date] stringToDateWithStr:self.workDateView.content]];
    WeakSelf(weakSelf);
    [datePicker setSelectedDate:^(NSDateComponents *dateComponents) {
        NSLog(@"%@",dateComponents);
        NSString *monthStr;
        NSString *dayStr;
        if (dateComponents.month > 0 && dateComponents.month < 10) {
            monthStr = [NSString stringWithFormat:@"0%ld",(long)dateComponents.month];
        }else{
            monthStr = [NSString stringWithFormat:@"%ld",(long)dateComponents.month];
        }
        if (dateComponents.day > 0 && dateComponents.day < 10) {
            dayStr = [NSString stringWithFormat:@"0%ld",(long)dateComponents.day];
        }else{
            dayStr = [NSString stringWithFormat:@"%ld",(long)dateComponents.day];
        }
        weakSelf.workDateView.content = [NSString stringWithFormat:@"%ld-%@-%@",dateComponents.year,monthStr,dayStr];
    }];
    return _yearAndMonthAndDayDatePickManager;
}

- (UIView *)affiliatedUnitBgView
{
    if (!_affiliatedUnitBgView) {
        _affiliatedUnitBgView = [[UIView alloc] init];
        _affiliatedUnitBgView.backgroundColor = [UIColor whiteColor];
        _affiliatedUnitBgView.layer.cornerRadius = 5;
        _affiliatedUnitBgView.layer.masksToBounds = YES;
    }
    return _affiliatedUnitBgView;
}

- (UILabel *)affiliatedUnitTitleLabel
{
    if (!_affiliatedUnitTitleLabel) {
        _affiliatedUnitTitleLabel = [[UILabel alloc] init];
        _affiliatedUnitTitleLabel.font = FONT_SIZE(15);
        _affiliatedUnitTitleLabel.text = NSLocalizedString(@"所属单位", nil);
        _affiliatedUnitTitleLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        [_affiliatedUnitTitleLabel sizeToFit];
    }
    return _affiliatedUnitTitleLabel;
}

- (UITextField *)affiliatedUnitField
{
    if (!_affiliatedUnitField) {
        _affiliatedUnitField = [[UITextField alloc] init];
        _affiliatedUnitField.placeholder = NSLocalizedString(@"请输入您的工作单位", nil);
        _affiliatedUnitField.font = FONT_SIZE(14);
        _affiliatedUnitField.textColor = [UIColor colorWithHex:0x6d6d6d];
        _affiliatedUnitField.delegate = self;
    }
    return _affiliatedUnitField;
}

- (UIButton *)affiliatedUnitTypeBtn
{
    if (!_affiliatedUnitTypeBtn) {
        _affiliatedUnitTypeBtn = [[UIButton alloc] init];
        JYXViewBorderRadius(_affiliatedUnitTypeBtn, 5, 1, [UIColor colorWithHex:0xbfbfbf]);
        JYXUser *user = [JYXUserManager shareInstance].user;
        if ([user.unittype isEqualToString:@""]) {
            [_affiliatedUnitTypeBtn setTitle:NSLocalizedString(@"学校", nil) forState:UIControlStateNormal];
        }else{
            [_affiliatedUnitTypeBtn setTitle:NSLocalizedString(user.unittype, nil) forState:UIControlStateNormal];
        }
        [_affiliatedUnitTypeBtn setImage:[UIImage imageNamed:@"Down_arrow"] forState:UIControlStateNormal];
        _affiliatedUnitTypeBtn.titleLabel.font = FONT_SIZE(15);
        [_affiliatedUnitTypeBtn setTitleColor:[UIColor colorWithHex:0x7f7f7f] forState:UIControlStateNormal];
        [_affiliatedUnitTypeBtn addTarget:self action:@selector(affiliatedUnitTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_affiliatedUnitTypeBtn sizeToFit];
    }
    return _affiliatedUnitTypeBtn;
}

- (UIView *)showHiddenBgView
{
    if (!_showHiddenBgView) {
        _showHiddenBgView = [[UIView alloc] init];
        _showHiddenBgView.backgroundColor = [UIColor whiteColor];
        _showHiddenBgView.layer.cornerRadius = 5;
        _showHiddenBgView.layer.masksToBounds = YES;
    }
    return _showHiddenBgView;
}

- (UILabel *)showHiddenTitleLabel
{
    if (!_showHiddenTitleLabel) {
        _showHiddenTitleLabel = [[UILabel alloc] init];
        _showHiddenTitleLabel.text = NSLocalizedString(@"显示所属单位全称", nil);
        _showHiddenTitleLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        _showHiddenTitleLabel.font = FONT_SIZE(15);
        [_showHiddenTitleLabel sizeToFit];
    }
    return _showHiddenTitleLabel;
}

- (UISwitch *)showHiddenSwitch
{
    if (!_showHiddenSwitch) {
        _showHiddenSwitch = [[UISwitch alloc] init];
    }
    return _showHiddenSwitch;
}

- (UILabel *)showHiddenRemarkLabel
{
    if (!_showHiddenRemarkLabel) {
        _showHiddenRemarkLabel = [[UILabel alloc] init];
        _showHiddenRemarkLabel.text = NSLocalizedString(@"*隐藏所属单位全称则只显示某中学某小学", nil);
        _showHiddenRemarkLabel.font = FONT_SIZE(11);
        _showHiddenRemarkLabel.textColor = [UIColor colorWithHex:0x1aabfd];
        [_showHiddenRemarkLabel sizeToFit];
    }
    return _showHiddenRemarkLabel;
}

- (UILabel *)introduceLabel
{
    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc] init];
        _introduceLabel.font = FONT_SIZE(15);
        _introduceLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        _introduceLabel.text = NSLocalizedString(@"  自我介绍（必填）", nil);
        _introduceLabel.backgroundColor = [UIColor whiteColor];
        _introduceLabel.layer.cornerRadius = 5;
        _introduceLabel.layer.masksToBounds = YES;
    }
    return _introduceLabel;
}

- (UITextView *)introduceTextView
{
    if (!_introduceTextView) {
        _introduceTextView = [[UITextView alloc] init];
        _introduceTextView.placeholder = NSLocalizedString(@"请输入自我介绍，让学生更好的了解你（不少于30字）", nil);
        _introduceTextView.font = FONT_SIZE(14);
        _introduceTextView.textColor = [UIColor colorWithHex:0x6d6d6d];
        _introduceTextView.layer.cornerRadius = 5;
        _introduceTextView.layer.masksToBounds = YES;
        _introduceTextView.delegate = self;
    }
    return _introduceTextView;
}

- (UILabel *)wordNumberLabel
{
    if (!_wordNumberLabel) {
        _wordNumberLabel = [[UILabel alloc] init];
        _wordNumberLabel.font = FONT_SIZE(13);
        _wordNumberLabel.text = @"0/300";
        _wordNumberLabel.textColor = [UIColor colorWithHex:0xc1c1c1];
        [_wordNumberLabel sizeToFit];
    }
    return _wordNumberLabel;
}

- (UILabel *)introduceDetailLabel
{
    if (!_introduceDetailLabel) {
        _introduceDetailLabel = [[UILabel alloc] init];
        _introduceDetailLabel.font = FONT_SIZE(15);
        _introduceDetailLabel.text = NSLocalizedString(@"例：本人毕业于XXX大学的XX专业。有过XX年的教师/家教经验，擅长xx学科，曾多次获得XX奖，在XX学科上颇有心得，而且性格（稳重 阳光 开朗 幽默 细心），能够在轻松愉快的学习气氛中发现学生学习的薄弱点加以强化，在教育工作中遵循“爱与尊重的原则”，注重学习方法因材施教。", nil);
        _introduceDetailLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        _introduceDetailLabel.numberOfLines = 0;
        _introduceDetailLabel.textAlignment = NSTextAlignmentJustified;
        [_introduceDetailLabel sizeToFit];
    }
    return _introduceDetailLabel;
}

- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] init];
        _nextBtn.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = FONT_SIZE(15);
        _nextBtn.layer.cornerRadius = 18;
        _nextBtn.layer.masksToBounds = YES;
        [_nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

@end
