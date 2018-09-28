//
//  JYXTeacherTypeView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXTeacherTypeView.h"
@interface JYXTeacherTypeView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *fullTimeTeacher;
@property (nonatomic, strong) UIButton *freedomTeacher;
@property (nonatomic, strong) UIButton *undergraduate;
@end

@implementation JYXTeacherTypeView
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
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.offset(100);
        make.width.offset(270);
    }];
    
    [self.bgView addSubview:self.fullTimeTeacher];
    [self.fullTimeTeacher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.equalTo(self.bgView).offset(20);
        make.width.offset(71);
        make.height.offset(34);
    }];
    
    [self.bgView addSubview:self.freedomTeacher];
    [self.freedomTeacher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.centerX.equalTo(self.bgView);
        make.width.offset(71);
        make.height.offset(34);
    }];
    
    [self.bgView addSubview:self.undergraduate];
    [self.undergraduate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.right.equalTo(self.bgView).offset(-20);
        make.width.offset(71);
        make.height.offset(34);
    }];
    
    CGSize size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.frame = CGRectMake(0, 0, size.width, size.height);
}

- (void)selectAction:(UIButton *)btn
{
    if (self.teacherTypeBlock) {
        self.teacherTypeBlock(btn.titleLabel.text);
    }
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        JYXViewBorderRadius(_bgView, 10, 0, [UIColor clearColor]);
    }
    return _bgView;
}

- (UIButton *)fullTimeTeacher
{
    if (!_fullTimeTeacher) {
        _fullTimeTeacher = [[UIButton alloc] init];
        _fullTimeTeacher.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        JYXViewBorderRadius(_fullTimeTeacher, 17, 0, [UIColor clearColor]);
        [_fullTimeTeacher setTitle:NSLocalizedString(@"全职教师", nil) forState:UIControlStateNormal];
        [_fullTimeTeacher setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _fullTimeTeacher.titleLabel.font = FONT_SIZE(15);
        [_fullTimeTeacher addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullTimeTeacher;
}

- (UIButton *)freedomTeacher
{
    if (!_freedomTeacher) {
        _freedomTeacher = [[UIButton alloc] init];
        _freedomTeacher.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        JYXViewBorderRadius(_freedomTeacher, 17, 0, [UIColor clearColor]);
        [_freedomTeacher setTitle:NSLocalizedString(@"自由教师", nil) forState:UIControlStateNormal];
        [_freedomTeacher setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _freedomTeacher.titleLabel.font = FONT_SIZE(15);
        [_freedomTeacher addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _freedomTeacher;
}

- (UIButton *)undergraduate
{
    if (!_undergraduate) {
        _undergraduate = [[UIButton alloc] init];
        _undergraduate.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        JYXViewBorderRadius(_undergraduate, 17, 0, [UIColor clearColor]);
        [_undergraduate setTitle:NSLocalizedString(@"大学生", nil) forState:UIControlStateNormal];
        [_undergraduate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _undergraduate.titleLabel.font = FONT_SIZE(15);
        [_undergraduate addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _undergraduate;
}

@end
