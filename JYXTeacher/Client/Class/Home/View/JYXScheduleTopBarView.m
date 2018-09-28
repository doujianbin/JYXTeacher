//
//  JYXScheduleTopBarView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXScheduleTopBarView.h"
@interface JYXScheduleTopBarView ()
@property (nonatomic, assign) NSInteger selectedYear;
@property (nonatomic, assign) NSInteger selectedMonth;
@property (nonatomic, strong) UIView *topBgView;
@property (nonatomic, strong) UIButton *yearButton;
@property (nonatomic, strong) UIButton *monthButton;
@property (nonatomic, strong) UILabel *totalHoursLabel;
@property (nonatomic, strong) UILabel *alreadyHoursLabel;
@property (nonatomic, strong) UILabel *waitHoursLabel;
@property (nonatomic, strong) PGDatePickManager *yearDatePickManager;
@property (nonatomic, strong) PGDatePickManager *monthDatePickManager;
@end

@implementation JYXScheduleTopBarView
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
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topBgView];
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
    }];
    
    [self.topBgView addSubview:self.totalHoursLabel];
    [self.totalHoursLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topBgView).offset(-Iphone6ScaleWidth(120));
        make.centerY.equalTo(self.topBgView);
    }];
    
    [self.topBgView addSubview:self.alreadyHoursLabel];
    [self.alreadyHoursLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topBgView);
        make.centerY.equalTo(self.topBgView);
    }];
    
    [self.topBgView addSubview:self.waitHoursLabel];
    [self.waitHoursLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topBgView).offset(Iphone6ScaleWidth(120));
        make.centerY.equalTo(self.topBgView);
    }];
    
    [self addSubview:self.yearButton];
    [self.yearButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [self.yearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.top.equalTo(self.topBgView.mas_bottom);
        make.width.offset(SCREEN_WIDTH/2);
        make.height.offset(40);
    }];
    
    [self addSubview:self.monthButton];
    [self.monthButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [self.monthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).priorityMedium();
        make.top.equalTo(self.topBgView.mas_bottom);
        make.left.equalTo(self.yearButton.mas_right);
        make.width.offset(SCREEN_WIDTH/2);
        make.height.offset(40);
    }];
}

- (void)configScheduleViewWithData:(id)model
{
    if (!model) return;
    NSDictionary *dict = model;
    self.totalHoursLabel.text = [NSString stringWithFormat:@"总课时数\n%@",dict[@"totalhour"]];
    self.alreadyHoursLabel.text = [NSString stringWithFormat:@"已上课时\n%@",dict[@"okhour"]];
    self.waitHoursLabel.text = [NSString stringWithFormat:@"待上课时\n%@",dict[@"nohour"]];
}

//年份选择
- (void)yearSelectAction:(UIButton *)btn
{
    [kAppDelegate.window.rootViewController presentViewController:self.yearDatePickManager animated:false completion:nil];
}

//月份选择
- (void)monthSelectAction:(UIButton *)btn
{
    [kAppDelegate.window.rootViewController presentViewController:self.monthDatePickManager animated:false completion:nil];
}

- (UIView *)topBgView
{
    if (!_topBgView) {
        _topBgView = [[UIView alloc] init];
        _topBgView.layer.contents = (id)[UIImage imageNamed:@"navBarBg"].CGImage;
    }
    return _topBgView;
}

- (UILabel *)totalHoursLabel
{
    if (!_totalHoursLabel) {
        _totalHoursLabel = [[UILabel alloc] init];
        _totalHoursLabel.textColor = [UIColor whiteColor];
        _totalHoursLabel.font = FONT_SIZE(15);
        _totalHoursLabel.numberOfLines = 2;
        _totalHoursLabel.textAlignment = NSTextAlignmentCenter;
        [_totalHoursLabel sizeToFit];
    }
    return _totalHoursLabel;
}

- (UILabel *)alreadyHoursLabel
{
    if (!_alreadyHoursLabel) {
        _alreadyHoursLabel = [[UILabel alloc] init];
        _alreadyHoursLabel.textColor = [UIColor whiteColor];
        _alreadyHoursLabel.font = FONT_SIZE(15);
        _alreadyHoursLabel.numberOfLines = 2;
        _alreadyHoursLabel.textAlignment = NSTextAlignmentCenter;
        [_alreadyHoursLabel sizeToFit];
    }
    return _alreadyHoursLabel;
}

- (UILabel *)waitHoursLabel
{
    if (!_waitHoursLabel) {
        _waitHoursLabel = [[UILabel alloc] init];
        _waitHoursLabel.textColor = [UIColor whiteColor];
        _waitHoursLabel.font = FONT_SIZE(15);
        _waitHoursLabel.numberOfLines = 2;
        _waitHoursLabel.textAlignment = NSTextAlignmentCenter;
        [_waitHoursLabel sizeToFit];
    }
    return _waitHoursLabel;
}

- (UIButton *)yearButton
{
    if (!_yearButton) {
        _yearButton = [[UIButton alloc] init];
        [_yearButton setTitle:NSLocalizedString(@"全部", nil) forState:UIControlStateNormal];
        [_yearButton setImage:[UIImage imageNamed:@"Down_arrow"] forState:UIControlStateNormal];
        _yearButton.titleLabel.font = FONT_SIZE(18);
        [_yearButton setTitleColor:[UIColor colorWithHex:0x848484] forState:UIControlStateNormal];
        [_yearButton sizeToFit];
        [_yearButton addTarget:self action:@selector(yearSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yearButton;
}

- (UIButton *)monthButton
{
    if (!_monthButton) {
        _monthButton = [[UIButton alloc] init];
        [_monthButton setTitle:NSLocalizedString(@"全部", nil) forState:UIControlStateNormal];
        [_monthButton setImage:[UIImage imageNamed:@"Down_arrow"] forState:UIControlStateNormal];
        _monthButton.titleLabel.font = FONT_SIZE(18);
        [_monthButton setTitleColor:[UIColor colorWithHex:0x848484] forState:UIControlStateNormal];
        [_monthButton sizeToFit];
        [_monthButton addTarget:self action:@selector(monthSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _monthButton;
}

- (PGDatePickManager *)yearDatePickManager
{
    _yearDatePickManager = [[PGDatePickManager alloc]init];
    _yearDatePickManager.style = PGDatePickManagerStyle1;
    _yearDatePickManager.isShadeBackgroud = true;
    
    PGDatePicker *datePicker = _yearDatePickManager.datePicker;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.datePickerMode = PGDatePickerModeYear;
    [datePicker setDate:[[NSDate date] stringToDateWithStr:[NSString stringWithFormat:@"%ld年01月01日",self.selectedYear]]];
    WeakSelf(weakSelf);
    [datePicker setSelectedDate:^(NSDateComponents *dateComponents) {
        NSLog(@"%ld年",dateComponents.year);
        weakSelf.selectedYear = dateComponents.year;
        [weakSelf.yearButton setTitle:[NSString stringWithFormat:@"%ld年",dateComponents.year] forState:UIControlStateNormal];
        if (weakSelf.yearBlock) {
            weakSelf.yearBlock([NSString stringWithFormat:@"%ld",(long)dateComponents.year]);
        }
        [weakSelf.yearButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    }];
    return _yearDatePickManager;
}

- (PGDatePickManager *)monthDatePickManager
{
    _monthDatePickManager = [[PGDatePickManager alloc]init];
    _monthDatePickManager.style = PGDatePickManagerStyle1;
    _monthDatePickManager.isShadeBackgroud = true;
    
    PGDatePicker *datePicker = _monthDatePickManager.datePicker;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.datePickerMode = PGDatePickerModeMonth;
    [datePicker setDate:[[NSDate date] stringToDateWithStr:[NSString stringWithFormat:@"2018年%ld月01日",self.selectedMonth]]];
    WeakSelf(weakSelf);
    [datePicker setSelectedDate:^(NSDateComponents *dateComponents) {
        NSLog(@"%ld月",dateComponents.month);
        weakSelf.selectedMonth = dateComponents.month;
        [weakSelf.monthButton setTitle:[NSString stringWithFormat:@"%ld月",dateComponents.month] forState:UIControlStateNormal];
        if (weakSelf.monthBlock) {
            weakSelf.monthBlock([NSString stringWithFormat:@"%ld",(long)dateComponents.month]);
        }
        [weakSelf.monthButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    }];
    return _monthDatePickManager;
}

@end
