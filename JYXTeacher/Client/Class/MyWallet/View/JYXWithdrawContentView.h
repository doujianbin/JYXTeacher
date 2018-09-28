//
//  JYXWithdrawContentView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXWithdrawContentView : UIView

//输入提现金额
@property (nonatomic, strong) UILabel *inputMoneyTitleLabel;
@property (nonatomic, strong) UILabel *moneySymbolLabel;
@property (nonatomic, strong) UITextField *inputMoneyField;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UILabel *totalAmountLabel;
@property (nonatomic, strong) UILabel *withdrawWayTitleLabel;
//选择提现方式
@property (nonatomic, strong) UIButton *alipayButton;
@property (nonatomic, strong) UIButton *alipaySelectBtn;

@property (nonatomic, strong) UIButton *wechatPayButton;
@property (nonatomic, strong) UIButton *wechatPaySelectBtn;

@property (nonatomic, strong) UIButton *unionPayButton;
@property (nonatomic, strong) UIButton *unionPaySelectBtn;
//立即提现
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UILabel *withdrawRemarkLabel;
@property (nonatomic, strong) UILabel *withdrawRuleLabel;

@end
