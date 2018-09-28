//
//  JYXCertificationMaterialsTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCertificationMaterialsTableViewCell.h"
@interface JYXCertificationMaterialsTableViewCell ()

@end

@implementation JYXCertificationMaterialsTableViewCell
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
        make.left.equalTo(self.contentView).offset(22);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.helpImg];
    [self.helpImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(16);
        make.left.equalTo(self.titleLabel.mas_right);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30);
        make.centerY.equalTo(self.contentView);
        make.width.offset(8);
        make.height.offset(14);
    }];
    
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImg.mas_left).offset(-13);
        make.centerY.equalTo(self.contentView);
    }];
    
}

- (void)configCertificationMaterialsCellWithData:(id)model
{
    if (!model) return;
    NSDictionary *dict = model;
    NSNumber *type = dict[@"type"];
    self.titleLabel.text = dict[@"title"];
    self.statusLabel.text = dict[@"status"];
    if (type.integerValue == 1) {
        self.helpImg.hidden = NO;
    } else {
        self.helpImg.hidden = YES;
    }
            
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 7;
    frame.origin.y += 2.5;
    frame.size.height -= 2.5;
    frame.size.width -= 14;
    [super setFrame:frame];
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

- (UIButton *)helpImg
{
    if (!_helpImg) {
        _helpImg = [[UIButton alloc] init];
        [_helpImg setBackgroundImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
        _helpImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _helpImg;
}

- (UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = [UIImage imageNamed:@"rightArrow"];
        _arrowImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImg;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = FONT_SIZE(17);
        _statusLabel.textColor = [UIColor colorWithHex:0x474747];
        [_statusLabel sizeToFit];
    }
    return _statusLabel;
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
