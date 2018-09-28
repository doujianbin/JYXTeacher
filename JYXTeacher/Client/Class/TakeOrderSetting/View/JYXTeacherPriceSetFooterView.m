//
//  JYXTeacherPriceSetFooterView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXTeacherPriceSetFooterView.h"
@interface JYXTeacherPriceSetFooterView ()
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation JYXTeacherPriceSetFooterView
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
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30);
        make.top.equalTo(self.contentView).offset(30);
        make.right.equalTo(self.contentView).offset(-30);
        make.bottom.equalTo(self.contentView).offset(-34);
    }];
}

- (void)configTeacherPriceSetFooterViewWithData:(id)model
{
    if (!model) return;
    self.contentLabel.text = @"推荐名师价格预设说明：\n1.平台根据综合评分对教师进行排名（详情查看《常见问题》），选出各省市推荐名师。\n2.在您进入平台是，需预设进入推荐名师板块的价格。\n3.在进入推荐名师板块后，课时费按照您的预设价格执行。\n4.推荐名师价格教师可随时在后台进行更改和设置\n5.预设价格是对学生收取的总价，正常上课后教予学平台会收取30%的平台费用，70%归教师所有";
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT_SIZE(15);
        _contentLabel.textColor = [UIColor colorWithHex:0x5a5a5a];
        _contentLabel.numberOfLines = 0;
        [_contentLabel sizeToFit];
    }
    return _contentLabel;
}

@end
