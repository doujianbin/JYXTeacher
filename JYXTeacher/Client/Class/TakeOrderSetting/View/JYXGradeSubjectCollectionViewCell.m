//
//  JYXGradeSubjectCollectionViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXGradeSubjectCollectionViewCell.h"
#import "JYXGradeSubjectModel.h"

@implementation JYXGradeSubjectCollectionViewCell
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

- (void)configGradeSubjectCellWithData:(id)model
{
    if (!model) return;
    if ([model isKindOfClass:[JYXGradeSubjectChildrenModel class]]) {
        JYXGradeSubjectChildrenModel *myModel = (JYXGradeSubjectChildrenModel *)model;
        self.titleLabel.text = [NSString stringWithFormat:@"%@",myModel.label];
    } else {
        JYXGradeSubjectModel *myModel = (JYXGradeSubjectModel *)model;
        self.titleLabel.text = [NSString stringWithFormat:@"%@",myModel.label];
    }
    
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHex:0x1aabfd];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

@end
