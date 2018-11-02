//
//  JYXMyWalletHeaderView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMyWalletHeaderView.h"
#import "JYXTransactionDetailViewController.h"
#import "JYXWithdrawViewController.h"

@interface JYXMyWalletHeaderView ()
@property (nonatomic, strong) UILabel *balanceTitleLabel;
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) UIButton *transactionDetailBtn;

@property (nonatomic, strong) UIView *bottomBgView;
@property (nonatomic, strong) UILabel *classFeeTitleLabel;
@property (nonatomic, strong) UILabel *classFeeLabel;
@property (nonatomic, strong) UIButton *withdrawBtn1;//课时费提现

@property (nonatomic, strong) UIImageView *line;//分割线

@property (nonatomic, strong) UILabel *shareEarningsTitleLabel;//共享收益
@property (nonatomic, strong) UILabel *shareEarningsLabel;
@property (nonatomic, strong) UIButton *withdrawBtn2;//共享收益提现
@end

@implementation JYXMyWalletHeaderView
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
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarBg"]];
    
    [self.contentView addSubview:self.balanceLabel];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(60);
    }];
    
    [self.contentView addSubview:self.balanceTitleLabel];
    [self.balanceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.balanceLabel.mas_top).offset(-6);
    }];
    
    [self.contentView addSubview:self.transactionDetailBtn];
    [self.transactionDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.balanceLabel.mas_bottom);
        make.centerX.equalTo(self.contentView);
        make.height.offset(27);
        make.width.offset(95);
    }];
    
    [self.contentView addSubview:self.bottomBgView];
    [self.bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.offset(92);
    }];
    //课时费
    [self.bottomBgView addSubview:self.classFeeTitleLabel];
    [self.classFeeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomBgView).offset(15);
        make.centerX.equalTo(self.bottomBgView).offset(-SCREEN_WIDTH/4);
    }];
    [self.bottomBgView addSubview:self.classFeeLabel];
    [self.classFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomBgView);
        make.centerX.equalTo(self.classFeeTitleLabel);
    }];
    [self.bottomBgView addSubview:self.withdrawBtn1];
    [self.withdrawBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.classFeeLabel);
        make.width.offset(46);
        make.height.offset(19);
        make.bottom.equalTo(self.bottomBgView).offset(-12);
    }];
    
    //这是分割线
    [self.bottomBgView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.bottom.equalTo(self.bottomBgView);
        make.width.offset(1);
    }];
    
    //共享收益
    [self.bottomBgView addSubview:self.shareEarningsTitleLabel];
    [self.shareEarningsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomBgView).offset(15);
        make.centerX.equalTo(self.bottomBgView).offset(SCREEN_WIDTH/4);
    }];
    [self.bottomBgView addSubview:self.shareEarningsLabel];
    [self.shareEarningsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomBgView);
        make.centerX.equalTo(self.shareEarningsTitleLabel);
    }];
    [self.bottomBgView addSubview:self.withdrawBtn2];
    [self.withdrawBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shareEarningsLabel);
        make.width.offset(46);
        make.height.offset(19);
        make.bottom.equalTo(self.bottomBgView).offset(-12);
    }];
}

- (void)configMyWalletHeaderViewWithData:(id)model
{
    if (!model) return;
    self.classFeeLabel.text = model[@"lessonmoney"];
    self.shareEarningsLabel.text = model[@"sharemoney"];
    self.balanceLabel.text = model[@"money"];
}

//提现
- (void)withdrawAction:(UIButton *)btn
{
    JYXWithdrawViewController *vc = [[JYXWithdrawViewController alloc] init];
    if (btn == _withdrawBtn1) {
        //课时费提现
//        if ([self.classFeeLabel.text floatValue] < 100) {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"低于100元不可以提现" preferredStyle:UIAlertControllerStyleAlert];
//
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//
//            }];
//            [alert addAction:cancel];
//            [[JYXBaseViewController getCurrentVC] presentViewController:alert animated:YES completion:nil];
//        }else{
//            vc.money = [self.classFeeLabel.text doubleValue];
//            vc.tixianfangshi = 4;
//            [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
//        }
        vc.money = [self.classFeeLabel.text doubleValue];
        vc.tixianfangshi = 4;
        [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else{
        //共享收益提现
        if ([self.shareEarningsLabel.text floatValue] < 100) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"低于100元不可以提现" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {


            }];
            [alert addAction:cancel];
            [[JYXBaseViewController getCurrentVC] presentViewController:alert animated:YES completion:nil];
        }else{
            vc.money = [self.shareEarningsLabel.text doubleValue];
            vc.tixianfangshi = 5;
            [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
        }
//        vc.money = [self.shareEarningsLabel.text doubleValue];
//        vc.tixianfangshi = 5;
//        [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
    }
    
}

//交易明细
- (void)transactionDetailAction:(UIButton *)btn
{
    JYXTransactionDetailViewController *vc = [[JYXTransactionDetailViewController alloc] init];
    [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (UILabel *)balanceTitleLabel
{
    if (!_balanceTitleLabel) {
        _balanceTitleLabel = [[UILabel alloc] init];
        _balanceTitleLabel.text = NSLocalizedString(@"钱包余额", nil);
        _balanceTitleLabel.font = FONT_SIZE(14);
        _balanceTitleLabel.textColor = [UIColor whiteColor];
        [_balanceTitleLabel sizeToFit];
    }
    return _balanceTitleLabel;
}

- (UILabel *)balanceLabel
{
    if (!_balanceLabel) {
        _balanceLabel = [[UILabel alloc] init];
        _balanceLabel.text = @"0";
        _balanceLabel.font = FONT_SIZE(30);
        _balanceLabel.textColor = [UIColor whiteColor];
        [_balanceLabel sizeToFit];
    }
    return _balanceLabel;
}

- (UIButton *)transactionDetailBtn
{
    if (!_transactionDetailBtn) {
        _transactionDetailBtn = [[UIButton alloc] init];
        [_transactionDetailBtn setBackgroundImage:[UIImage imageNamed:@"transactionDetail"] forState:UIControlStateNormal];
        [_transactionDetailBtn addTarget:self action:@selector(transactionDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _transactionDetailBtn;
}

- (UIView *)bottomBgView
{
    if (!_bottomBgView) {
        _bottomBgView = [[UIView alloc] init];
        _bottomBgView.backgroundColor = [UIColor colorWithHex:0x000000 Alpha:0.1];
    }
    return _bottomBgView;
}

- (UILabel *)classFeeTitleLabel
{
    if (!_classFeeTitleLabel) {
        _classFeeTitleLabel = [[UILabel alloc] init];
        _classFeeTitleLabel.textColor = [UIColor colorWithHex:0xffffff Alpha:0.7];
        _classFeeTitleLabel.text = NSLocalizedString(@"课时费", nil);
        _classFeeTitleLabel.font = FONT_SIZE(13);
        [_classFeeTitleLabel sizeToFit];
    }
    return _classFeeTitleLabel;
}

- (UILabel *)classFeeLabel
{
    if (!_classFeeLabel) {
        _classFeeLabel = [[UILabel alloc] init];
        _classFeeLabel.textColor = [UIColor colorWithHex:0xffffff];
        _classFeeLabel.font = FONT_SIZE(13);
        [_classFeeLabel sizeToFit];
    }
    return _classFeeLabel;
}

- (UIButton *)withdrawBtn1
{
    if (!_withdrawBtn1) {
        _withdrawBtn1 = [[UIButton alloc] init];
        JYXViewBorderRadius(_withdrawBtn1, 10, 1, [UIColor whiteColor]);
        [_withdrawBtn1 setTitle:NSLocalizedString(@"提现", nil) forState:UIControlStateNormal];
        _withdrawBtn1.titleLabel.font = FONT_SIZE(13);
        [_withdrawBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_withdrawBtn1 addTarget:self action:@selector(withdrawAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _withdrawBtn1;
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor colorWithHex:0xffffff Alpha:0.4];
    }
    return _line;
}

- (UILabel *)shareEarningsTitleLabel
{
    if (!_shareEarningsTitleLabel) {
        _shareEarningsTitleLabel = [[UILabel alloc] init];
        _shareEarningsTitleLabel.textColor = [UIColor colorWithHex:0xffffff Alpha:0.7];
        _shareEarningsTitleLabel.text = NSLocalizedString(@"共享收益", nil);
        _shareEarningsTitleLabel.font = FONT_SIZE(13);
        [_shareEarningsTitleLabel sizeToFit];
    }
    return _shareEarningsTitleLabel;
}

- (UILabel *)shareEarningsLabel
{
    if (!_shareEarningsLabel) {
        _shareEarningsLabel = [[UILabel alloc] init];
        _shareEarningsLabel.textColor = [UIColor colorWithHex:0xffffff];
        _shareEarningsLabel.font = FONT_SIZE(13);
        [_shareEarningsLabel sizeToFit];
    }
    return _shareEarningsLabel;
}

- (UIButton *)withdrawBtn2
{
    if (!_withdrawBtn2) {
        _withdrawBtn2 = [[UIButton alloc] init];
        JYXViewBorderRadius(_withdrawBtn2, 10, 1, [UIColor whiteColor]);
        [_withdrawBtn2 setTitle:NSLocalizedString(@"提现", nil) forState:UIControlStateNormal];
        _withdrawBtn2.titleLabel.font = FONT_SIZE(13);
        [_withdrawBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_withdrawBtn2 addTarget:self action:@selector(withdrawAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _withdrawBtn2;
}

@end
