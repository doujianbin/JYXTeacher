//
//  JYXAccountManageView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAccountManageView.h"
@interface JYXAccountManageView ()

@end

@implementation JYXAccountManageView
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
    self.backgroundColor = [UIColor whiteColor];
    JYXViewBorderRadius(self, 5, 1, [UIColor colorWithHex:0x3f3f3f]);
    [self addSubview:self.iconImgView];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(36);
        make.left.equalTo(self).offset(17);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.accountField];
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgView.mas_right).offset(35);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-20);
    }];
}

- (void)setIconImg:(UIImage *)iconImg
{
    _iconImg = iconImg;
    self.iconImgView.image = iconImg;
}

- (NSString *)accountStr
{
    return self.accountField.text;
}

- (void)setPlaceholderStr:(NSString *)placeholderStr
{
    _placeholderStr = placeholderStr;
    self.accountField.placeholder = placeholderStr;
}

- (UIImageView *)iconImgView
{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImgView;
}

- (UITextField *)accountField
{
    if (!_accountField) {
        _accountField = [[UITextField alloc] init];
        _accountField.font = FONT_SIZE(14);
        _accountField.textColor = [UIColor colorWithHex:0x6d6d6d];
    }
    return _accountField;
}

@end
