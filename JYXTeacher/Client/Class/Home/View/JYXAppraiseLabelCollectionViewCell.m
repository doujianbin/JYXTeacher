//
//  JYXAppraiseLabelCollectionViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAppraiseLabelCollectionViewCell.h"
@interface JYXAppraiseLabelCollectionViewCell ()

@end

@implementation JYXAppraiseLabelCollectionViewCell
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

- (void)configAppraiseLabelCellWithData:(id)model
{
    if (!model) return;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model[@"name"]];
}

//计算cell高度
+ (CGSize)cellWithTitle:(NSDictionary *)dict
{
    NSString *title = dict[@"name"];
    CGSize size =[title sizeWithAttributes:@{NSFontAttributeName:FONT_SIZE(15)}];
    return CGSizeMake(size.width+20, 26);
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
