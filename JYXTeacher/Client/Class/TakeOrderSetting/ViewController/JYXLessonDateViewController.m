//
//  JYXLessonDateViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXLessonDateViewController.h"
#import <JTCalendar.h>
#import "JYXCalendarTimeCollectionViewCell.h"
#import "JYXHomeStudentTeacherTimeApi.h"
#import "TakeOrderSettingHandler.h"

@interface JYXLessonDateViewController ()<JTCalendarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    //选中的时间数组，添加时间到这个数组里则可以显示蓝圈，也就是选中状态
    NSMutableArray *_datesSelected;
}
@property (strong, nonatomic) NSDate *Recordtime;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (strong, nonatomic) JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) UIView *calendarMenuView;
@property (strong, nonatomic) UILabel *calendarTitleLabel;
@property (strong, nonatomic) UIButton *calendarLeftArrow;
@property (strong, nonatomic) UIButton *calendarRightArrow;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataSourceArray;
@property (strong, nonatomic) NSMutableArray   *arr_data;
@property (strong, nonatomic) NSMutableArray   *arr_dateTime;
@property (assign, nonatomic) NSInteger        selectedIndex;
@property (strong, nonatomic) NSMutableDictionary   *dic_selected;

@end

@implementation JYXLessonDateViewController
#pragma mark - lifeCycle                    - Method -

- (void)dealloc
{
    
}

- (void)loadView
{
    [super loadView];
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"授课时间设置", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.calendarManager setContentView:self.calendarContentView];
    [self.calendarManager setDate:[NSDate date]];
    _datesSelected = [NSMutableArray new];
    //初始化记录的时间
    self.Recordtime = [NSDate date];
    self.calendarTitleLabel.text = [self.Recordtime dateToString];
    
    JYXUser *user = [JYXUserManager shareInstance].user;
    [TakeOrderSettingHandler getTeacherLessonTimeWithUserid:user.userId prepare:^{
        
    } success:^(id obj) {
        self.arr_dateTime = [NSMutableArray array];
        self.arr_data = [NSMutableArray arrayWithArray:(NSArray *)obj];
        for (NSDictionary *dic in self.arr_data) {
            [self.arr_dateTime addObject:[dic objectForKey:@"date"]];
            if ([[dic objectForKey:@"times"] count] > 0) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                [self->_datesSelected addObject:[dateFormatter dateFromString:[dic objectForKey:@"date"]]];
            }
        }
        [self.calendarManager reload];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (void)setupViews
{
    [self.view addSubview:self.calendarMenuView];
    [self.calendarMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.offset(57);
    }];
    [self.calendarMenuView addSubview:self.calendarLeftArrow];
    [self.calendarLeftArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.calendarMenuView);
        make.height.offset(57);
        make.width.offset(30);
        make.left.equalTo(self.calendarMenuView).offset(27);
    }];
    [self.calendarMenuView addSubview:self.calendarRightArrow];
    [self.calendarRightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.calendarMenuView);
        make.height.offset(57);
        make.width.offset(30);
        make.right.equalTo(self.calendarMenuView).offset(-27);
    }];
    [self.calendarMenuView addSubview:self.calendarTitleLabel];
    [self.calendarTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.calendarMenuView);
    }];
    
    [self.view addSubview:self.calendarContentView];
    [self.calendarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.calendarMenuView.mas_bottom);
        make.height.offset(164);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.calendarContentView.mas_bottom).offset(30);
        make.bottom.equalTo(self.view);
    }];
}

- (void)loadData
{
    self.dataSourceArray = [@[@"06:00-07:00",@"07:00-08:00",@"08:00-09:00",@"09:00-10:00",@"10:00-11:00",@"11:00-12:00",@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00",@"20:00-21:00",@"21:00-22:00",@"22:00-23:00",@"23:00-24:00"] mutableCopy];
    //    NSArray *tmpArray = [NSArray arrayWithArray:self.dataSourceArray];
    //    NSString *currDate = [[NSDate date] hourMinuteToString];
    //    if ([self.Recordtime isToday]) {
    //        for (NSString *times in tmpArray) {
    //            BOOL result = [[times substringToIndex:2] compare:[currDate substringToIndex:2]] == NSOrderedDescending;
    //            if (result) {
    //                continue;
    //            }
    //            [self.dataSourceArray removeObject:times];
    //        }
    //    }
    //    if ([self.Recordtime compare:[NSDate date]] == NSOrderedAscending) {
    //        [self.dataSourceArray removeAllObjects];
    //        [_datesSelected removeObject:self.Recordtime];
    //        [self.calendarManager reload];
    //    }
    [self.collectionView reloadData];
}

#pragma mark - eventResponse                - Method -
//然后在点击事件里进行时间的计算
- (void)NextPageBtnClick:(UIButton *)sender {
    //通过系统的日历类来计算时间
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    //设置需要变更的时间，年，月，日，
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self.Recordtime];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    //因为我们只需要切换月份，所有直接把月数+1就可，其他为0
    [adcomps setYear:0];
    if (sender.tag == 1) {
        [adcomps setMonth:-1];
    } else {
        [adcomps setMonth:+1];
    }
    [adcomps setDay:0];
    //获得增加后的时间并记录起来
    self.Recordtime = [calendar dateByAddingComponents:adcomps toDate:_Recordtime options:0];
    //设置日历当前显示的时间
    [self.calendarManager setDate:self.Recordtime];
    //刷新日历
    [self.calendarManager reload];
    
    self.calendarTitleLabel.text = [self.Recordtime dateToString];
}

#pragma mark - customDelegate               - Method -
- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    self.Recordtime = [calendar date];
    self.calendarTitleLabel.text = [self.Recordtime dateToString];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    self.Recordtime = [calendar date];
    self.calendarTitleLabel.text = [self.Recordtime dateToString];
}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    //时差转换
    NSTimeZone *localZone=[NSTimeZone localTimeZone];
    NSInteger interval=[localZone secondsFromGMTForDate:dayView.date];
    NSInteger timeSp = [[NSNumber numberWithDouble:[dayView.date timeIntervalSince1970]] integerValue];
    NSLog(@"%ld---%ld",interval, timeSp);
    NSDate* myDate = [NSDate dateWithTimeIntervalSince1970:interval+timeSp];
//    if ([myDate isToday]) {
//        myDate = [NSDate dateWithTimeIntervalSince1970:interval+[[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] integerValue]];
//    }
    if([self isInDatesSelected:myDate]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor colorWithHex:0x1DA3FF];
        dayView.textLabel.textColor = [UIColor whiteColor];
    } else if (![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:myDate] || ([myDate compare:[NSDate date]] == NSOrderedAscending)){
        dayView.circleView.hidden = YES;
        dayView.textLabel.textColor = [UIColor colorWithHexString:@"#555555" alpha:0.3];
    } else {
        dayView.circleView.hidden = YES;
        dayView.textLabel.textColor = [UIColor colorWithHexString:@"#555555"];
    }
}
- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    //时差转换
    NSTimeZone *localZone=[NSTimeZone localTimeZone];
    NSInteger interval=[localZone secondsFromGMTForDate:dayView.date];
    NSInteger timeSp = [[NSNumber numberWithDouble:[dayView.date timeIntervalSince1970]] integerValue];
    NSLog(@"%ld---%ld",interval, timeSp);
    NSDate* myDate = [NSDate dateWithTimeIntervalSince1970:interval+timeSp];
//    if ([myDate isToday]) {
//        myDate = [NSDate dateWithTimeIntervalSince1970:interval+[[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] integerValue]];
//    }
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:myDate]){
        if([_calendarContentView.date compare:myDate] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
        return;
    }
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    if (_datesSelected.count > 0) {
        self.arr_dateTime = [NSMutableArray array];
        for (NSDictionary *dic in self.arr_data) {
            [self.arr_dateTime addObject:[dic objectForKey:@"date"]];
        }
        NSDate *date = [_datesSelected lastObject];
        if ([self.arr_dateTime containsObject:[dateFormat stringFromDate:date]]) {
            for (int i = 0;i < self.arr_data.count;i++) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.arr_data objectAtIndex:i]];
                if ([[dic objectForKey:@"date"] isEqualToString:[dateFormat stringFromDate:date]]) {
                    if ([[dic objectForKey:@"times"] count] == 0) {
                        [_datesSelected removeObject:date];
                    }
                }
            }
        }else{
            [_datesSelected removeObject:date];
        }
    }
    
    if(![self isInDatesSelected:myDate]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *str_date = [dateFormatter stringFromDate:myDate];
        [_datesSelected addObject:[dateFormatter dateFromString:str_date]];
    }
    if ([self.arr_dateTime containsObject:[dateFormat stringFromDate:myDate]]) {
        for (int i = 0;i < self.arr_data.count;i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.arr_data objectAtIndex:i]];
            if ([[dic objectForKey:@"date"] isEqualToString:[dateFormat stringFromDate:myDate]]) {
                self.dic_selected = dic;
                self.selectedIndex = i;
            }
        }
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[dateFormat stringFromDate:myDate] forKey:@"date"];
        [dic setValue:@[] forKey:@"times"];
        [self.arr_data addObject:dic];
        self.dic_selected = dic;
        self.selectedIndex = self.arr_data.count - 1;
    }
    
    //    self.Recordtime = myDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str_date = [dateFormatter stringFromDate:myDate];
    self.Recordtime = [dateFormatter dateFromString:str_date];
    [self.calendarManager reload];
    [self loadData];
}

- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar
{
    JTCalendarWeekDayView *view = [JTCalendarWeekDayView new];
    
    for(UILabel *label in view.dayViews){
        label.textColor = [UIColor colorWithHex:0x787878];
        label.font = [UIFont fontWithName:@"SimHei" size:17];
    }
    
    return view;
}

- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
{
    JTCalendarDayView *view = [JTCalendarDayView new];
    view.textLabel.font = [UIFont fontWithName:@"SimHei" size:18];
    return view;
}

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -
- (BOOL)isInDatesSelected:(NSDate *)date
{
    for(NSDate *dateSelected in _datesSelected){
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        if([[dateFormat stringFromDate:date] isEqualToString:[dateFormat stringFromDate:dateSelected]]){
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - objective-cDelegate          - Method -
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.dic_selected objectForKey:@"times"] containsObject:[self replaceSourceStrWithTimeStr:self.dataSourceArray[indexPath.row]]]) {
        NSMutableArray *arr_times = [NSMutableArray arrayWithArray:[self.dic_selected objectForKey:@"times"]];
        [arr_times removeObject:[self replaceSourceStrWithTimeStr:self.dataSourceArray[indexPath.row]]];
        [self.dic_selected setValue:arr_times forKey:@"times"];
        [self.arr_data replaceObjectAtIndex:self.selectedIndex withObject:self.dic_selected];
        [self.collectionView reloadData];
        if ([[self.dic_selected objectForKey:@"times"] count] == 0) {
            [_datesSelected removeObject:self.Recordtime];
            [self.calendarManager reload];
        }
    }else{
        NSMutableArray *arr_times = [NSMutableArray arrayWithArray:[self.dic_selected objectForKey:@"times"]];
        [arr_times addObject:[self replaceSourceStrWithTimeStr:self.dataSourceArray[indexPath.row]]];
        [self.dic_selected setValue:arr_times forKey:@"times"];
        [self.arr_data replaceObjectAtIndex:self.selectedIndex withObject:self.dic_selected];
        [self.collectionView reloadData];
        if(![self isInDatesSelected:self.Recordtime]){
            [_datesSelected addObject:self.Recordtime];
            [self.calendarManager reload];
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JYXCalendarTimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JYXCalendarTimeCollectionViewCell class]) forIndexPath:indexPath];
    [cell configCalendarTimeLabelCellWithData:self.dataSourceArray[indexPath.row]];
    if ([[self.dic_selected objectForKey:@"times"] containsObject:[self replaceSourceStrWithTimeStr:self.dataSourceArray[indexPath.row]]]) {
        cell.titleLabel.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        cell.titleLabel.textColor = [UIColor whiteColor];
    }else{
        cell.titleLabel.backgroundColor = [UIColor whiteColor];
        cell.titleLabel.textColor = [UIColor colorWithHex:0x1aabfd];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (NSString *)replaceTimeStrWithSourceStr:(NSString *)str_source{
    NSString *str_time = @"";
    if ([str_source isEqualToString:@"time06"]) {
        str_time = @"06:00-07:00";
    }else if ([str_source isEqualToString:@"time07"]){
        str_time = @"07:00-08:00";
    }else if ([str_source isEqualToString:@"time08"]){
        str_time = @"08:00-09:00";
    }else if ([str_source isEqualToString:@"time09"]){
        str_time = @"09:00-10:00";
    }else if ([str_source isEqualToString:@"time10"]){
        str_time = @"10:00-11:00";
    }else if ([str_source isEqualToString:@"time11"]){
        str_time = @"11:00-12:00";
    }else if ([str_source isEqualToString:@"time12"]){
        str_time = @"12:00-13:00";
    }else if ([str_source isEqualToString:@"time13"]){
        str_time = @"13:00-14:00";
    }else if ([str_source isEqualToString:@"time14"]){
        str_time = @"14:00-15:00";
    }else if ([str_source isEqualToString:@"time15"]){
        str_time = @"15:00-16:00";
    }else if ([str_source isEqualToString:@"time16"]){
        str_time = @"16:00-17:00";
    }else if ([str_source isEqualToString:@"time17"]){
        str_time = @"17:00-18:00";
    }else if ([str_source isEqualToString:@"time18"]){
        str_time = @"18:00-19:00";
    }else if ([str_source isEqualToString:@"time19"]){
        str_time = @"19:00-20:00";
    }else if ([str_source isEqualToString:@"time20"]){
        str_time = @"20:00-21:00";
    }else if ([str_source isEqualToString:@"time21"]){
        str_time = @"21:00-22:00";
    }else if ([str_source isEqualToString:@"time22"]){
        str_time = @"22:00-23:00";
    }else if ([str_source isEqualToString:@"time23"]){
        str_time = @"23:00-24:00";
    }
    return str_time;
}

- (NSString *)replaceSourceStrWithTimeStr:(NSString *)str_time{
    NSString *str_source = @"";
    if ([str_time isEqualToString:@"06:00-07:00"]) {
        str_source = @"time06";
    }else if ([str_time isEqualToString:@"07:00-08:00"]){
        str_source = @"time07";
    }else if ([str_time isEqualToString:@"08:00-09:00"]){
        str_source = @"time08";
    }else if ([str_time isEqualToString:@"09:00-10:00"]){
        str_source = @"time09";
    }else if ([str_time isEqualToString:@"10:00-11:00"]){
        str_source = @"time10";
    }else if ([str_time isEqualToString:@"11:00-12:00"]){
        str_source = @"time11";
    }else if ([str_time isEqualToString:@"12:00-13:00"]){
        str_source = @"time12";
    }else if ([str_time isEqualToString:@"13:00-14:00"]){
        str_source = @"time13";
    }else if ([str_time isEqualToString:@"14:00-15:00"]){
        str_source = @"time14";
    }else if ([str_time isEqualToString:@"15:00-16:00"]){
        str_source = @"time15";
    }else if ([str_time isEqualToString:@"16:00-17:00"]){
        str_source = @"time16";
    }else if ([str_time isEqualToString:@"17:00-18:00"]){
        str_source = @"time17";
    }else if ([str_time isEqualToString:@"18:00-19:00"]){
        str_source = @"time18";
    }else if ([str_time isEqualToString:@"19:00-20:00"]){
        str_source = @"time19";
    }else if ([str_time isEqualToString:@"20:00-21:00"]){
        str_source = @"time20";
    }else if ([str_time isEqualToString:@"21:00-22:00"]){
        str_source = @"time21";
    }else if ([str_time isEqualToString:@"22:00-23:00"]){
        str_source = @"time22";
    }else if ([str_time isEqualToString:@"23:00-24:00"]){
        str_source = @"time23";
    }
    return str_source;
}

- (void)rightBarAction{
    if (self.arr_data.count == 0) {
        [MBProgressHUD showInfoMessage:@"请选择时间日期"];
        return;
    }
    NSString *str_time = @"";
    for (NSDictionary *dic in self.arr_data) {
        for (NSString *str in [dic objectForKey:@"times"]) {
            str_time = [str_time stringByAppendingString:[NSString stringWithFormat:@"%@ %@,",[dic objectForKey:@"date"],[self replaceTimeStrWithSourceStr:str]]];
        }
    }
    [TakeOrderSettingHandler postTeacherLessonTimeWithTimeStr:str_time prepare:^{
        
    } success:^(id obj) {
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

#pragma mark - getters and setters          - Method -
- (UIView *)calendarMenuView
{
    if (!_calendarMenuView) {
        _calendarMenuView = [[UIView alloc] init];
    }
    return _calendarMenuView;
}

- (UIButton *)calendarLeftArrow
{
    if (!_calendarLeftArrow) {
        _calendarLeftArrow = [[UIButton alloc] init];
        [_calendarLeftArrow setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
        _calendarLeftArrow.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_calendarLeftArrow sizeToFit];
        _calendarLeftArrow.tag = 1;
        [_calendarLeftArrow addTarget:self action:@selector(NextPageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _calendarLeftArrow;
}

- (UIButton *)calendarRightArrow
{
    if (!_calendarRightArrow) {
        _calendarRightArrow = [[UIButton alloc] init];
        [_calendarRightArrow setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        _calendarRightArrow.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_calendarRightArrow sizeToFit];
        _calendarRightArrow.tag = 2;
        [_calendarRightArrow addTarget:self action:@selector(NextPageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _calendarRightArrow;
}

- (UILabel *)calendarTitleLabel
{
    if (!_calendarTitleLabel) {
        _calendarTitleLabel = [[UILabel alloc] init];
        _calendarTitleLabel.font = FONT_SIZE(18);
        _calendarTitleLabel.textColor = [UIColor colorWithHex:0x787878];
        [_calendarTitleLabel sizeToFit];
    }
    return _calendarTitleLabel;
}

- (JTCalendarManager *)calendarManager
{
    if (!_calendarManager) {
        _calendarManager = [[JTCalendarManager alloc] init];
        _calendarManager.delegate = self;
    }
    return _calendarManager;
}

- (JTHorizontalCalendarView *)calendarContentView
{
    if (!_calendarContentView) {
        _calendarContentView = [[JTHorizontalCalendarView alloc] init];
    }
    return _calendarContentView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(100, 26);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[JYXCalendarTimeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JYXCalendarTimeCollectionViewCell class])];
    }
    return _collectionView;
}

@end
