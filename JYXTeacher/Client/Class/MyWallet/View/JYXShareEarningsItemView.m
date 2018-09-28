//
//  JYXShareEarningsItemView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXShareEarningsItemView.h"
@interface JYXShareEarningsItemView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@end

@implementation JYXShareEarningsItemView
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
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-10);
    }];
    
    [self addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(10);
    }];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setNumber:(NSString *)number
{
    _number = number;
    self.numberLabel.text = number;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setNumberColor:(UIColor *)numberColor
{
    _numberColor = numberColor;
    self.numberLabel.textColor = numberColor;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

- (void)setNumberFont:(UIFont *)numberFont
{
    _numberFont = numberFont;
    self.numberLabel.font = numberFont;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT_SIZE(13);
        _titleLabel.textColor = [UIColor colorWithHex:0xa0a0a0];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = FONT_SIZE(13);
        _numberLabel.textColor = [UIColor colorWithHex:0xff6937];
        [_numberLabel sizeToFit];
    }
    return _numberLabel;
}

@end
