//
//  JYXSpecialtyApproveTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXSpecialtyApproveTableViewCell.h"
@interface JYXSpecialtyApproveTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *arrowImg;
@end

@implementation JYXSpecialtyApproveTableViewCell
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
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.offset(8);
        make.height.offset(14);
    }];
    
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImg.mas_left).offset(-13);
        make.centerY.equalTo(self.contentView);
    }];
    
}

- (void)configSpecialtyApproveCellWithData:(id)model
{
    if (!model) return;
    NSDictionary *dict = model;
    switch ([dict[@"status"] integerValue]) {
        case 0:
        {
            self.statusLabel.text = @"未认证";
        }
            break;
        case 1:
        {
            self.statusLabel.text = @"认证中";
        }
            break;
        case 2:
        {
            self.statusLabel.text = @"已通过";
        }
            break;
        case 3:
        {
            self.statusLabel.text = @"未通过";
        }
            break;
            
        default:
            break;
    }
    self.nameLabel.text = dict[@"name"];
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
        _titleLabel.font = FONT_SIZE(15);
        _titleLabel.text = NSLocalizedString(@"专业认证", nil);
        _titleLabel.textColor = [UIColor colorWithHex:0x474747];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
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
        _statusLabel.font = FONT_SIZE(15);
        _statusLabel.textColor = [UIColor colorWithHex:0x474747];
        [_statusLabel sizeToFit];
    }
    return _statusLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT_SIZE(15);
        _nameLabel.textColor = [UIColor colorWithHex:0x474747];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
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
