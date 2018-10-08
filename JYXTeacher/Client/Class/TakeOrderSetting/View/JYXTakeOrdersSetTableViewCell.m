//
//  JYXTakeOrdersSetTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXTakeOrdersSetTableViewCell.h"
@interface JYXTakeOrdersSetTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailTitleLabel;
@property (nonatomic, strong) UIImageView *arrowImg;
@end

@implementation JYXTakeOrdersSetTableViewCell
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
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
//        make.centerY.equalTo(self.contentView);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentView addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.height.offset(14);
        make.width.offset(8);
    }];
    
    [self.contentView addSubview:self.detailTitleLabel];
    [self.detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.right.equalTo(self.arrowImg.mas_left).offset(-10);
        make.height.mas_equalTo(20);
    }];
}

- (void)configTakeOrdersSetCellWithData:(id)model
{
    if (!model) return;
    NSDictionary *dict = model;
    NSString *title = dict[@"title"];
    self.titleLabel.text = title;
    self.detailTitleLabel.text = dict[@"detailTitle"];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT_SIZE(17);
        _titleLabel.textColor = [UIColor colorWithHex:0x474747];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)detailTitleLabel
{
    if (!_detailTitleLabel) {
        _detailTitleLabel = [[UILabel alloc] init];
        _detailTitleLabel.font = FONT_SIZE(14);
        _detailTitleLabel.textColor = [UIColor colorWithHex:0x1aabfd];
        [_detailTitleLabel sizeToFit];
    }
    return _detailTitleLabel;
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

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 7;
    frame.origin.y += 5;
    frame.size.height -= 5;
    frame.size.width -= 14;
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
