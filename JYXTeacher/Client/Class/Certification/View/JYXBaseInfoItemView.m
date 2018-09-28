//
//  JYXBaseInfoItemView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXBaseInfoItemView.h"
@interface JYXBaseInfoItemView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleContentLabel;
@property (nonatomic, strong) UIImageView *arrowImg;
@end

@implementation JYXBaseInfoItemView
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
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.height.offset(14);
        make.width.offset(8);
    }];
    
    [self addSubview:self.titleContentLabel];
    [self.titleContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImg.mas_left).offset(-10);
        make.centerY.equalTo(self.arrowImg);
    }];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setContent:(NSString *)content
{
    _content = content;
    self.titleContentLabel.text = content;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        _titleLabel.font = FONT_SIZE(15);
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)titleContentLabel
{
    if (!_titleContentLabel) {
        _titleContentLabel = [[UILabel alloc] init];
        _titleContentLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        _titleContentLabel.font = FONT_SIZE(15);
        [_titleContentLabel sizeToFit];
    }
    return _titleContentLabel;
}

- (UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.contentMode = UIViewContentModeScaleAspectFit;
        _arrowImg.image = [UIImage imageNamed:@"rightArrow"];
    }
    return _arrowImg;
}

@end
