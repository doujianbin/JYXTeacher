//
//  JYXMyWelfareTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMyWelfareTableViewCell.h"
@interface JYXMyWelfareTableViewCell ()
@property (nonatomic, strong) UIImageView *leftBgImg;
@property (nonatomic, strong) UIButton *useBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation JYXMyWelfareTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self.contentView addSubview:self.leftBgImg];
    [self.leftBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.useBtn];
    [self.useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBgImg.mas_right).offset(9);
        make.right.equalTo(self).offset(-9);
        make.centerY.equalTo(self);
        make.height.offset(32);
        make.width.offset(73);
    }];
    
    [self.leftBgImg addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.leftBgImg);
    }];
    
    [self.leftBgImg addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leftBgImg.mas_centerY).offset(-10);
        make.centerX.equalTo(self.leftBgImg);
    }];
    
    [self.leftBgImg addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftBgImg.mas_centerY).offset(10);
        make.centerX.equalTo(self.leftBgImg);
    }];
}

- (void)configMyWelfareCellWithData:(id)model
{
    if (!model) return;
    self.titleLabel.text = model[@"name"];
    self.subTitleLabel.text = model[@"content"];
    self.dateLabel.text = [NSString stringWithFormat:@"有效期%@", model[@"validtime"]];
}

- (UIImageView *)leftBgImg
{
    if (!_leftBgImg) {
        _leftBgImg = [[UIImageView alloc] init];
        _leftBgImg.image = [UIImage imageNamed:@"myWelfareBg"];
    }
    return _leftBgImg;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT_SIZE(15);
        _titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = FONT_SIZE(13);
        _subTitleLabel.textColor = [UIColor whiteColor];
        [_subTitleLabel sizeToFit];
    }
    return _subTitleLabel;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = FONT_SIZE(12);
        _dateLabel.textColor = [UIColor colorWithHex:0xfefefe];
        [_dateLabel sizeToFit];
    }
    return _dateLabel;
}

- (UIButton *)useBtn
{
    if (!_useBtn) {
        _useBtn = [[UIButton alloc] init];
        JYXViewBorderRadius(_useBtn, 5, 1, [UIColor colorWithHex:0x1aabfd]);
        [_useBtn setTitle:NSLocalizedString(@"立即使用", nil) forState:UIControlStateNormal];
        [_useBtn setTitleColor:[UIColor colorWithHex:0x1aabfd] forState:UIControlStateNormal];
        _useBtn.titleLabel.font = FONT_SIZE(14);
    }
    return _useBtn;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 30;
    frame.origin.y += 5;
    frame.size.height -= 10;
    frame.size.width -= 60;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
