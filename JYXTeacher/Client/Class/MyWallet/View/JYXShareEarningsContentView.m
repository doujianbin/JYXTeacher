//
//  JYXShareEarningsContentView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXShareEarningsContentView.h"
#import "JYXShareEarningsItemView.h"

@interface JYXShareEarningsContentView ()
@property (nonatomic, strong) UIView *topBgView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *remarkLabel;
@property (nonatomic, strong) UIImageView *verticalBar;
@property (nonatomic, strong) UIImageView *line1;
@property (nonatomic, strong) UIImageView *line2;
@property (nonatomic, strong) JYXShareEarningsItemView *directShareNumber;
@property (nonatomic, strong) JYXShareEarningsItemView *indirectShareNumber;
@property (nonatomic, strong) JYXShareEarningsItemView *todayShareHour;
@property (nonatomic, strong) JYXShareEarningsItemView *todayShareEarnings;
@property (nonatomic, strong) JYXShareEarningsItemView *shareTotalHour;
@property (nonatomic, strong) JYXShareEarningsItemView *shareTotalEarnings;
@property (nonatomic, strong) JYXShareEarningsItemView *alreadyWithdrawDeposit;
@property (nonatomic, strong) JYXShareEarningsItemView *waitWithdrawDeposit;
@end

@implementation JYXShareEarningsContentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self addSubview:self.topBgView];
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.offset(86);
        make.top.equalTo(self).offset(1);
    }];
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.topBgView.mas_bottom).offset(1);
        make.height.offset(192);
    }];
    
    [self addSubview:self.applyBtn];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_bottom).offset(134);
        make.height.offset(46);
        make.width.offset(241);
        make.centerX.equalTo(self);
    }];
    
    [self addSubview:self.remarkLabel];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.applyBtn.mas_bottom).offset(97);
        make.bottom.equalTo(self).offset(-35);
    }];
    
    //竖线，分割
    [self addSubview:self.verticalBar];
    [self.verticalBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.topBgView);
        make.bottom.equalTo(self.bgView);
        make.width.offset(1);
    }];
    
    [self addSubview:self.line1];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.top.equalTo(self.bgView).offset(64);
        make.height.offset(1);
    }];
    
    [self addSubview:self.line2];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView).offset(-64);
        make.height.offset(1);
    }];
    
    [self.topBgView addSubview:self.directShareNumber];
    [self.directShareNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.topBgView);
        make.right.equalTo(self.verticalBar);
    }];
    
    [self.topBgView addSubview:self.indirectShareNumber];
    [self.indirectShareNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.topBgView);
        make.left.equalTo(self.verticalBar);
    }];
    
    [self.bgView addSubview:self.todayShareHour];
    [self.todayShareHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.bgView);
        make.right.equalTo(self.verticalBar);
        make.bottom.equalTo(self.line1);
    }];
    
    [self.bgView addSubview:self.todayShareEarnings];
    [self.todayShareEarnings mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.bgView);
        make.left.equalTo(self.verticalBar);
        make.bottom.equalTo(self.line1);
    }];
    
    [self.bgView addSubview:self.shareTotalHour];
    [self.shareTotalHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.line1);
        make.right.equalTo(self.verticalBar);
        make.bottom.equalTo(self.line2);
    }];
    
    [self.bgView addSubview:self.shareTotalEarnings];
    [self.shareTotalEarnings mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.line1);
        make.left.equalTo(self.verticalBar);
        make.bottom.equalTo(self.line2);
    }];
    
    [self.bgView addSubview:self.alreadyWithdrawDeposit];
    [self.alreadyWithdrawDeposit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.line2);
        make.right.equalTo(self.verticalBar);
        make.bottom.equalTo(self.bgView);
    }];
    
    [self.bgView addSubview:self.waitWithdrawDeposit];
    [self.waitWithdrawDeposit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.line2);
        make.left.equalTo(self.verticalBar);
        make.bottom.equalTo(self.bgView);
    }];
}

- (void)configShareEarningViewWithData:(id)model
{
    if (!model) return;
    self.directShareNumber.number = model[@"c1"];//直接共享人数
    self.indirectShareNumber.number = model[@"c2"];//间接共享人数
    self.todayShareHour.number = [NSString stringWithFormat:@"%@小时",model[@"c5"]];//今日共享课时
    self.todayShareEarnings.number = [NSString stringWithFormat:@"￥ %@",model[@"c6"]];//今日共享收益
    self.shareTotalHour.number = [NSString stringWithFormat:@"%@小时",model[@"c3"]];//共享总课时
    self.shareTotalEarnings.number = [NSString stringWithFormat:@"￥ %@",model[@"c4"]];//共享总收益
    self.alreadyWithdrawDeposit.number = [NSString stringWithFormat:@"￥ %@",model[@"c8"]];//已提现收益
    self.waitWithdrawDeposit.number = [NSString stringWithFormat:@"￥ %@",model[@"c7"]];//待提现收益
}


- (UIView *)topBgView
{
    if (!_topBgView) {
        _topBgView = [[UIView alloc] init];
        _topBgView.layer.contents = (id)[UIImage imageNamed:@"navBarBg"].CGImage;
    }
    return _topBgView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIButton *)applyBtn
{
    if (!_applyBtn) {
        _applyBtn = [[UIButton alloc] init];
        _applyBtn.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        [_applyBtn setTitle:NSLocalizedString(@"申请提现", nil) forState:UIControlStateNormal];
        [_applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _applyBtn.titleLabel.font = FONT_SIZE(18);
        JYXViewBorderRadius(_applyBtn, 23, 0, [UIColor clearColor]);
    }
    return _applyBtn;
}

- (UILabel *)remarkLabel
{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.text = NSLocalizedString(@"共享收益满100元可提现", nil);
        _remarkLabel.font = FONT_SIZE(12);
        _remarkLabel.textColor = [UIColor colorWithHex:0xa3a3a3];
        [_remarkLabel sizeToFit];
    }
    return _remarkLabel;
}

- (UIImageView *)verticalBar
{
    if (!_verticalBar) {
        _verticalBar = [[UIImageView alloc] init];
        _verticalBar.backgroundColor = [UIColor colorWithHex:0xf3f3f3 Alpha:0.6];
    }
    return _verticalBar;
}

- (UIImageView *)line1
{
    if (!_line1) {
        _line1 = [[UIImageView alloc] init];
        _line1.backgroundColor = [UIColor colorWithHex:0xf3f3f3 Alpha:0.6];
    }
    return _line1;
}

- (UIImageView *)line2
{
    if (!_line2) {
        _line2 = [[UIImageView alloc] init];
        _line2.backgroundColor = [UIColor colorWithHex:0xf3f3f3 Alpha:0.6];
    }
    return _line2;
}

- (JYXShareEarningsItemView *)directShareNumber
{
    if (!_directShareNumber) {
        _directShareNumber = [[JYXShareEarningsItemView alloc] init];
        _directShareNumber.titleColor = [UIColor whiteColor];
        _directShareNumber.title = NSLocalizedString(@"直接共享人数", nil);
        
        _directShareNumber.numberFont = FONT_SIZE(18);
        _directShareNumber.numberColor = [UIColor whiteColor];
    }
    return _directShareNumber;
}

- (JYXShareEarningsItemView *)indirectShareNumber
{
    if (!_indirectShareNumber) {
        _indirectShareNumber = [[JYXShareEarningsItemView alloc] init];
        _indirectShareNumber.titleColor = [UIColor whiteColor];
        _indirectShareNumber.title = NSLocalizedString(@"间接共享人数", nil);
        
        _indirectShareNumber.numberFont = FONT_SIZE(18);
        _indirectShareNumber.numberColor = [UIColor whiteColor];
    }
    return _indirectShareNumber;
}

- (JYXShareEarningsItemView *)todayShareHour
{
    if (!_todayShareHour) {
        _todayShareHour = [[JYXShareEarningsItemView alloc] init];
        _todayShareHour.title = NSLocalizedString(@"今日共享课时", nil);
        
        _todayShareHour.numberColor = [UIColor colorWithHex:0x1aabfd];
    }
    return _todayShareHour;
}

- (JYXShareEarningsItemView *)todayShareEarnings
{
    if (!_todayShareEarnings) {
        _todayShareEarnings = [[JYXShareEarningsItemView alloc] init];
        _todayShareEarnings.title = NSLocalizedString(@"今日共享收益", nil);
        
    }
    return _todayShareEarnings;
}

- (JYXShareEarningsItemView *)shareTotalHour
{
    if (!_shareTotalHour) {
        _shareTotalHour = [[JYXShareEarningsItemView alloc] init];
        _shareTotalHour.title = NSLocalizedString(@"共享总课时", nil);
        
        _shareTotalHour.numberColor = [UIColor colorWithHex:0x1aabfd];
    }
    return _shareTotalHour;
}

- (JYXShareEarningsItemView *)shareTotalEarnings
{
    if (!_shareTotalEarnings) {
        _shareTotalEarnings = [[JYXShareEarningsItemView alloc] init];
        _shareTotalEarnings.title = NSLocalizedString(@"共享总收益", nil);
        
    }
    return _shareTotalEarnings;
}

- (JYXShareEarningsItemView *)alreadyWithdrawDeposit
{
    if (!_alreadyWithdrawDeposit) {
        _alreadyWithdrawDeposit = [[JYXShareEarningsItemView alloc] init];
        _alreadyWithdrawDeposit.title = NSLocalizedString(@"已提现", nil);
        
    }
    return _alreadyWithdrawDeposit;
}

- (JYXShareEarningsItemView *)waitWithdrawDeposit
{
    if (!_waitWithdrawDeposit) {
        _waitWithdrawDeposit = [[JYXShareEarningsItemView alloc] init];
        _waitWithdrawDeposit.title = NSLocalizedString(@"待提现", nil);
        
    }
    return _waitWithdrawDeposit;
}

@end
