//
//  JYXSettingFooterView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXSettingFooterView.h"
#import "JYXLoginViewController.h"

@interface JYXSettingFooterView ()
@property (nonatomic, strong) UIButton *logOutBtn;
@end

@implementation JYXSettingFooterView
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
    self.contentView.layer.backgroundColor = [UIColor clearColor].CGColor;
    [self.contentView addSubview:self.logOutBtn];
    [self.logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.offset(50);
    }];
}

//退出登录
- (void)logOutAction:(id)btn
{
    [[JYXUserManager shareInstance].user clear];
    [[JYXUserManager shareInstance] save];
    JYXLoginViewController *login = [[JYXLoginViewController alloc] init];
    [[JYXBaseViewController getCurrentVC] presentViewController:login animated:YES completion:nil];
}

- (UIButton *)logOutBtn
{
    if (!_logOutBtn) {
        _logOutBtn = [[UIButton alloc] init];
        _logOutBtn.backgroundColor = [UIColor whiteColor];
        [_logOutBtn setTitleColor:[UIColor colorWithHex:0x1aabfd] forState:UIControlStateNormal];
        _logOutBtn.titleLabel.font = FONT_SIZE(18);
        [_logOutBtn setTitle:NSLocalizedString(@"退出登录", nil) forState:UIControlStateNormal];
        [_logOutBtn addTarget:self action:@selector(logOutAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logOutBtn;
}

@end
