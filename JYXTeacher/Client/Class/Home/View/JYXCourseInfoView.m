//
//  JYXCourseInfoView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCourseInfoView.h"
@interface JYXCourseInfoView ()
@property (nonatomic, strong) UIView *gradeBgView;//年级
@property (nonatomic, strong) UILabel *gradeTitleLabel;
@property (nonatomic, strong) UILabel *gradeLabel;

@property (nonatomic, strong) UIView *subjectBgView;//科目
@property (nonatomic, strong) UILabel *subjectTitleLabel;
@property (nonatomic, strong) UILabel *subjectLabel;

@property (nonatomic, strong) UIImageView *verticalBarImg;
@property (nonatomic, strong) UILabel *lessonWayTitleLabel;
@property (nonatomic, strong) UILabel *lessonWayLabel;//授课方式

@property (nonatomic, strong) UIView *addressBgView;//地址、联系方式
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneNumberLabel;
@property (nonatomic, strong) UIImageView *addressImg;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIView *dateBgView;//时间
@property (nonatomic, strong) UILabel *dateTitleLabel;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation JYXCourseInfoView
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
    [self addSubview:self.gradeBgView];
    [self.gradeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-7);
        make.height.offset(31);
    }];
    
    [self.gradeBgView addSubview:self.gradeTitleLabel];
    [self.gradeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gradeBgView).offset(13);
        make.centerY.equalTo(self.gradeBgView);
    }];
    
    [self.gradeBgView addSubview:self.gradeLabel];
    [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.gradeBgView).offset(-13);
        make.centerY.equalTo(self.gradeBgView);
    }];
    
    [self addSubview:self.subjectBgView];
    [self.subjectBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.equalTo(self.gradeBgView);
        make.top.equalTo(self.gradeBgView.mas_bottom).offset(10);
    }];
    
    [self.subjectBgView addSubview:self.subjectTitleLabel];
    [self.subjectTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subjectBgView).offset(13);
        make.centerY.equalTo(self.subjectBgView);
    }];
    
    [self.subjectBgView addSubview:self.subjectLabel];
    [self.subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.subjectBgView).offset(-13);
        make.centerY.equalTo(self.subjectBgView);
    }];
    
    [self addSubview:self.verticalBarImg];
    [self.verticalBarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.top.equalTo(self.subjectBgView.mas_bottom).offset(20);
        make.width.offset(5);
        make.height.offset(17);
    }];
    
    [self addSubview:self.lessonWayTitleLabel];
    [self.lessonWayTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verticalBarImg.mas_right).offset(3);
        make.centerY.equalTo(self.verticalBarImg);
    }];
    
    [self addSubview:self.lessonWayLabel];
    [self.lessonWayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonWayTitleLabel.mas_right);
        make.centerY.equalTo(self.lessonWayTitleLabel);
    }];
    
    [self addSubview:self.addressBgView];
    [self.addressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.subjectBgView);
        make.top.equalTo(self.verticalBarImg.mas_bottom).offset(20);
        make.height.offset(37);
    }];
    
    [self.addressBgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressBgView).offset(13);
        make.top.equalTo(self.addressBgView).offset(9);
    }];
    
    [self.addressBgView addSubview:self.phoneNumberLabel];
    [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(15);
        make.centerY.equalTo(self.nameLabel);
    }];
    
    [self.addressBgView addSubview:self.addressImg];
    [self.addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(10);
        make.height.offset(12);
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.addressBgView).offset(-19);
    }];
    
    [self.addressBgView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImg.mas_right).offset(2);
        make.centerY.equalTo(self.addressImg);
        make.right.equalTo(self.addressBgView).offset(-13);
    }];
    
    [self addSubview:self.dateBgView];
    [self.dateBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.subjectBgView);
        make.top.equalTo(self.addressBgView.mas_bottom).offset(10);
        make.height.offset(72);
        make.bottom.equalTo(self).offset(-14);
    }];
    
    [self.dateBgView addSubview:self.dateTitleLabel];
    [self.dateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateBgView).offset(13);
        make.top.equalTo(self.dateBgView);
        make.height.offset(36);
    }];
    
    [self.dateBgView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.dateBgView);
        make.height.offset(1);
        make.top.equalTo(self.dateTitleLabel.mas_bottom);
    }];
    
    [self.dateBgView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateBgView).offset(13);
        make.bottom.equalTo(self.dateBgView);
        make.top.equalTo(self.line);
        make.right.equalTo(self.dateBgView).offset(-13);
    }];
}

- (void)configCourseInfoViewWithData:(id)model
{
    if (!model) return;
    self.lessonWayLabel.text = model[@"method"];
    self.gradeLabel.text = model[@"grade"];
    self.subjectLabel.text = model[@"subject"];
    self.nameLabel.text = @"";
    self.phoneNumberLabel.text = @"";
    if (model[@"addrinfo"] == nil) {
        self.addressLabel.text = model[@"addr"];
        self.dateLabel.text = model[@"startime"];
    }else{
        self.addressLabel.text = model[@"addrinfo"];
        self.dateLabel.text = [NSString stringWithFormat:@"%@ 星期%@ %@",[[[model objectForKey:@"times"] objectAtIndex:0] objectForKey:@"date"],[[[model objectForKey:@"times"] objectAtIndex:0] objectForKey:@"week"],[[[model objectForKey:@"times"] objectAtIndex:0] objectForKey:@"time"]];
    }
//    self.dateLabel.text = model[@"startime"];
}

- (UIView *)gradeBgView
{
    if (!_gradeBgView) {
        _gradeBgView = [[UIView alloc] init];
        JYXViewBorderRadius(_gradeBgView, 5, 1, [UIColor colorWithHex:0xc1c1c1]);
    }
    return _gradeBgView;
}

- (UILabel *)gradeTitleLabel
{
    if (!_gradeTitleLabel) {
        _gradeTitleLabel = [[UILabel alloc] init];
        _gradeTitleLabel.text = NSLocalizedString(@"年级", nil);
        _gradeTitleLabel.font = FONT_SIZE(14);
        _gradeTitleLabel.textColor = [UIColor colorWithHex:0x7f7f7f];
        [_gradeTitleLabel sizeToFit];
    }
    return _gradeTitleLabel;
}

- (UILabel *)gradeLabel
{
    if (!_gradeLabel) {
        _gradeLabel = [[UILabel alloc] init];
        _gradeLabel.font = FONT_SIZE(14);
        _gradeLabel.textColor = [UIColor colorWithHex:0x7f7f7f];
        [_gradeLabel sizeToFit];
    }
    return _gradeLabel;
}

- (UIView *)subjectBgView
{
    if (!_subjectBgView) {
        _subjectBgView = [[UIView alloc] init];
        JYXViewBorderRadius(_subjectBgView, 5, 1, [UIColor colorWithHex:0xc1c1c1]);
    }
    return _subjectBgView;
}

- (UILabel *)subjectTitleLabel
{
    if (!_subjectTitleLabel) {
        _subjectTitleLabel = [[UILabel alloc] init];
        _subjectTitleLabel.text = NSLocalizedString(@"科目", nil);
        _subjectTitleLabel.font = FONT_SIZE(14);
        _subjectTitleLabel.textColor = [UIColor colorWithHex:0x7f7f7f];
        [_subjectTitleLabel sizeToFit];
    }
    return _subjectTitleLabel;
}

- (UILabel *)subjectLabel
{
    if (!_subjectLabel) {
        _subjectLabel = [[UILabel alloc] init];
        _subjectLabel.font = FONT_SIZE(14);
        _subjectLabel.textColor = [UIColor colorWithHex:0x7f7f7f];
        [_subjectLabel sizeToFit];
    }
    return _subjectLabel;
}

- (UIImageView *)verticalBarImg
{
    if (!_verticalBarImg) {
        _verticalBarImg = [[UIImageView alloc] init];
        _verticalBarImg.image = [UIImage imageNamed:@"VerticalBar"];
    }
    return _verticalBarImg;
}

- (UILabel *)lessonWayTitleLabel
{
    if (!_lessonWayTitleLabel) {
        _lessonWayTitleLabel = [[UILabel alloc] init];
        _lessonWayTitleLabel.text = NSLocalizedString(@"授课方式：", nil);
        _lessonWayTitleLabel.textColor = [UIColor colorWithHex:0x000000];
        _lessonWayTitleLabel.font = FONT_SIZE(16);
        [_lessonWayTitleLabel sizeToFit];
    }
    return _lessonWayTitleLabel;
}

- (UILabel *)lessonWayLabel
{
    if (!_lessonWayLabel) {
        _lessonWayLabel = [[UILabel alloc] init];
        _lessonWayLabel.textColor = [UIColor colorWithHex:0x434343];
        _lessonWayLabel.font = FONT_SIZE(16);
        [_lessonWayLabel sizeToFit];
    }
    return _lessonWayLabel;
}

- (UIView *)addressBgView
{
    if (!_addressBgView) {
        _addressBgView = [[UIView alloc] init];
//        JYXViewBorderRadius(_addressBgView, 5, 1, [UIColor colorWithHex:0xc1c1c1]);
    }
    return _addressBgView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHex:0x404040];
        _nameLabel.font = FONT_SIZE(14);
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)phoneNumberLabel
{
    if (!_phoneNumberLabel) {
        _phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel.textColor = [UIColor colorWithHex:0x404040];
        _phoneNumberLabel.font = FONT_SIZE(13);
        [_phoneNumberLabel sizeToFit];
    }
    return _phoneNumberLabel;
}

- (UIImageView *)addressImg
{
    if (!_addressImg) {
        _addressImg = [[UIImageView alloc] init];
        _addressImg.image = [UIImage imageNamed:@"Home_location"];
        _addressImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _addressImg;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = FONT_SIZE(13);
        _addressLabel.textColor = [UIColor colorWithHex:0x5d5d5d];
        [_addressLabel sizeToFit];
    }
    return _addressLabel;
}

- (UIView *)dateBgView
{
    if (!_dateBgView) {
        _dateBgView = [[UIView alloc] init];
        JYXViewBorderRadius(_dateBgView, 5, 1, [UIColor colorWithHex:0xc1c1c1]);
    }
    return _dateBgView;
}

- (UILabel *)dateTitleLabel
{
    if (!_dateTitleLabel) {
        _dateTitleLabel = [[UILabel alloc] init];
        _dateTitleLabel.text = NSLocalizedString(@"上课时间", nil);
        _dateTitleLabel.font = FONT_SIZE(14);
        _dateTitleLabel.textColor = [UIColor colorWithHex:0x7f7f7f];
        [_dateTitleLabel sizeToFit];
    }
    return _dateTitleLabel;
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor colorWithHex:0xc1c1c1];
    }
    return _line;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = FONT_SIZE(14);
        _dateLabel.textColor = [UIColor colorWithHex:0x7f7f7f];
        [_dateLabel sizeToFit];
    }
    return _dateLabel;
}

@end
