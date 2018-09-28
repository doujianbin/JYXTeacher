//
//  JYXSettingTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXSettingTableViewCell.h"
#import <SDImageCache.h>

@interface JYXSettingTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UIImageView *cutLine;
@property (nonatomic, strong) UISwitch *notiSwitch;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation JYXSettingTableViewCell
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
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(7);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.cutLine];
    [self.cutLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.offset(1);
    }];
    
    [self.contentView addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-7);
        make.centerY.equalTo(self.contentView);
        make.height.offset(16);
        make.width.offset(9);
    }];
    
    [self.contentView addSubview:self.notiSwitch];
    [self.notiSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-7);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-7);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)configSettingCellWithData:(id)model
{
    if (!model) return;
    NSDictionary *dict = model;
    NSNumber *type = dict[@"type"];
    self.titleLabel.text = dict[@"title"];
    self.arrowImg.hidden = YES;
    self.notiSwitch.hidden = YES;
    self.contentLabel.hidden = YES;
    switch (type.integerValue) {
        case 1://我要认证
        {
            self.arrowImg.hidden = NO;
        }
            break;
        case 2://手机号绑定
        {
            self.arrowImg.hidden = NO;
        }
            break;
        case 3://联系客服
        {
            self.arrowImg.hidden = NO;
        }
            break;
        case 4://系统通知
        {
            self.notiSwitch.hidden = NO;
        }
            break;
        case 5://帮助
        {
            self.arrowImg.hidden = NO;
        }
            break;
        case 6://关于教予学
        {
            self.arrowImg.hidden = NO;
        }
            break;
        case 7://清除缓存
        {
            self.contentLabel.hidden = NO;
            self.contentLabel.text = @"5M";
            //获取缓存图片的大小(字节)
            NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
            
            //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
            float MBCache = bytesCache/1000/1000;
            self.contentLabel.text = [NSString stringWithFormat:@"%.fM",MBCache];
            
            
        }
            break;
        case 8://检查更新
        {
            self.contentLabel.hidden = NO;
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            self.contentLabel.text = [NSString stringWithFormat:@"当前版本 v%@",app_Version];
        }
            break;
            
            
        default:
            break;
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHex:0x272727];
        _titleLabel.font = FONT_SIZE(17);
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UIImageView *)cutLine
{
    if (!_cutLine) {
        _cutLine = [[UIImageView alloc] init];
        _cutLine.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    }
    return _cutLine;
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

- (UISwitch *)notiSwitch
{
    if (!_notiSwitch) {
        _notiSwitch = [[UISwitch alloc] init];
    }
    return _notiSwitch;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor colorWithHex:0xeea155];
        _contentLabel.font = FONT_SIZE(15);
        [_contentLabel sizeToFit];
    }
    return _contentLabel;
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
