//
//  JYXWaitLessonHeaderView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXWaitLessonHeaderView.h"
@interface JYXWaitLessonHeaderView ()
@property (nonatomic, strong) UIButton *dateSelectBtn;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic ,strong) NSString *monthStr;
@property (nonatomic ,strong) NSString *dayStr;
@property (nonatomic, strong) PGDatePickManager *yearAndMonthAndDayDatePickManager;
@end

@implementation JYXWaitLessonHeaderView
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
    [self.contentView addSubview:self.dateSelectBtn];
    [self.dateSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(7);
        make.right.equalTo(self.contentView).offset(-7);
        make.centerY.equalTo(self.contentView);
        make.height.offset(45);
    }];
    
    [self.contentView addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dateSelectBtn);
        make.right.equalTo(self.dateSelectBtn.mas_right).offset(-10);
        make.height.offset(13);
        make.width.offset(7);
    }];
}

- (void)configWaitLessonHeaderViewWithData:(id)model
{
    if (!model) return;
    
}

//选择日期
- (void)selectDateAction:(UIButton *)btn
{
    [kAppDelegate.window.rootViewController presentViewController:self.yearAndMonthAndDayDatePickManager animated:false completion:nil];
}

- (UIButton *)dateSelectBtn
{
    if (!_dateSelectBtn) {
        _dateSelectBtn = [[UIButton alloc] init];
        _dateSelectBtn.backgroundColor = [UIColor whiteColor];
        JYXViewBorderRadius(_dateSelectBtn, 10, 0, [UIColor clearColor]);
        [_dateSelectBtn setTitle:NSLocalizedString(@"选择日期", nil) forState:UIControlStateNormal];
        _dateSelectBtn.titleLabel.font = FONT_SIZE(18);
        [_dateSelectBtn setTitleColor:[UIColor colorWithHex:0x6d6d6d] forState:UIControlStateNormal];
        [_dateSelectBtn addTarget:self action:@selector(selectDateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dateSelectBtn;
}

- (UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = [UIImage imageNamed:@"rightArrow"];
        [_arrowImg sizeToFit];
    }
    return _arrowImg;
}

- (PGDatePickManager *)yearAndMonthAndDayDatePickManager
{
    _yearAndMonthAndDayDatePickManager = [[PGDatePickManager alloc]init];
    _yearAndMonthAndDayDatePickManager.style = PGDatePickManagerStyle1;
    _yearAndMonthAndDayDatePickManager.isShadeBackgroud = true;
    
    PGDatePicker *datePicker = _yearAndMonthAndDayDatePickManager.datePicker;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.datePickerMode = PGDatePickerModeDate;
//    datePicker.minimumDate = [self returnToDay0Clock];
    [datePicker setDate:[[NSDate date] stringToDateWithStr:self.dateSelectBtn.titleLabel.text]];
    WeakSelf(weakSelf);
    [datePicker setSelectedDate:^(NSDateComponents *dateComponents) {
        NSLog(@"%@",dateComponents);
        [weakSelf.dateSelectBtn setTitle:[NSString stringWithFormat:@"%ld年%ld月%ld日",dateComponents.year,dateComponents.month,dateComponents.day] forState:UIControlStateNormal];
        
        if (weakSelf.dateSelectSuccess) {
            if (dateComponents.month > 0 && dateComponents.month < 10) {
                self.monthStr = [NSString stringWithFormat:@"0%ld",(long)dateComponents.month];
            }else{
                self.monthStr = [NSString stringWithFormat:@"%ld",(long)dateComponents.month];
            }
            if (dateComponents.day > 0 && dateComponents.day < 10) {
                self.dayStr = [NSString stringWithFormat:@"0%ld",(long)dateComponents.day];
            }else{
               self.dayStr = [NSString stringWithFormat:@"%ld",(long)dateComponents.day];
            }
            weakSelf.dateSelectSuccess([NSString stringWithFormat:@"%ld-%@-%@",dateComponents.year,self.monthStr,self.dayStr]);
        }
    }];
    return _yearAndMonthAndDayDatePickManager;
}

//获取当天0点时间
- (NSDate *)returnToDay0Clock
{
    NSDate *now = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:now];
    int hour = (int)[dateComponent hour];
    int minute = (int)[dateComponent minute];
    int second = (int)[dateComponent second];
    //当前时分秒:hour,minute,second
    //返回当前时间(hour * 3600 + minute * 60 + second)之前的时间,即为今天凌晨0点
    NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow: - (hour * 3600 + minute * 60 + second)];
    long long inter = [nowDay timeIntervalSince1970] * 1000;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:inter / 1000];
    return newDate;
}



@end
