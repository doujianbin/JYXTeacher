//
//  JYXWithdrawContentView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXWithdrawContentView.h"
@interface JYXWithdrawContentView ()
@property (nonatomic, strong) UIImageView *topImageView;

@end

@implementation JYXWithdrawContentView
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
    [self addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(-4);
    }];
    
    [self addSubview:self.inputMoneyTitleLabel];
    [self.inputMoneyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(45);
        make.top.equalTo(self.topImageView.mas_bottom).offset(15);
    }];
    
    [self addSubview:self.moneySymbolLabel];
    [self.moneySymbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(45);
        make.top.equalTo(self.inputMoneyTitleLabel.mas_bottom).offset(20);
    }];
    
    [self addSubview:self.inputMoneyField];
    [self.inputMoneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneySymbolLabel.mas_right).offset(5);
        make.width.offset(100);
        make.height.offset(25);
        make.centerY.equalTo(self.moneySymbolLabel);
    }];
    
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneySymbolLabel);
        make.top.equalTo(self.moneySymbolLabel.mas_bottom).offset(5);
        make.height.offset(1);
        make.right.equalTo(self.inputMoneyField);
    }];
    
    [self addSubview:self.totalAmountLabel];
    [self.totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line);
        make.top.equalTo(self.line.mas_bottom).offset(3);
    }];
    
    [self addSubview:self.withdrawWayTitleLabel];
    [self.withdrawWayTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(45);
        make.top.equalTo(self.totalAmountLabel.mas_bottom).offset(30);
    }];
    
    [self addSubview:self.alipayButton];
    [self.alipayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.withdrawWayTitleLabel.mas_bottom).offset(22);
        make.left.equalTo(self).offset(45);
        make.height.width.offset(36);
    }];
    
    [self addSubview:self.unionPayButton];
    [self.unionPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-45);
        make.centerY.equalTo(self.alipayButton);
        make.height.width.offset(44);
    }];
    
    [self addSubview:self.wechatPayButton];
    [self.wechatPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.alipayButton);
        make.height.width.offset(36);
    }];
    
    [self addSubview:self.alipaySelectBtn];
    [self.alipaySelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.alipayButton);
        make.top.equalTo(self.alipayButton.mas_bottom).offset(15);
    }];
    
    [self addSubview:self.wechatPaySelectBtn];
    [self.wechatPaySelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.wechatPayButton);
        make.centerY.equalTo(self.alipaySelectBtn);
    }];
    
    [self addSubview:self.unionPaySelectBtn];
    [self.unionPaySelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.unionPayButton);
        make.centerY.equalTo(self.alipaySelectBtn);
    }];
    
    [self addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(self.alipaySelectBtn.mas_bottom).offset(41);
        make.right.equalTo(self).offset(-18);
        make.height.offset(48);
    }];
    
    [self addSubview:self.withdrawRemarkLabel];
    [self.withdrawRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.submitBtn.mas_bottom).offset(15);
        make.centerX.equalTo(self);
    }];
    
    [self addSubview:self.withdrawRuleLabel];
    [self.withdrawRuleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(44);
        make.right.equalTo(self).offset(-44);
        make.top.equalTo(self.withdrawRemarkLabel.mas_bottom).offset(27);
        make.bottom.equalTo(self).offset(-40);
    }];
}

- (UIImageView *)topImageView
{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.image = [UIImage imageNamed:@"withdrawBg"];
        [_topImageView sizeToFit];
    }
    return _topImageView;
}

- (UILabel *)inputMoneyTitleLabel
{
    if (!_inputMoneyTitleLabel) {
        _inputMoneyTitleLabel = [[UILabel alloc] init];
        _inputMoneyTitleLabel.font = FONT_SIZE(17);
        _inputMoneyTitleLabel.textColor = [UIColor colorWithHex:0x1aabfd];
        _inputMoneyTitleLabel.text = NSLocalizedString(@"输入提现金额", nil);
        [_inputMoneyTitleLabel sizeToFit];
    }
    return _inputMoneyTitleLabel;
}

- (UILabel *)moneySymbolLabel
{
    if (!_moneySymbolLabel) {
        _moneySymbolLabel = [[UILabel alloc] init];
        _moneySymbolLabel.text = @"￥";
        _moneySymbolLabel.font = FONT_SIZE(28);
        _moneySymbolLabel.textColor = [UIColor colorWithHex:0xff6937];
        [_moneySymbolLabel sizeToFit];
    }
    return _moneySymbolLabel;
}

- (UITextField *)inputMoneyField
{
    if (!_inputMoneyField) {
        _inputMoneyField = [[UITextField alloc] init];
        _inputMoneyField.font = FONT_SIZE(28);
        _inputMoneyField.textColor = [UIColor colorWithHex:0xff6937];
        _inputMoneyField.keyboardType = UIKeyboardTypeDecimalPad;
        [_inputMoneyField sizeToFit];
    }
    return _inputMoneyField;
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor colorWithHex:0xff6937];
    }
    return _line;
}

- (UILabel *)totalAmountLabel
{
    if (!_totalAmountLabel) {
        _totalAmountLabel = [[UILabel alloc] init];
        _totalAmountLabel.font = FONT_SIZE(13);
        //        _totalAmountLabel.text = @"可提现金额：￥121234";
        _totalAmountLabel.textColor = [UIColor colorWithHex:0xaaaaaa];
        [_totalAmountLabel sizeToFit];
    }
    return _totalAmountLabel;
}

- (UILabel *)withdrawWayTitleLabel
{
    if (!_withdrawWayTitleLabel) {
        _withdrawWayTitleLabel = [[UILabel alloc] init];
        _withdrawWayTitleLabel.text = NSLocalizedString(@"选择提现方式", nil);
        _withdrawWayTitleLabel.font = FONT_SIZE(15);
        _withdrawWayTitleLabel.textColor = [UIColor colorWithHex:0x777777];
        [_withdrawWayTitleLabel sizeToFit];
    }
    return _withdrawWayTitleLabel;
}

- (UIButton *)alipayButton
{
    if (!_alipayButton) {
        _alipayButton = [[UIButton alloc] init];
        [_alipayButton setImage:[UIImage imageNamed:@"alipay"] forState:UIControlStateNormal];
    }
    return _alipayButton;
}

- (UIButton *)wechatPayButton
{
    if (!_wechatPayButton) {
        _wechatPayButton = [[UIButton alloc] init];
        [_wechatPayButton setImage:[UIImage imageNamed:@"wechatPay"] forState:UIControlStateNormal];
    }
    return _wechatPayButton;
}

//- (UIButton *)unionPayButton
//{
//    if (!_unionPayButton) {
//        _unionPayButton = [[UIButton alloc] init];
//        [_unionPayButton setImage:[UIImage imageNamed:@"unionPay"] forState:UIControlStateNormal];
//    }
//    return _unionPayButton;
//}

- (UIButton *)alipaySelectBtn
{
    if (!_alipaySelectBtn) {
        _alipaySelectBtn = [[UIButton alloc] init];
        [_alipaySelectBtn setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
        [_alipaySelectBtn setImage:[UIImage imageNamed:@"paymentBtn_Sel"] forState:UIControlStateSelected];
        [_alipaySelectBtn setTitle:NSLocalizedString(@"支付宝", nil) forState:UIControlStateNormal];
        [_alipaySelectBtn setTitleColor:[UIColor colorWithHex:0x7d7d7d] forState:UIControlStateNormal];
        _alipaySelectBtn.titleLabel.font = FONT_SIZE(14);
        [_alipaySelectBtn sizeToFit];
    }
    return _alipaySelectBtn;
}

- (UIButton *)wechatPaySelectBtn
{
    if (!_wechatPaySelectBtn) {
        _wechatPaySelectBtn = [[UIButton alloc] init];
        [_wechatPaySelectBtn setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
        [_wechatPaySelectBtn setImage:[UIImage imageNamed:@"paymentBtn_Sel"] forState:UIControlStateSelected];
        [_wechatPaySelectBtn setTitle:NSLocalizedString(@"微信", nil) forState:UIControlStateNormal];
        [_wechatPaySelectBtn setTitleColor:[UIColor colorWithHex:0x7d7d7d] forState:UIControlStateNormal];
        _wechatPaySelectBtn.titleLabel.font = FONT_SIZE(14);
        [_wechatPaySelectBtn sizeToFit];
    }
    return _wechatPaySelectBtn;
}

//- (UIButton *)unionPaySelectBtn
//{
//    if (!_unionPaySelectBtn) {
//        _unionPaySelectBtn = [[UIButton alloc] init];
//        [_unionPaySelectBtn setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
//        [_unionPaySelectBtn setImage:[UIImage imageNamed:@"paymentBtn_Sel"] forState:UIControlStateSelected];
//        [_unionPaySelectBtn setTitle:NSLocalizedString(@"银行卡", nil) forState:UIControlStateNormal];
//        [_unionPaySelectBtn setTitleColor:[UIColor colorWithHex:0x7d7d7d] forState:UIControlStateNormal];
//        _unionPaySelectBtn.titleLabel.font = FONT_SIZE(14);
//        [_unionPaySelectBtn sizeToFit];
//    }
//    return _unionPaySelectBtn;
//}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        JYXViewBorderRadius(_submitBtn, 10, 0, [UIColor clearColor]);
        _submitBtn.titleLabel.font = FONT_SIZE(22);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:NSLocalizedString(@"立即提现", nil) forState:UIControlStateNormal];
        [_submitBtn sizeToFit];
    }
    return _submitBtn;
}

- (UILabel *)withdrawRemarkLabel
{
    if (!_withdrawRemarkLabel) {
        _withdrawRemarkLabel = [[UILabel alloc] init];
        _withdrawRemarkLabel.text = NSLocalizedString(@"提现金额不能少于100元，账户满100元可提取", nil);
        _withdrawRemarkLabel.font = FONT_SIZE(13);
        _withdrawRemarkLabel.textColor = [UIColor colorWithHex:0xaaaaaa];
        [_withdrawRemarkLabel sizeToFit];
    }
    return _withdrawRemarkLabel;
}

- (UILabel *)withdrawRuleLabel
{
    if (!_withdrawRuleLabel) {
        _withdrawRuleLabel = [[UILabel alloc] init];
        _withdrawRuleLabel.text = @"提现规则\n每月15日以后，上月账户累计金额可提现到账，其他 时间仅可申请提现，无法及时到账";
        _withdrawRuleLabel.font = FONT_SIZE(13);
        _withdrawRuleLabel.textColor = [UIColor colorWithHex:0x595959];
        _withdrawRuleLabel.numberOfLines = 0;
        [_withdrawRuleLabel sizeToFit];
    }
    return _withdrawRuleLabel;
}

@end
