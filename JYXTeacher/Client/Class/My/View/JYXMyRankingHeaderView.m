//
//  JYXMyRankingHeaderView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMyRankingHeaderView.h"
#import "JYXDFGZViewController.h"
@interface JYXMyRankingHeaderView ()
@property (nonatomic, strong) UILabel *remarkLabel;
@property (nonatomic, strong) UIButton *helpImg;
@property (nonatomic, strong) UILabel *unitLabel;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *rankingLabel;
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *gradeLabel;
@end

@implementation JYXMyRankingHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self.contentView addSubview:self.remarkLabel];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(18);
    }];
    
    [self.contentView addSubview:self.helpImg];
    [self.helpImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remarkLabel.mas_right).offset(5);
        make.centerY.equalTo(self.remarkLabel);
        make.height.width.offset(12);
    }];
    
    [self.contentView addSubview:self.unitLabel];
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-8);
        make.centerY.equalTo(self.remarkLabel);
    }];
    
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(7);
        make.right.equalTo(self.contentView).offset(-7);
        make.height.offset(87);
        make.top.equalTo(self.contentView).offset(46);
    }];
    
    [self.bgView addSubview:self.rankingLabel];
    [self.rankingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_left).offset(25);
        make.centerY.equalTo(self.bgView);
    }];
    
    [self.bgView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(50);
        make.width.height.offset(55);
        make.centerY.equalTo(self.bgView);
    }];
    
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImg.mas_right).offset(17);
        make.centerY.equalTo(self.bgView);
    }];
    
    [self.bgView addSubview:self.gradeLabel];
    [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-18);
        make.centerY.equalTo(self.bgView);
    }];

}

- (void)configMyRankingHeaderViewWithData:(id)model
{
    if (!model) return;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model[@"head"]] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)]];
    self.rankingLabel.text = model[@"ranking"];
    self.nameLabel.text = model[@"cardname"];
    self.gradeLabel.text = model[@"credit"];
    self.remarkLabel.text = [NSString stringWithFormat:@"距离推荐名师还差 %@ 名",model[@"lack"]];
}

- (void)helpImgAction{
    JYXDFGZViewController *vc = [[JYXDFGZViewController alloc]init];
    [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (UILabel *)remarkLabel
{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.font = FONT_SIZE(14);
        _remarkLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        [_remarkLabel sizeToFit];
    }
    return _remarkLabel;
}

- (UIButton *)helpImg
{
    if (!_helpImg) {
        _helpImg = [[UIButton alloc] init];
        [_helpImg setBackgroundImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
        _helpImg.contentMode = UIViewContentModeScaleAspectFit;
        [_helpImg addTarget:self action:@selector(helpImgAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _helpImg;
}

- (UILabel *)unitLabel
{
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.text = NSLocalizedString(@"排行(分)", nil);
        _unitLabel.font = FONT_SIZE(14);
        _unitLabel.textColor = [UIColor colorWithHex:0x6e6e6e];
        [_unitLabel sizeToFit];
    }
    return _unitLabel;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        JYXViewBorderRadius(_bgView, 5, 0, [UIColor clearColor]);
    }
    return _bgView;
}

- (UILabel *)rankingLabel
{
    if (!_rankingLabel) {
        _rankingLabel = [[UILabel alloc] init];
        _rankingLabel.textColor = [UIColor colorWithHex:0x1aabfd];
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

@end
