//
//  JYXMessageTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMessageTableViewCell.h"

@interface JYXMessageTableViewCell ()
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UIImageView *cutLine;
@end

@implementation JYXMessageTableViewCell
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
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(7);
        make.centerY.equalTo(self.contentView);
        make.height.width.offset(50);
    }];
    
    [self.contentView addSubview:self.cutLine];
    [self.cutLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.offset(1);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImg.mas_right).offset(5);
        make.top.equalTo(self.avatarImg).offset(5);
    }];
    
    [self.contentView addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImg.mas_right).offset(5);
        make.bottom.equalTo(self.avatarImg).offset(-3);
    }];
    
    [self.contentView addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-7);
        make.left.lessThanOrEqualTo(self.messageLabel.mas_right).offset(10);
        make.centerY.equalTo(self.messageLabel);
        make.height.offset(13);
        make.width.offset(7);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-7);
        make.centerY.equalTo(self.nameLabel);
    }];
}

- (void)configMessageCellWithData:(id)model
{
    if (!model) return;
    self.nameLabel.text = @"李东升";
    self.messageLabel.text = @"我收到消息了。。。";
    self.timeLabel.text = @"8月10日   5:09";
}

- (UIImageView *)avatarImg
{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] init];
        _avatarImg.backgroundColor = [UIColor randomColor];
        JYXViewBorderRadius(_avatarImg, 50/2.0, 0, [UIColor clearColor]);
    }
    return _avatarImg;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT_SIZE(16);
        _nameLabel.textColor = [UIColor colorWithHex:0x797979];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = FONT_SIZE(15);
        _messageLabel.textColor = [UIColor colorWithHex:0xa0a0a0];
        [_messageLabel sizeToFit];
    }
    return _messageLabel;
}

- (UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = [UIImage imageNamed:@"rightArrow"];
        _arrowImg.contentMode = UIViewContentModeScaleAspectFit;
        [_arrowImg sizeToFit];
    }
    return _arrowImg;
}

- (UIImageView *)cutLine
{
    if (!_cutLine) {
        _cutLine = [[UIImageView alloc] init];
        _cutLine.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    }
    return _cutLine;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithHex:0xa0a0a0];
        _timeLabel.font = FONT_SIZE(12);
        [_timeLabel sizeToFit];
    }
    return _timeLabel;
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
