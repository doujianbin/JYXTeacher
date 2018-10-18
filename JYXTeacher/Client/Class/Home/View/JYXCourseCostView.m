//
//  JYXCourseCostView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCourseCostView.h"
@interface JYXCourseCostView ()


@end

@implementation JYXCourseCostView
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
    //课程单价
    [self addSubview:self.coursePriceTitleLabel];
    [self.coursePriceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self).offset(12);
    }];
    
    [self addSubview:self.coursePriceLabel];
    [self.coursePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.coursePriceTitleLabel);
        make.right.equalTo(self).offset(-12);
    }];
    
    [self addSubview:self.line1];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.offset(1);
        make.top.equalTo(self.coursePriceTitleLabel.mas_bottom).offset(12);
    }];
    //总课时数
    [self addSubview:self.courseHoursTitleLabel];
    [self.courseHoursTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self.line1.mas_bottom).offset(12);
    }];
    
    [self addSubview:self.courseHoursLabel];
    [self.courseHoursLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.courseHoursTitleLabel);
        make.right.equalTo(self).offset(-12);
    }];
    
    [self addSubview:self.line2];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.offset(1);
        make.top.equalTo(self.courseHoursTitleLabel.mas_bottom).offset(12);
    }];
    
    //总金额数
    [self addSubview:self.courseAmountTitleLabel];
    [self.courseAmountTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self.line2.mas_bottom).offset(12);
    }];
    
    [self addSubview:self.courseAmountLabel];
    [self.courseAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.courseAmountTitleLabel);
        make.right.equalTo(self).offset(-12);
    }];
    
    [self addSubview:self.line3];
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.offset(1);
        make.top.equalTo(self.courseAmountTitleLabel.mas_bottom).offset(12);
    }];
    
    //保险费用
//    [self addSubview:self.premiumTitleLabel];
//    [self.premiumTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(12);
//        make.top.equalTo(self.line3.mas_bottom).offset(12);
//    }];
//
//    [self addSubview:self.helpImg];
//    [self.helpImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.premiumTitleLabel.mas_right).offset(8);
//        make.centerY.equalTo(self.premiumTitleLabel);
//        make.width.height.offset(13);
//    }];
//
//    [self addSubview:self.premiumLabel];
//    [self.premiumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.premiumTitleLabel);
//        make.right.equalTo(self).offset(-12);
//    }];
//
//    [self addSubview:self.line4];
//    [self.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.height.offset(1);
//        make.top.equalTo(self.premiumTitleLabel.mas_bottom).offset(12);
//    }];
    
    //公益基金
//    [self addSubview:self.fundTitleLabel];
//    [self.fundTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(12);
//        make.top.equalTo(self.line3.mas_bottom).offset(12);
//    }];
//
//    [self addSubview:self.fundImg];
//    [self.fundImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.fundTitleLabel.mas_right).offset(8);
//        make.centerY.equalTo(self.fundTitleLabel);
//        make.width.height.offset(13);
//    }];
//
//    [self addSubview:self.fundLabel];
//    [self.fundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.fundTitleLabel);
//        make.right.equalTo(self).offset(-12);
//    }];
//
//    [self addSubview:self.line5];
//    [self.line5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.height.offset(1);
//        make.top.equalTo(self.fundTitleLabel.mas_bottom).offset(12);
//    }];
    
    //平台提成
    [self addSubview:self.deductionTitleLabel];
    [self.deductionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self.line3.mas_bottom).offset(12);
        make.bottom.equalTo(self).offset(-12);
    }];
    
    [self addSubview:self.deductionLabel];
    [self.deductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.deductionTitleLabel);
        make.right.equalTo(self).offset(-12);
    }];
    
}

- (void)configCourseCostViewWithData:(id)model
{
    if (!model) return;
    self.coursePriceLabel.text = [NSString stringWithFormat:@"￥ %@/小时",model[@"price"]];
    self.courseHoursLabel.text = [NSString stringWithFormat:@"%@小时",model[@"hour"]];
    self.courseAmountLabel.text = [NSString stringWithFormat:@"￥ %@",model[@"totalPrice"]];
    self.premiumLabel.text = [NSString stringWithFormat:@"￥ 1/人/小时"];
    self.fundLabel.text = [NSString stringWithFormat:@"￥ %@",model[@"donate"]];
    self.deductionLabel.text = [NSString stringWithFormat:@"￥ %@",model[@"platformPrice"]];
}

- (UILabel *)coursePriceTitleLabel
{
    if (!_coursePriceTitleLabel) {
        _coursePriceTitleLabel = [[UILabel alloc] init];
        _coursePriceTitleLabel.text = NSLocalizedString(@"课程单价", nil);
        _coursePriceTitleLabel.font = FONT_SIZE(14);
        _coursePriceTitleLabel.textColor = [UIColor colorWithHex:0x666666];
        [_coursePriceTitleLabel sizeToFit];
    }
    return _coursePriceTitleLabel;
}

- (UILabel *)coursePriceLabel
{
    if (!_coursePriceLabel) {
        _coursePriceLabel = [[UILabel alloc] init];
        _coursePriceLabel.font = FONT_SIZE(14);
        _coursePriceLabel.textColor = [UIColor colorWithHex:0x656565];
        [_coursePriceLabel sizeToFit];
    }
    return _coursePriceLabel;
}

- (UIImageView *)line1
{
    if (!_line1) {
        _line1 = [[UIImageView alloc] init];
        _line1.backgroundColor = [UIColor colorWithHex:0xc1c1c1];
    }
    return _line1;
}

- (UILabel *)courseHoursTitleLabel
{
    if (!_courseHoursTitleLabel) {
        _courseHoursTitleLabel = [[UILabel alloc] init];
        _courseHoursTitleLabel.text = NSLocalizedString(@"总课时数", nil);
        _courseHoursTitleLabel.font = FONT_SIZE(14);
        _courseHoursTitleLabel.textColor = [UIColor colorWithHex:0x666666];
        [_courseHoursTitleLabel sizeToFit];
    }
    return _courseHoursTitleLabel;
}

- (UILabel *)courseHoursLabel
{
    if (!_courseHoursLabel) {
        _courseHoursLabel = [[UILabel alloc] init];
        _courseHoursLabel.font = FONT_SIZE(14);
        _courseHoursLabel.textColor = [UIColor colorWithHex:0x656565];
        [_courseHoursLabel sizeToFit];
    }
    return _courseHoursLabel;
}

- (UIImageView *)line2
{
    if (!_line2) {
        _line2 = [[UIImageView alloc] init];
        _line2.backgroundColor = [UIColor colorWithHex:0xc1c1c1];
    }
    return _line2;
}

- (UILabel *)courseAmountTitleLabel
{
    if (!_courseAmountTitleLabel) {
        _courseAmountTitleLabel = [[UILabel alloc] init];
        _courseAmountTitleLabel.text = NSLocalizedString(@"总金额数", nil);
        _courseAmountTitleLabel.font = FONT_SIZE(14);
        _courseAmountTitleLabel.textColor = [UIColor colorWithHex:0x666666];
        [_courseAmountTitleLabel sizeToFit];
    }
    return _courseAmountTitleLabel;
}

- (UILabel *)courseAmountLabel
{
    if (!_courseAmountLabel) {
        _courseAmountLabel = [[UILabel alloc] init];
        _courseAmountLabel.font = FONT_SIZE(14);
        _courseAmountLabel.textColor = [UIColor colorWithHex:0x656565];
        [_courseAmountLabel sizeToFit];
    }
    return _courseAmountLabel;
}

- (UIImageView *)line3
{
    if (!_line3) {
        _line3 = [[UIImageView alloc] init];
        _line3.backgroundColor = [UIColor colorWithHex:0xc1c1c1];
    }
    return _line3;
}

- (UILabel *)premiumTitleLabel
{
    if (!_premiumTitleLabel) {
        _premiumTitleLabel = [[UILabel alloc] init];
        _premiumTitleLabel.text = NSLocalizedString(@"保险费用", nil);
        _premiumTitleLabel.font = FONT_SIZE(14);
        _premiumTitleLabel.textColor = [UIColor colorWithHex:0x666666];
        [_premiumTitleLabel sizeToFit];
    }
    return _premiumTitleLabel;
}

- (UIButton *)helpImg
{
    if (!_helpImg) {
        _helpImg = [[UIButton alloc] init];
        [_helpImg setBackgroundImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
        _helpImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _helpImg;
}

- (UILabel *)premiumLabel
{
    if (!_premiumLabel) {
        _premiumLabel = [[UILabel alloc] init];
        _premiumLabel.font = FONT_SIZE(14);
        _premiumLabel.textColor = [UIColor colorWithHex:0x656565];
        [_premiumLabel sizeToFit];
    }
    return _premiumLabel;
}

- (UIImageView *)line4
{
    if (!_line4) {
        _line4 = [[UIImageView alloc] init];
        _line4.backgroundColor = [UIColor colorWithHex:0xc1c1c1];
    }
    return _line4;
}

- (UILabel *)fundTitleLabel
{
    if (!_fundTitleLabel) {
        _fundTitleLabel = [[UILabel alloc] init];
        _fundTitleLabel.text = NSLocalizedString(@"公益基金", nil);
        _fundTitleLabel.font = FONT_SIZE(14);
        _fundTitleLabel.textColor = [UIColor colorWithHex:0x666666];
        [_fundTitleLabel sizeToFit];
    }
    return _fundTitleLabel;
}

- (UIButton *)fundImg
{
    if (!_fundImg) {
        _fundImg = [[UIButton alloc] init];
        [_fundImg setBackgroundImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
        _fundImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _fundImg;
}

- (UILabel *)fundLabel
{
    if (!_fundLabel) {
        _fundLabel = [[UILabel alloc] init];
        _fundLabel.font = FONT_SIZE(14);
        _fundLabel.textColor = [UIColor colorWithHex:0x666666];
        [_fundLabel sizeToFit];
    }
    return _fundLabel;
}

- (UIImageView *)line5
{
    if (!_line5) {
        _line5 = [[UIImageView alloc] init];
        _line5.backgroundColor = [UIColor colorWithHex:0xc1c1c1];
    }
    return _line5;
}

- (UILabel *)deductionTitleLabel
{
    if (!_deductionTitleLabel) {
        _deductionTitleLabel = [[UILabel alloc] init];
        _deductionTitleLabel.text = NSLocalizedString(@"平台提成", nil);
        _deductionTitleLabel.font = FONT_SIZE(14);
        _deductionTitleLabel.textColor = [UIColor colorWithHex:0x666666];
        [_deductionTitleLabel sizeToFit];
    }
    return _deductionTitleLabel;
}

- (UILabel *)deductionLabel
{
    if (!_deductionLabel) {
        _deductionLabel = [[UILabel alloc] init];
        _deductionLabel.font = FONT_SIZE(14);
        _deductionLabel.textColor = [UIColor colorWithHex:0x656565];
        [_deductionLabel sizeToFit];
    }
    return _deductionLabel;
}

@end
