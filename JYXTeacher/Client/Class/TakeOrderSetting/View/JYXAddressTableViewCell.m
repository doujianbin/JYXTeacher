//
//  JYXAddressTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAddressTableViewCell.h"
@interface JYXAddressTableViewCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneNumberLabel;
@property (nonatomic, strong) UIImageView *addressImg;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UIButton *defaultAddressBtn;
@property (nonatomic, strong) UIButton *editAddressBtn;
@property (nonatomic, strong) UIButton *deleteAddressBtn;
@end

@implementation JYXAddressTableViewCell
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
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(23);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.contentView addSubview:self.phoneNumberLabel];
    [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(36);
        make.centerY.equalTo(self.nameLabel);
    }];

    [self.contentView addSubview:self.addressImg];
    [self.addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.width.offset(10);
        make.height.offset(12);
    }];

    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImg.mas_right).offset(4);
        make.centerY.equalTo(self.addressImg);
        make.right.equalTo(self.contentView).offset(-23);
    }];

    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.offset(1);
        make.top.equalTo(self.addressLabel.mas_bottom).offset(15);
    }];

    [self.contentView addSubview:self.defaultAddressBtn];
    [self.defaultAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(23);
        make.top.equalTo(self.line.mas_bottom).offset(5);
        make.height.offset(30);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];

    [self.contentView addSubview:self.deleteAddressBtn];
    [self.deleteAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-23);
        make.centerY.equalTo(self.defaultAddressBtn);
        make.height.width.offset(20);
    }];

    [self.contentView addSubview:self.editAddressBtn];
    [self.editAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.deleteAddressBtn.mas_left).offset(-20);
        make.centerY.equalTo(self.defaultAddressBtn);
        make.width.height.offset(20);
    }];
}

- (void)configAddressCellWithData:(id)model
{
    if (!model) return;
    self.nameLabel.text = @"欧阳老师";
    self.phoneNumberLabel.text = @"137****3847";
    self.addressLabel.text = @"北京市朝阳区南湖南路金隅丽港城9号楼";
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

 - (UILabel *)phoneNumberLabel
{
    if (!_phoneNumberLabel) {
        _phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel.font = FONT_SIZE(15);
        _phoneNumberLabel.textColor = [UIColor colorWithHex:0x626262];
        [_phoneNumberLabel sizeToFit];
    }
    return _phoneNumberLabel;
}

- (UIImageView *)addressImg
{
    if (!_addressImg) {
        _addressImg = [[UIImageView alloc] init];
        _addressImg.image = [UIImage imageNamed:@"Home_location"];
        [_addressImg sizeToFit];
    }
    return _addressImg;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = FONT_SIZE(13);
        _addressLabel.textColor = [UIColor colorWithHex:0x676767];
        _addressLabel.numberOfLines = 0;
        [_addressLabel sizeToFit];
    }
    return _addressLabel;
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    }
    return _line;
}

- (UIButton *)defaultAddressBtn
{
    if (!_defaultAddressBtn) {
        _defaultAddressBtn = [[UIButton alloc] init];
        [_defaultAddressBtn setImage:[UIImage imageNamed:@"defaultAddress_Sel"] forState:UIControlStateSelected];
        [_defaultAddressBtn setImage:[UIImage imageNamed:@"defaultAddress"] forState:UIControlStateNormal];
        _defaultAddressBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_defaultAddressBtn setTitle:NSLocalizedString(@"设置默认地址", nil) forState:UIControlStateNormal];
        [_defaultAddressBtn setTitleColor:[UIColor colorWithHex:0x686868] forState:UIControlStateNormal];
        _defaultAddressBtn.titleLabel.font = FONT_SIZE(13);
        [_defaultAddressBtn sizeToFit];
    }
    return _defaultAddressBtn;
}

- (UIButton *)editAddressBtn
{
    if (!_editAddressBtn) {
        _editAddressBtn = [[UIButton alloc] init];
        [_editAddressBtn setImage:[UIImage imageNamed:@"editAddress"] forState:UIControlStateNormal];
        _editAddressBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _editAddressBtn;
}

- (UIButton *)deleteAddressBtn
{
    if (!_deleteAddressBtn) {
        _deleteAddressBtn = [[UIButton alloc] init];
        [_deleteAddressBtn setImage:[UIImage imageNamed:@"deleteAddress"] forState:UIControlStateNormal];
        _deleteAddressBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _deleteAddressBtn;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 7;
    frame.origin.y += 5;
    frame.size.height -= 10;
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
