//
//  JYXGradeSubjectFooterView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXGradeSubjectFooterView.h"
@interface JYXGradeSubjectFooterView ()
@property (nonatomic, strong) UILabel *remarkLabel;
@end

@implementation JYXGradeSubjectFooterView
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
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    [self addSubview:self.remarkLabel];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(17);
        make.top.equalTo(self).offset(17);
        make.right.equalTo(self).offset(-17);
        make.bottom.equalTo(self).offset(-50).priorityMedium();
    }];
}

- (void)configGradeSubjectFooterViewWithData:(id)model
{
    if (!model) return;
    self.remarkLabel.text = @"\n1.先选择一个年级再选择可授课的科目。\n2.重复此操作流程，就选择多个年级多个科目。\n如：选择一年级，然后选择一年级的相应课程,再选择二年级，然后选择二年级的课程，以此类推，就可以选择出多个年级多个不同的科目，没有数量限制。\n\n";
    CGSize size = [self.remarkLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH-34, MAXFLOAT)];
    [self.remarkLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(size.height);
    }];
}

- (UILabel *)remarkLabel
{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.contentMode = UIControlContentVerticalAlignmentTop;
        _remarkLabel.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
        JYXViewBorderRadius(_remarkLabel, 5, 0, [UIColor clearColor]);
        _remarkLabel.font = FONT_SIZE(14);
        _remarkLabel.textColor = [UIColor colorWithHex:0x949494];
        _remarkLabel.numberOfLines = 0;
        [_remarkLabel sizeToFit];
    }
    return _remarkLabel;
}

@end
