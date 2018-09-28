//
//  JYXMyRankingTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMyRankingTableViewCell.h"
@interface JYXMyRankingTableViewCell ()
@property (nonatomic, strong) UILabel *rankingLabel;
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *gradeLabel;
@end

@implementation JYXMyRankingTableViewCell
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
    [self.contentView addSubview:self.rankingLabel];
    [self.rankingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_left).offset(25);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.width.height.offset(55);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImg.mas_right).offset(17);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.gradeLabel];
    [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-18);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)configMyRankingCellWithData:(id)model
{
    if (!model) return;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model[@"head"]] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)]];
    self.rankingLabel.text = model[@"ranking"];
    self.nameLabel.text = model[@"cardname"];
    self.gradeLabel.text = model[@"credit"];
}

- (UILabel *)rankingLabel
{
    if (!_rankingLabel) {
        _rankingLabel = [[UILabel alloc] init];
        _rankingLabel.textColor = [UIColor colorWithHex:0x747474];
        _rankingLabel.font = FONT_SIZE(24);
        [_rankingLabel sizeToFit];
    }
    return _rankingLabel;
}

- (UIImageView *)avatarImg
{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] init];
        _avatarImg.backgroundColor = [UIColor randomColor];
        _avatarImg.contentMode = UIViewContentModeScaleToFill;
        JYXViewBorderRadius(_avatarImg, 55/2.0, 0, [UIColor clearColor]);
    }
    return _avatarImg;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHex:0x747474];
        _nameLabel.font = FONT_SIZE(16);
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)gradeLabel
{
    if (!_gradeLabel) {
        _gradeLabel = [[UILabel alloc] init];
        _gradeLabel.textColor = [UIColor colorWithHex:0x1aabfd];
        _gradeLabel.font = FONT_SIZE(14);
        [_gradeLabel sizeToFit];
    }
    return _gradeLabel;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 7;
    frame.origin.y += 0.5;
    frame.size.height -= 0.5;
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
