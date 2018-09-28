//
//  JYXCalendarTimeCollectionViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/31.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCalendarTimeCollectionViewCell.h"

@implementation JYXCalendarTimeCollectionViewCell
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
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)configCalendarTimeLabelCellWithData:(id)model
{
    if (!model) return;
    self.titleLabel.text = model;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FONT_SIZE(15);
        _titleLabel.textColor = [UIColor colorWithHex:0x1aabfd];
        JYXViewBorderRadius(_titleLabel, 13, 1, [UIColor colorWithHex:0x1aabfd]);
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

@end
