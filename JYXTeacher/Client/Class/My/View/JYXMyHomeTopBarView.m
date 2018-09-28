//
//  JYXMyHomeTopBarView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMyHomeTopBarView.h"
#import "JYXMyPersonalInfoViewController.h"
@interface JYXMyHomeTopBarView ()
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *idNumberLabel;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UILabel *gradeLabel;
@end

@implementation JYXMyHomeTopBarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personalInfoAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupViews
{
    self.layer.contents = (id)[UIImage imageNamed:@"navBarBg"].CGImage;
    
    [self addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(22);
        make.height.width.offset(54);
        make.bottom.equalTo(self).offset(-18);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImg.mas_right).offset(13);
        make.bottom.equalTo(self.avatarImg.mas_centerY);
    }];
    
    [self addSubview:self.idNumberLabel];
    [self.idNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.avatarImg.mas_bottom).offset(-3);
        make.left.equalTo(self.avatarImg.mas_right).offset(13);
    }];
    
    [self addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-25);
        make.centerY.equalTo(self.nameLabel);
        make.height.offset(13);
        make.width.offset(8);
    }];
    
    [self addSubview:self.gradeLabel];
    [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-25);
        make.centerY.equalTo(self.idNumberLabel);
    }];
}

- (void)configMyHomeTopBarViewWithData:(id)model
{
    if (!model) return;
    JYXUser *user = [JYXUserManager shareInstance].user;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)]];
    self.nameLabel.text = user.nickname;
    self.idNumberLabel.text = [NSString stringWithFormat:@"ID:%@",user.teacherId];
    self.gradeLabel.text = [NSString stringWithFormat:@"综合评分：%@分",user.credit];
}

//编辑个人信息
- (void)personalInfoAction:(UIGestureRecognizer *)tapGestureRecognizer
{
    JYXMyPersonalInfoViewController *vc = [[JYXMyPersonalInfoViewController alloc] init];
    [[[JYXBaseViewController getCurrentVC] navigationController] pushViewController:vc animated:YES];
}

- (UIImageView *)avatarImg
{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] init];
        JYXViewBorderRadius(_avatarImg, 54/2.0, 0, [UIColor clearColor]);
        _avatarImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _avatarImg;
}

- (UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = [UIImage imageNamed:@"jiantou"];
        _arrowImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImg;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHex:0xffffff];
        _nameLabel.font = FONT_SIZE(19);
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)idNumberLabel
{
    if (!_idNumberLabel) {
        _idNumberLabel = [[UILabel alloc] init];
        _idNumberLabel.textColor = [UIColor colorWithHex:0xf1f1f1];
        _idNumberLabel.font = FONT_SIZE(15);
        [_idNumberLabel sizeToFit];
    }
    return _idNumberLabel;
}

- (UILabel *)gradeLabel
{
    if (!_gradeLabel) {
        _gradeLabel = [[UILabel alloc] init];
        _gradeLabel.font = FONT_SIZE(15);
        _gradeLabel.textColor = [UIColor colorWithHex:0xf0f0f0];
        [_gradeLabel sizeToFit];
    }
    return _gradeLabel;
}

@end
