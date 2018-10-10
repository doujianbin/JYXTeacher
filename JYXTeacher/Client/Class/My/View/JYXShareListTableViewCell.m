//
//  JYXShareListTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXShareListTableViewCell.h"
@interface JYXShareListTableViewCell ()
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *shareDateLabel;
@property (nonatomic, strong) UILabel *shareSatusLabel;
@end

@implementation JYXShareListTableViewCell
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
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    [self.contentView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(23);
        make.top.equalTo(self.contentView).offset(12);
    }];
    
    [self.contentView addSubview:self.shareDateLabel];
    [self.shareDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-12);
        make.left.equalTo(self.userNameLabel);
    }];
    
    [self.contentView addSubview:self.shareSatusLabel];
    [self.shareSatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-32);
    }];
}

- (void)configShareListCellWithData:(id)model
{
    if (!model) return;
    self.userNameLabel.text = [model objectForKey:@"phone"];
    self.shareDateLabel.text = [model objectForKey:@"createtime"];
}

- (UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = FONT_SIZE(16);
        _userNameLabel.textColor = [UIColor colorWithHex:0x5e5e5e];
        [_userNameLabel sizeToFit];
    }
    return _userNameLabel;
}

- (UILabel *)shareDateLabel
{
    if (!_shareDateLabel) {
        _shareDateLabel = [[UILabel alloc] init];
        _shareDateLabel.font = FONT_SIZE(14);
        _shareDateLabel.textColor = [UIColor colorWithHex:0x8a8a8a];
        [_shareDateLabel sizeToFit];
    }
    return _shareDateLabel;
}

- (UILabel *)shareSatusLabel
{
    if (!_shareSatusLabel) {
        _shareSatusLabel = [[UILabel alloc] init];
        _shareSatusLabel.text = NSLocalizedString(@"邀请成功", nil);
        _shareSatusLabel.font = FONT_SIZE(13);
        _shareSatusLabel.textColor = [UIColor colorWithHex:0xF7A94D];
        [_shareSatusLabel sizeToFit];
    }
    return _shareSatusLabel;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 10;
    frame.origin.y += 2.5;
    frame.size.width -= 20;
    frame.size.height -= 5;
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
