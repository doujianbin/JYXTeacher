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
    
    [self.contentView addSubview:self.btn_help];
    [self.btn_help mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(-10);
        make.width.offset(35);
        make.height.offset(50);
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
    self.titleLabel.text = dict[@"title"];
    if ([dict[@"status"] isEqualToString:@"认证中"] || [dict[@"status"] isEqualToString:@"未通过"] || [dict[@"status"] isEqualToString:@"已通过"]) {
        [self.statusLabel setTextColor:[UIColor colorWithHexString:@"#FF7031"]];
    }else{
        [self.statusLabel setTextColor:[UIColor colorWithHexString:@"#000000"]];
    }
    self.statusLabel.text = dict[@"status"];

    if ([dict[@"status"] isEqualToString:@"全职教师"] || [dict[@"status"] isEqualToString:@"自由教师"] || [dict[@"status"] isEqualToString:@"大学生"]) {
        
        self.helpImg.hidden = NO;
        self.btn_help.hidden = NO;
    }else{
        self.helpImg.hidden = YES;
        self.btn_help.hidden = YES;
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
        _titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
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

- (UIButton *)btn_help
{
    if (!_btn_help) {
        _btn_help = [[UIButton alloc] init];
        [_btn_help setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    }
    return _btn_help;
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
        _statusLabel.textColor = [UIColor colorWithHexString:@"#000000"];
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
