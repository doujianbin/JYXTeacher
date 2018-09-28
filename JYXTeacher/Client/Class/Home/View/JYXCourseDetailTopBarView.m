//
//  JYXCourseDetailTopBarView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCourseDetailTopBarView.h"
@interface JYXCourseDetailTopBarView ()
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *idNumberLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *creditLabel;
@end

@implementation JYXCourseDetailTopBarView
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
    self.layer.contents = (id)[UIImage imageNamed:@"navBarBg"].CGImage;
    [self addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(8);
        make.height.width.offset(57);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImg.mas_right).offset(28);
        make.top.equalTo(self.avatarImg).offset(2);
    }];
    
    [self addSubview:self.idNumberLabel];
    [self.idNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(4);
    }];
    
    [self addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(50);
        make.height.offset(25);
        make.centerY.equalTo(self.nameLabel).offset(-5);
        make.right.equalTo(self).offset(-60);
    }];
    
    [self addSubview:self.creditLabel];
    [self.creditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.statusLabel);
        make.centerY.equalTo(self.idNumberLabel);
    }];
}

- (void)configCourseDetailTopBarViewWithData:(id)model
{
    if (!model) return;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model[@"head"]] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)]];
    self.nameLabel.text = model[@"studentname"];
    self.idNumberLabel.text = [NSString stringWithFormat:@"ID：%@",model[@"studentid"]];
    self.statusLabel.text = model[@"status"];
    self.creditLabel.text = [NSString stringWithFormat:@"信用：%@",model[@"credit"]];
}

- (UIImageView *)avatarImg
{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] init];
        _avatarImg.backgroundColor = [UIColor randomColor];
        _avatarImg.contentMode = UIViewContentModeScaleAspectFill;
        JYXViewBorderRadius(_avatarImg, 57/2.0, 0, [UIColor clearColor]);
    }
    return _avatarImg;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = FONT_SIZE(19);
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)idNumberLabel
{
    if (!_idNumberLabel) {
        _idNumberLabel = [[UILabel alloc] init];
        _idNumberLabel.textColor = [UIColor whiteColor];
        _idNumberLabel.font = FONT_SIZE(15);
        [_idNumberLabel sizeToFit];
    }
    return _idNumberLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.font = FONT_SIZE(15);
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        JYXViewBorderRadius(_statusLabel, 5, 1, [UIColor whiteColor]);
        [_statusLabel sizeToFit];
    }
    return _statusLabel;
}

- (UILabel *)creditLabel
{
    if (!_creditLabel) {
        _creditLabel = [[UILabel alloc] init];
        _creditLabel.textColor = [UIColor whiteColor];
        _creditLabel.font = FONT_SIZE(15);
        [_creditLabel sizeToFit];
    }
    return _creditLabel;
}

@end

