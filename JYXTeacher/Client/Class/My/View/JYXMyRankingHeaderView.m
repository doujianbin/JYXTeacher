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
@property (nonatomic, strong) UILabel *remarkGradeLabel;
@property (nonatomic, strong) UILabel *remarklastLabel;
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
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(18);
        make.height.mas_equalTo(20);
    }];
    
//    self.remarkGradeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.remarkGradeLabel];
    [self.remarkGradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remarkLabel.mas_right).offset(3);
        make.top.height.equalTo(self.remarkLabel);
    }];
    self.remarkGradeLabel.font = [UIFont systemFontOfSize:20];
    self.remarkGradeLabel.textColor = [UIColor colorWithHexString:@"#FF6937"];
    
//    self.remarklastLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.remarklastLabel];
    [self.remarklastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remarkGradeLabel.mas_right).offset(3);
        make.top.height.equalTo(self.remarkLabel);
    }];
    self.remarklastLabel.font = FONT_SIZE(14);
    self.remarklastLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
    
    [self.contentView addSubview:self.helpImg];
    [self.helpImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remarklastLabel.mas_right).offset(5);
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
    self.remarkLabel.text = @"距离推荐名师还差";
    self.remarkGradeLabel.text = [NSString stringWithFormat:@"%@",model[@"lack"]];
    self.remarklastLabel.text = @"名";
}

- (void)helpImgAction{
//    JYXDFGZViewController *vc = [[JYXDFGZViewController alloc]init];
//    [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
    NSString *msg = @"1、平台根据综合评分对教师进行排名（详情查看《常见问题》），选出各省市推荐名师。\n2、在您进入平台时，需预设进入推荐名师版块的价格。\n3、在进入推荐名师版块后，课时费按照您的预设价格执行。\n4、推荐名师价格教师可随时在后台进行更改和设置。\n5、预设价格是对学生收取的总价，正常上课后教予学平台会收取30%的平台费用，70%归教师所有。";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"推荐名师价格预设说明" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIView *subView1 = alert.view.subviews[0];
    
    UIView *subView2 = subView1.subviews[0];
    
    UIView *subView3 = subView2.subviews[0];
    
    UIView *subView4 = subView3.subviews[0];
    
    UIView *subView5 = subView4.subviews[0];
    
    UILabel *message = subView5.subviews[2];
    
    message.textAlignment = NSTextAlignmentLeft;
    [alert addAction:again];
    [[JYXBaseViewController getCurrentVC] presentViewController:alert animated:YES completion:nil];
}

- (UILabel *)remarkLabel
{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.font = FONT_SIZE(14);
        _remarkLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
//        [_remarkLabel sizeToFit];
    }
    return _remarkLabel;
}

- (UILabel *)remarkGradeLabel{
    if (!_remarkGradeLabel) {
        _remarkGradeLabel = [[UILabel alloc] init];
       
    }
    return _remarkGradeLabel;
}

- (UILabel *)remarklastLabel{
    if (!_remarklastLabel) {
        _remarklastLabel = [[UILabel alloc] init];
        
    }
    return _remarklastLabel;
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
