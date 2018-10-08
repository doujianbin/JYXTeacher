//
//  JYXTeachingMethodContentView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXTeachingMethodContentView.h"
#import "JYXEditAddressViewController.h"

@interface JYXTeachingMethodContentView ()

@end

@implementation JYXTeachingMethodContentView
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
    [self addSubview:self.teacherVisitBgView];
    [self.teacherVisitBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.offset(44);
    }];
    
    [self.teacherVisitBgView addSubview:self.teacherVisitTitleLabel];
    [self.teacherVisitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teacherVisitBgView).offset(7);
        make.top.equalTo(self.teacherVisitBgView).offset(10);
    }];
    
    [self.teacherVisitBgView addSubview:self.teacherVisitTitleSwitch];
    [self.teacherVisitTitleSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.teacherVisitTitleLabel);
        make.right.equalTo(self.teacherVisitBgView).offset(-7);
    }];
    
    [self addSubview:self.studentVisitBgView];
    [self.studentVisitBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.teacherVisitBgView.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.offset(133);
    }];
    
    [self.studentVisitBgView addSubview:self.studentVisitTitleLabel];
    [self.studentVisitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.studentVisitBgView).offset(7);
        make.top.equalTo(self.studentVisitBgView).offset(10);
    }];
    
    [self.studentVisitBgView addSubview:self.studentVisitTitleSwitch];
    [self.studentVisitTitleSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.studentVisitTitleLabel);
        make.right.equalTo(self.studentVisitBgView).offset(-7);
    }];
    
    [self.studentVisitBgView addSubview:self.addressImg];
    [self.addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.studentVisitBgView).offset(7);
        make.top.equalTo(self.studentVisitTitleLabel.mas_bottom).offset(18);
        make.width.offset(11);
        make.height.offset(14);
    }];
    
    [self.studentVisitBgView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImg.mas_right).offset(6);
        make.centerY.equalTo(self.addressImg);
        make.right.equalTo(self.studentVisitBgView).offset(-7);
    }];
    
    [self.studentVisitBgView addSubview:self.addressRemarkLabel];
    [self.addressRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImg);
        make.top.equalTo(self.addressLabel.mas_bottom).offset(10);
    }];
    
    [self.studentVisitBgView addSubview:self.distanceLabel];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.studentVisitBgView).offset(-7);
        make.centerY.equalTo(self.addressRemarkLabel);
    }];
    
    [self.studentVisitBgView addSubview:self.locationLabel];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.studentVisitBgView).offset(7);
        make.bottom.equalTo(self.studentVisitBgView).offset(-10);
    }];
    
    [self.studentVisitBgView addSubview:self.changeAddressBtn];
    [self.changeAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.locationLabel);
        make.right.equalTo(self.studentVisitBgView).offset(-7);
        make.width.offset(55);
        make.height.offset(18);
    }];
    
    [self addSubview:self.otherAddressBgView];
    [self.otherAddressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.offset(44);
        make.top.equalTo(self.studentVisitBgView.mas_bottom).offset(10);
    }];
    
    [self.otherAddressBgView addSubview:self.otherAddressTitleLabel];
    [self.otherAddressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.otherAddressBgView).offset(7);
        make.top.equalTo(self.otherAddressBgView).offset(10);
    }];
    
    [self.otherAddressBgView addSubview:self.otherAddressTitleSwitch];
    [self.otherAddressTitleSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.otherAddressTitleLabel);
        make.right.equalTo(self.otherAddressBgView).offset(-7);
    }];
    
    [self addSubview:self.shareAddressBgView];
    [self.shareAddressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.otherAddressBgView.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.offset(44);
    }];
    
    [self.shareAddressBgView addSubview:self.shareAddressTitleLabel];
    [self.shareAddressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareAddressBgView).offset(7);
        make.top.equalTo(self.shareAddressBgView).offset(10);
    }];
    
    self.shareAddressTitleSwitch = [[UISwitch alloc]init];
    [self.shareAddressBgView addSubview:self.shareAddressTitleSwitch];
    [self.shareAddressTitleSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shareAddressTitleLabel);
        make.right.equalTo(self.shareAddressBgView).offset(-7);
    }];
    
    [self addSubview:self.remarkLabel];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-7);
        make.top.equalTo(self.shareAddressBgView.mas_bottom).offset(7);
    }];
    
    [self addSubview:self.addressExplainLabel];
    [self.addressExplainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.top.equalTo(self.remarkLabel.mas_bottom).offset(10);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self).offset(-15);
    }];
}

- (void)configTeachingMethodViewWithData:(id)model
{
    if (!model) return;
    [self.teacherVisitTitleSwitch setOn:[[model objectForKey:@"teachertohome"] boolValue]];
    [self.studentVisitTitleSwitch setOn:[[model objectForKey:@"studenttohome"] boolValue]];
    [self.otherAddressTitleSwitch setOn:[[model objectForKey:@"otheraddr"] boolValue]];
    [self.shareAddressTitleSwitch setOn:[[model objectForKey:@"shareaddr"] boolValue]];
    self.addressLabel.text = [model objectForKey:@"addr"];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@KM",[model objectForKey:@"range"]];
    
}

//修改地址
- (void)editAddressAction:(UIButton *)btn
{
    JYXEditAddressViewController *vc = [[JYXEditAddressViewController alloc] init];
    WeakSelf(weakSelf);
    [vc setAddressEditBlock:^(NSString *detailAddress, NSString *latitude, NSString *longitude) {
        weakSelf.addressLabel.text = detailAddress;
    }];
    
    [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (UIView *)teacherVisitBgView
{
    if (!_teacherVisitBgView) {
        _teacherVisitBgView = [[UIView alloc] init];
        _teacherVisitBgView.backgroundColor = [UIColor whiteColor];
    }
    return _teacherVisitBgView;
}

- (UILabel *)teacherVisitTitleLabel
{
    if (!_teacherVisitTitleLabel) {
        _teacherVisitTitleLabel = [[UILabel alloc] init];
        _teacherVisitTitleLabel.text = NSLocalizedString(@"老师上门", nil);
        _teacherVisitTitleLabel.font = FONT_SIZE(17);
        _teacherVisitTitleLabel.textColor = [UIColor colorWithHex:0x272727];
        [_teacherVisitTitleLabel sizeToFit];
    }
    return _teacherVisitTitleLabel;
}

- (UISwitch *)teacherVisitTitleSwitch
{
    if (!_teacherVisitTitleSwitch) {
        _teacherVisitTitleSwitch = [[UISwitch alloc] init];
    }
    return _teacherVisitTitleSwitch;
}

- (UIView *)studentVisitBgView
{
    if (!_studentVisitBgView) {
        _studentVisitBgView = [[UIView alloc] init];
        _studentVisitBgView.backgroundColor = [UIColor whiteColor];
    }
    return _studentVisitBgView;
}

- (UILabel *)studentVisitTitleLabel
{
    if (!_studentVisitTitleLabel) {
        _studentVisitTitleLabel = [[UILabel alloc] init];
        _studentVisitTitleLabel.text = NSLocalizedString(@"学生上门", nil);
        _studentVisitTitleLabel.font = FONT_SIZE(17);
        _studentVisitTitleLabel.textColor = [UIColor colorWithHex:0x272727];
        [_studentVisitTitleLabel sizeToFit];
    }
    return _studentVisitTitleLabel;
}

- (UISwitch *)studentVisitTitleSwitch
{
    if (!_studentVisitTitleSwitch) {
        _studentVisitTitleSwitch = [[UISwitch alloc] init];
    }
    return _studentVisitTitleSwitch;
}

- (UIImageView *)addressImg
{
    if (!_addressImg) {
        _addressImg = [[UIImageView alloc] init];
        _addressImg.image = [UIImage imageNamed:@"Home_location"];
        _addressImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _addressImg;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = FONT_SIZE(12);
        _addressLabel.textColor = [UIColor colorWithHex:0x8b8b8b];
        [_addressLabel sizeToFit];
    }
    return _addressLabel;
}

- (UILabel *)addressRemarkLabel
{
    if (!_addressRemarkLabel) {
        _addressRemarkLabel = [[UILabel alloc] init];
        _addressRemarkLabel.text = NSLocalizedString(@"可接受距此最远距离", nil);
        _addressRemarkLabel.font = FONT_SIZE(12);
        _addressRemarkLabel.textColor = [UIColor colorWithHex:0x8b8b8b];
        [_addressRemarkLabel sizeToFit];
    }
    return _addressRemarkLabel;
}

- (UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.font = FONT_SIZE(12);
        _distanceLabel.textColor = [UIColor colorWithHex:0xff8f4c];
        [_distanceLabel sizeToFit];
    }
    return _distanceLabel;
}

- (UILabel *)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.text = @"位置  家";
        _locationLabel.font = FONT_SIZE(17);
        _locationLabel.textColor = [UIColor colorWithHex:0x272727];
        [_locationLabel sizeToFit];
    }
    return _locationLabel;
}

- (UIButton *)changeAddressBtn
{
    if (!_changeAddressBtn) {
        _changeAddressBtn = [[UIButton alloc] init];
        [_changeAddressBtn setBackgroundImage:[UIImage imageNamed:@"changeAddress"] forState:UIControlStateNormal];
        [_changeAddressBtn addTarget:self action:@selector(editAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeAddressBtn;
}

- (UIView *)otherAddressBgView
{
    if (!_otherAddressBgView) {
        _otherAddressBgView = [[UIView alloc] init];
        _otherAddressBgView.backgroundColor = [UIColor whiteColor];
    }
    return _otherAddressBgView;
}

- (UILabel *)otherAddressTitleLabel
{
    if (!_otherAddressTitleLabel) {
        _otherAddressTitleLabel = [[UILabel alloc] init];
        _otherAddressTitleLabel.text = NSLocalizedString(@"其他地址", nil);
        _otherAddressTitleLabel.font = FONT_SIZE(17);
        _otherAddressTitleLabel.textColor = [UIColor colorWithHex:0x272727];
        [_otherAddressTitleLabel sizeToFit];
    }
    return _otherAddressTitleLabel;
}

- (UISwitch *)otherAddressTitleSwitch
{
    if (!_otherAddressTitleSwitch) {
        _otherAddressTitleSwitch = [[UISwitch alloc] init];
    }
    return _otherAddressTitleSwitch;
}

- (UIView *)shareAddressBgView
{
    if (!_shareAddressBgView) {
        _shareAddressBgView = [[UIView alloc] init];
        _shareAddressBgView.backgroundColor = [UIColor whiteColor];
    }
    return _shareAddressBgView;
}

- (UILabel *)shareAddressTitleLabel
{
    if (!_shareAddressTitleLabel) {
        _shareAddressTitleLabel = [[UILabel alloc] init];
        _shareAddressTitleLabel.text = NSLocalizedString(@"共享地址", nil);
        _shareAddressTitleLabel.font = FONT_SIZE(17);
        _shareAddressTitleLabel.textColor = [UIColor colorWithHex:0x272727];
        [_shareAddressTitleLabel sizeToFit];
    }
    return _shareAddressTitleLabel;
}

- (UILabel *)remarkLabel
{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.text = NSLocalizedString(@"提示：选择的授课方式越多，接单概率将大大增加", nil);
        _remarkLabel.font = FONT_SIZE(12);
        _remarkLabel.textColor = [UIColor colorWithHex:0xff894f];
        _remarkLabel.numberOfLines = 0;
        [_remarkLabel sizeToFit];
    }
    return _remarkLabel;
}

- (UILabel *)addressExplainLabel
{
    if (!_addressExplainLabel) {
        _addressExplainLabel = [[UILabel alloc] init];
        _addressExplainLabel.text = NSLocalizedString(@"地址说明\n1.共享地址为必选地址，平台审核的签约地址安全可靠，有保障性。\n2.教师可设定授课范围（最近15公里起，最远同城不限），在学生发布的订单中会自动过滤不符合地址要求的订单。\n3.若学生所选的共享地址在教师设定范围内，则教师必须接受在该地点上课或是否更换地址。\n4.教师可通过平台沟通功能与学生进行协商，最后决定是否在该地点上课或是更换地址。\n5.教师可在后台预设是否接受在学生所选地址进行授课（在《授课方式》中设置），在学生发布的订单中会自动过滤不符合地址要求的订单。", nil);
        _addressExplainLabel.textColor = [UIColor colorWithHex:0x5a5a5a];
        _addressExplainLabel.font = FONT_SIZE(13);
        _addressExplainLabel.numberOfLines = 0;
        [_addressExplainLabel sizeToFit];
    }
    return _addressExplainLabel;
}

@end

