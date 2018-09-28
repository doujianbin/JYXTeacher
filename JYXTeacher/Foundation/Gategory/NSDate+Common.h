//
//  NSDate+Common.h
//  OC_Category合集
//
//  Created by lige on 15/10/21.
//  Copyright © 2015年 lige. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (Common)

- (BOOL) isToday1;
/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/// 时间转字符串到秒
+ (NSString *)dateToStringEndSecond:(NSDate *)date;
/// 时间转字符串到分钟
+ (NSString *)dateToStringEndMinute:(NSDate *)date;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

/**
 *  当前时间转时间戳返回字符串(只精确到秒)
 */
+(NSString *)timeStampWithNow;
/**
 *  距当前时间的差距
 */
+(NSString *)timeStampWithNowToAppoint:(NSString *)times;

/**
 *  根据一个时间转换为服务器需要的时间戳
 */
-(NSString *)timeStampString;
/**
 *  根据时间戳的字符串，返回距离当前时间的描述
 */
- (NSString *)timePastToNowOfNew:(NSString *)secondsFrom1970;
/**
 *  根据时间戳的字符串，返回距离当前时间的描述
 */
+ (NSString *)timePastToNow1:(NSString *)secondsFrom1970;
/**
 *  根据时间戳的字符串，返回距离当前时间的描述
 */
-(NSString*)timeStamp:(NSString *)stamp;
//年月日的字符串转时间戳
- (NSString *)getTimeStrWithString:(NSString *)str;

/**
 *  把日期转换为字符串
 */
-(NSString *)timeToString;
-(NSString *)dateToString;
-(NSString *)hourMinuteToString;
/**
 *  计算年龄
 */
- (NSString *)ageOfString:(NSString *)timeString;


/**
 *  把日期转换为字符串
 */
-(NSString *)timeToCurrentString;

/**
 *  把服务器的时间戳转换为年月日的字符串
 */
- (NSString *)timeStampStringToDateString:(NSString *)str;


/**
 *  把服务器的时间戳转换为yyyy-MM-dd HH:mm的字符串
 */
- (NSString *)timeStampStringToDateSecondString:(NSString *)str;

/**
 时间戳转年月日

 @param str 时间戳
 @return 返回某年某月某日
 */
+ (NSString *)timeStampToDate:(NSString *)str;

/**
 *  把服务器的时间戳转换为月日的字符串
 */
- (NSString *)timeStampToDateString:(NSString *)str;

/**
 *  把服务器的时间戳转换为月日时分的字符串
 */
- (NSString *)timeStampToMinuteString:(NSString *)str;
/// 根据一个时间返回距离1970年的毫秒数
///
/// @param dateStr 时间
///
/// @return 毫秒数
+(NSString *)timeStampStringFromDateStr:(NSString *)dateStr;
/**
 *  字符串转换为时间
 */
-(NSDate *)stringToDateWithStr:(NSString *)str;

- (NSString *)timeIntervalDescription;//距离当前的时间间隔描述
- (NSString *)minuteDescription;/*精确到分钟的日期描述*/
- (NSString *)formattedTime;
//日期星期几
- (NSString*)weekdayStringFromDate:(NSString *)timeString;
/**
 *  task时间描述
 */
-(NSString *)formattedTaskTime;
- (NSString *)formattedDateDescription;//格式化日期描述
- (long long)timeIntervalSince1970InMilliSecond;
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;
+ (NSString *)formattedTimeFromTimeInterval:(long long)time;
// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday; //是否今天
- (BOOL) isTomorrow; // 是否明天
- (BOOL) isYesterday; //是否昨天
- (BOOL) isSameWeekAsDate: (NSDate *) aDate; // 是不是同一周
- (BOOL) isThisWeek; //是这个星期
- (BOOL) isNextWeek; //是下个星期
- (BOOL) isLastWeek; //是上个星期
- (BOOL) isSameMonthAsDate: (NSDate *) aDate; //是同一个月
- (BOOL) isThisMonth; //是这个月
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear; //是今年
- (BOOL) isNextYear; //是明年
- (BOOL) isLastYear; //是去年
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;
- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

@end
