//
//  JYXSelectedGradeSubjectCollectionViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXSelectedGradeSubjectCollectionViewCell.h"
@interface JYXSelectedGradeSubjectCollectionViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation JYXSelectedGradeSubjectCollectionViewCell
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

- (void)configSelectedGradeSubjectCellWithData:(id)model
{
    if (!model) return;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model];
}

//计算cell高度
+ (CGSize)cellWithTitle:(NSString *)title
{
    CGSize size =[title sizeWithAttributes:@{NSFontAttributeName:FONT_SIZE(15)}];
    return CGSizeMake(size.width, 15);
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FONT_SIZE(12);
        _titleLabel.textColor = [UIColor colorWithHex:0x9f9f9f];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

@end
