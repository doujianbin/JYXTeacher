//
//  NSDate+Common.m
//  OC_Category合集
//
//  Created by lige on 15/10/21.
//  Copyright © 2015年 lige. All rights reserved.
//

#import "NSDate+Common.h"
#import "NSDateFormatter+Category.h"

#pragma clang diagnostic push
#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSWeekCalendarUnit |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (Common)

- (BOOL) isToday1
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}


-(NSDate *)stringToDateWithStr:(NSString *)str
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    //    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormat setDateFormat:@"yyyy年MM月dd日"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate *date =[dateFormat dateFromString:str];
    return date;
}

+ (NSString *)dateToStringEndSecond:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* s1 = [dateFormatter stringFromDate:date];
    return s1;
}

+ (NSString *)dateToStringEndMinute:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* s1 = [dateFormatter stringFromDate:date];
    return s1;
}

/**
 *  把服务器的时间戳转换为年月日的字符串
 */
- (NSString *)timeStampStringToDateString:(NSString *)str
{
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:[str doubleValue]];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
    
    return [dateFormat stringFromDate:detaildate];
}

- (NSString *)timeStampStringToDateSecondString:(NSString *)str
{
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:[str doubleValue]];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];//设定时间格式,这里可以设置成自己需要的格式
    
    return [dateFormat stringFromDate:detaildate];
}

/**
 *  把服务器的时间戳转换为年月日的字符串
 */
+ (NSString *)timeStampToDate:(NSString *)str
{
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:[str doubleValue]];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
    
    return [dateFormat stringFromDate:detaildate];
}

/**
 *  把服务器的时间戳转换为月日的字符串
 */
- (NSString *)timeStampToDateString:(NSString *)str {
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:[str doubleValue]/1000];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"MM月dd日"];//设定时间格式,这里可以设置成自己需要的格式
    
    return [dateFormat stringFromDate:detaildate];
}

/**
 *  把服务器的时间戳转换为月日时分的字符串
 */
- (NSString *)timeStampToMinuteString:(NSString *)str {
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:[str doubleValue]/1000];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"MM.dd HH:mm"];//设定时间格式,这里可以设置成自己需要的格式
    
    return [dateFormat stringFromDate:detaildate];
}

- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}



- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}
/**
 *  当前时间转时间戳返回字符串(精确到毫秒)
 */
+(NSString *)timeStampWithNow
{
    return [NSString stringWithFormat:@"%ld",(long)([[NSDate  date] timeIntervalSince1970]*1000)];
}

+(NSString *)timeStampWithNowToAppoint:(NSString *)times
{
    return [NSString stringWithFormat:@"%ld",times.integerValue - (long)([[NSDate  date] timeIntervalSince1970])];
}

//字符串转时间戳 如：2017-4-10 17:15:10
- (NSString *)getTimeStrWithString:(NSString *)str {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}

/**
 *  根据一个时间转换为服务器需要的时间戳
 */
-(NSString *)timeStampString
{
    return [NSString stringWithFormat:@"%lld",(long long)([[NSDate  date] timeIntervalSince1970]*1000)];
}
/**
 *  根据时间戳的字符串，返回距离当前时间的描述
 *
 */
+ (NSString *)timePastToNow:(NSString *)secondsFrom1970
{
    NSString *stringTime;
    NSDate * date=[NSDate date];
    NSTimeInterval seconds=[date timeIntervalSince1970];
    NSTimeInterval timeDistance=seconds-secondsFrom1970.floatValue;
    NSInteger aYearTime = 365 * 24 * 60 * 60;
    NSInteger halfYearTime = 182 * 24 * 60 * 60;
    NSInteger aQuarterTime = 90 * 24 * 60 * 60;
    NSInteger aMonthTime = 30 * 24 * 60 * 60;
    NSInteger aWeekTime = 7 * 24 * 60 * 60;
    NSInteger aDayTime = 24 * 60 * 60;
    NSInteger aHourTime = 60 * 60;
    
    if (timeDistance >= aYearTime) {
        stringTime = @" 一年前";
    } else if(timeDistance >= halfYearTime) {
        stringTime = @" 半年前";
    } else if(timeDistance >= aQuarterTime) {
        stringTime = @" 一个季度前";
    } else if(timeDistance >= aMonthTime) {
        stringTime = @" 一个月前";
    } else if(timeDistance >= aWeekTime) {
        stringTime = @" 一周前";
    } else if(timeDistance >= aDayTime) {
        NSInteger days = (NSInteger)(timeDistance / aDayTime);
        stringTime = [NSString stringWithFormat:@"%zd 天前", days];
    } else if(timeDistance >= aHourTime) {
        NSInteger hours = (NSInteger)(timeDistance / aHourTime);
        stringTime = [NSString stringWithFormat:@"%zd 小时前", hours];
    } else if(timeDistance >= 60) {
        NSInteger minutes = (NSInteger)(timeDistance / 60);
        stringTime = [NSString stringWithFormat:@"%zd 分钟前", minutes];
    } else {
        stringTime = @"刚刚  ";
    }
    
    return stringTime;
}
- (NSString *)timePastToNowOfNew:(NSString *)secondsFrom1970
{
    NSString *stringTime;
    NSDate * date=[NSDate date];
    NSTimeInterval seconds=[date timeIntervalSince1970]*1000;
    NSTimeInterval timeDistance=seconds-secondsFrom1970.floatValue;
    
    secondsFrom1970=[secondsFrom1970 substringToIndex:10];
    NSInteger aHourTime = 60 * 60;
    NSTimeInterval time=[secondsFrom1970 doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *ayear=[formatter stringFromDate:[NSDate date]];
    NSString *year=[ayear substringWithRange:NSMakeRange(0, 4)];
    NSString *current=[formatter stringFromDate:detaildate];//得到日期
    NSString *today=[self today];//今天的日期2014-11-07
    NSString *yesterday=[self gotoYesterday:today];//昨天的日期2014-11-06
    NSRange range = NSMakeRange(0, 11);
    NSString *isYestoday=[current substringWithRange:range];
    
    timeDistance=timeDistance/1000;
    
    if(timeDistance<=60){
        stringTime =@"刚刚  ";
    }else if (timeDistance>60&&timeDistance<=60*60){
        NSInteger minutes = (NSInteger)(timeDistance / 60);
        stringTime = [NSString stringWithFormat:@"%zd分钟前", (long)minutes];
        
    }else if (timeDistance>60*60&&timeDistance<=12*60*60){
        NSInteger hours = (NSInteger)(timeDistance / aHourTime);
        stringTime = [NSString stringWithFormat:@"%zd小时前", (long)hours];
    }else if (timeDistance>12*60*60){
        if ([isYestoday isEqualToString:yesterday]){
            stringTime = @"昨天";
        }else if([current hasPrefix:year]){
            stringTime =[NSString stringWithFormat:@"%@",[current substringWithRange:NSMakeRange(5, 5)]];
            
        }else if(![current hasPrefix:year]){
            stringTime =[NSString stringWithFormat:@"%@",[current substringWithRange:NSMakeRange(0, 11)]];;
            
        }
        
    }
    
    
    
    
    
    return stringTime;
}
/**
 *  根据时间戳的字符串，返回距离当前时间的描述
 *
 */
+ (NSString *)timePastToNow1:(NSString *)stamp
{
    //    NSString *stringTime;
    //    NSDate * date=[NSDate date];
    //    NSTimeInterval seconds=[date timeIntervalSince1970];
    //    NSTimeInterval timeDistance=seconds-secondsFrom1970.floatValue/1000;
    //    NSInteger aYearTime = 365 * 24 * 60 * 60;
    //    NSInteger halfYearTime = 182 * 24 * 60 * 60;
    //    NSInteger aQuarterTime = 90 * 24 * 60 * 60;
    //    NSInteger aMonthTime = 30 * 24 * 60 * 60;//一个月
    //    NSInteger aWeekTime = 7 * 24 * 60 * 60;//一星期
    //    NSInteger aDayTime = 24 * 60 * 60;//一天
    //    NSInteger aHourTime = 60 * 60;//一小时
    //    if(timeDistance<60||!timeDistance){
    //        stringTime = @"刚刚进入";
    //    }else if(timeDistance >= 60&&timeDistance<=60*60) {
    //        NSInteger minutes = (NSInteger)(timeDistance / 60);
    //        stringTime = [NSString stringWithFormat:@"%d分钟前进入", minutes];
    //    }else if(timeDistance >= aHourTime&&timeDistance<=60*60*24) {
    //        NSInteger hours = (NSInteger)(timeDistance / aHourTime);
    //        stringTime = [NSString stringWithFormat:@"%d小时前进入", hours];
    //    }else if(timeDistance >= aDayTime&&timeDistance<=aWeekTime) {
    //        NSInteger days = (NSInteger)(timeDistance / aDayTime);
    //        stringTime = [NSString stringWithFormat:@"%d天前进入", days];
    //    }else if(timeDistance >= aWeekTime&&timeDistance<=aMonthTime) {
    //        stringTime = @"一周前进入";
    //    }else if(timeDistance >= aMonthTime&&timeDistance<=aQuarterTime) {
    //        stringTime = @"一个月前进入";
    //    } else if(timeDistance >= aQuarterTime&&timeDistance<=halfYearTime) {
    //        stringTime = @"三个月前进入";
    //    }else if(timeDistance >= halfYearTime&&timeDistance<=aYearTime) {
    //        stringTime = @"半年前进入";
    //    }else if (timeDistance > aYearTime){
    //        stringTime = @"一年前进入";
    //    }
    //
    //    return stringTime;
    
    //今天
    NSDate * dateToday=[NSDate date];
    NSDateFormatter * format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString * today=[format stringFromDate:dateToday];
    NSInteger timeInt=[stamp floatValue]/1000;
    
    
    
    
    stamp=[NSString stringWithFormat:@"%zd",timeInt];
    
    NSString *stringTime;
    NSDate * date=[NSDate date];
    NSTimeInterval seconds=[date timeIntervalSince1970];
    NSTimeInterval timeDistance=seconds-stamp.floatValue;
    NSTimeInterval time=[stamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *ayear=[formatter stringFromDate:[NSDate date]];
    NSString *year=[ayear substringWithRange:NSMakeRange(0, 4)];
    NSString *current=[formatter stringFromDate:detaildate];//得到日期
    NSRange range = NSMakeRange(0, 10);
    NSString *isYestoday=[current substringWithRange:range];
    
    if ([isYestoday isEqualToString:today]) {
        //            if(timeDistance >= 60) {
        //                NSInteger minutes = (NSInteger)(timeDistance / 60);
        //                stringTime = [NSString stringWithFormat:@"%d分钟前", minutes];
        //                return stringTime;
        //            } else {
        //                stringTime = @"刚刚";
        //                return  stringTime;
        //            }
        
        if (timeDistance <  60) {
            stringTime = @"刚刚  ";
            return  stringTime;
        }else if(timeDistance>60&&timeDistance<=60*60){
            NSInteger minutes = (NSInteger)(timeDistance / 60);
            stringTime = [NSString stringWithFormat:@"%zd分钟前", minutes];
            return stringTime;
            
        }else{
            
            NSInteger minutes = (NSInteger)(timeDistance / 60 /60);
            stringTime = [NSString stringWithFormat:@"%zd小时前", minutes];
            return stringTime;
        }
        
        
    }
    
    else{//不是今天
        if ([current hasPrefix:year]) {//今年
            NSString *finalTime=[NSString stringWithFormat:@"%@",[current substringFromIndex:5]];
            return finalTime;
        }else{
            return [[formatter stringFromDate:detaildate] substringToIndex:10];
        }
    }
    
}


/**
 *  时间戳转成
 *
 */
- (NSString *)ageOfString:(NSString *)timeString{
    NSDate * date=[NSDate date];
    NSTimeInterval seconds=[date timeIntervalSince1970];
    NSTimeInterval timeDistance=seconds-timeString.floatValue/1000;
    NSInteger age = timeDistance/(365*60*60*24);
    return [NSString stringWithFormat:@" %zd岁",age];
}



/**
 *  时间戳转化为时间字符串
 *
 *  @param stamp 时间戳
 *
 *  @return 具体的年月日时分秒
 */
-(NSString*)timeStamp:(NSString *)stamp{
    
    stamp=[stamp substringToIndex:10];
    
    NSString *stringTime;
    NSDate * date=[NSDate date];
    NSTimeInterval seconds=[date timeIntervalSince1970];
    NSTimeInterval timeDistance=seconds-stamp.floatValue;
    NSInteger aHourTime = 60 * 60;
    NSTimeInterval time=[stamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *ayear=[formatter stringFromDate:[NSDate date]];
    NSString *year=[ayear substringWithRange:NSMakeRange(0, 4)];
    NSString *current=[formatter stringFromDate:detaildate];//得到日期
    NSString *today=[self today];//今天的日期2014-11-07
    NSString *yesterday=[self gotoYesterday:today];//昨天的日期2014-11-06
    NSRange range = NSMakeRange(0, 10);
    NSString *isYestoday=[current substringWithRange:range];
    if(timeDistance >= aHourTime) {//大于一小时
        
        if ([isYestoday isEqualToString:today]) {
            
            if ([current substringWithRange:NSMakeRange(11, 2)].floatValue<12) {
                NSString *finalTime=[NSString stringWithFormat:@"上午 %@",[current substringFromIndex:11]];
                return finalTime;
            }else{
                NSString *finalTime=[NSString stringWithFormat:@"下午 %@",[current substringFromIndex:11]];
                return finalTime;
            }
        }
        else if ([isYestoday isEqualToString:yesterday]) {
            NSString *finalTime=[NSString stringWithFormat:@"昨天 %@",[current substringFromIndex:11]];
            return finalTime;
        }
        else{
            if ([current hasPrefix:year]) {//今年
                NSString *finalTime=[NSString stringWithFormat:@"%@",[current substringFromIndex:5]];
                return finalTime;
            }else{
                return [[formatter stringFromDate:detaildate] substringToIndex:10];
            }
        }
        
    } else if(timeDistance >= 60) {
        NSInteger minutes = (NSInteger)(timeDistance / 60);
        stringTime = [NSString stringWithFormat:@"%zd分钟前", minutes];
        return stringTime;
    } else {
        stringTime = @"刚刚  ";
        return  stringTime;
    }
    
}
/**
 *  当天时间的字符串
 *
 */
-(NSString *)today
{
    NSDate * date=[NSDate date];
    NSDateFormatter * format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    NSString * todayStr=[format stringFromDate:date];
    return todayStr;
}

/**
 *  前一天日期的字符串
 *
 */
-(NSString *)gotoYesterday:(NSString *)dayStr
{
    NSDateFormatter * dateFormater=[[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"yyyy年MM月dd日"];
    NSDate * date=[dateFormater dateFromString:dayStr];
    NSTimeInterval oneDay=-3600*24;
    NSDate * yesterday=[date dateByAddingTimeInterval:oneDay];
    NSString * yesterdayStr=[dateFormater stringFromDate:yesterday];
    return yesterdayStr;
}
/**
 *  把日期转换为字符串
 */
-(NSString *)timeToString
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    return [dateFormat stringFromDate:self];
}

/**
 *  把日期转换为字符串时分
 */
-(NSString *)hourMinuteToString
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"HH:mm"];//设定时间格式,这里可以设置成自己需要的格式
    return [dateFormat stringFromDate:self];
}

/**
 *  把日期转换为字符串
 */
-(NSString *)dateToString
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy年MM月"];//设定时间格式,这里可以设置成自己需要的格式
    return [dateFormat stringFromDate:self];
}

#define D_HOUR		3600

- (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

/**
 *  根据当前时间返回相应字符串
 */
- (NSString *)timeToCurrentString
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSString * dateNow = [dateFormat stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    NSInteger hour = [self hoursAfterDate:date];
    
    NSDateFormatter *dateFormatter = nil;
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [self dateFormatterWithFormat:@"HH:mm"];
        }else if (hour < 0 && hour >= -24) {
            dateFormatter = [self dateFormatterWithFormat:@"昨天HH:mm"];
        }else {
            dateFormatter = [self dateFormatterWithFormat:@"yyyy-MM-dd"];
        }
        
    }else {
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [self dateFormatterWithFormat:@"凌晨hh:mm"];
        }else if (hour > 6 && hour <=11 ) {
            dateFormatter = [self dateFormatterWithFormat:@"上午hh:mm"];
        }else if (hour > 11 && hour <= 17) {
            dateFormatter = [self dateFormatterWithFormat:@"下午hh:mm"];
        }else if (hour > 17 && hour <= 24) {
            dateFormatter = [self dateFormatterWithFormat:@"晚上hh:mm"];
        }else if (hour < 0 && hour >= -24){
            dateFormatter = [self dateFormatterWithFormat:@"昨天HH:mm"];
        }else  {
            dateFormatter = [self dateFormatterWithFormat:@"yyyy-MM-dd"];
        }
        
    }
    
    return [dateFormatter stringFromDate:self];
}

/*距离当前的时间间隔描述*/
- (NSString *)timeIntervalDescription
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return NSLocalizedString(@"NSDateCategory.text1", @"");
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text2", @""), timeInterval / 60];
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3", @""), timeInterval / 3600];
    } else if (timeInterval < 2592000) {//30天内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text4", @""), timeInterval / 86400];
    } else if (timeInterval < 31536000) {//30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text5", @"")];
        return [dateFormatter stringFromDate:self];
    } else {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text6", @""), timeInterval / 31536000];
    }
}

/*精确到分钟的日期描述*/
- (NSString *)minuteDescription
{
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
    
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text7", @'"'), [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] < 86400 * 7) {//间隔一周内
        [dateFormatter setDateFormat:@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else {//以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd ah:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

/*标准时间日期描述*/
-(NSString *)formattedTaskTime{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    
//    NSInteger hour = [self hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
//    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
//    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
//    BOOL hasAMPM = containsA.location != NSNotFound;
    
    dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"YYYY-MM-dd"];
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
}

/*标准时间日期描述*/
-(NSString *)formattedTime{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    
    NSInteger hour = [self hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"HH:mm"];
        }else if (hour < 0 && hour >= -24) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text8", @"")];
        }else {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
        }
    }else {
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text9", @"")];
        }else if (hour > 6 && hour <=11 ) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text10", @"")];
        }else if (hour > 11 && hour <= 17) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text11", @"")];
        }else if (hour > 17 && hour <= 24) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text12", @"")];
        }else if (hour < 0 && hour >= -24){
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text13", @"")];
        }else  {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
        }
        
    }
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
}


/*格式化日期描述*/
- (NSString *)formattedDateDescription
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    
    NSInteger timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return NSLocalizedString(@"NSDateCategory.text1", @"");
    } else if (timeInterval < 3600) {//1小时内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text2", @""), timeInterval / 60];
    } else if (timeInterval < 21600) {//6小时内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3", @""), timeInterval / 3600];
    } else if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text14", @""), [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text7", @""), [dateFormatter stringFromDate:self]];
    } else {//以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

- (long long)timeIntervalSince1970InMilliSecond {
    long long ret;
    ret = [self timeIntervalSince1970] * 1000;
    
    return ret;
}

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

+ (NSString *)formattedTimeFromTimeInterval:(long long)time{
    return [[NSDate dateWithTimeIntervalInMilliSecondSince1970:time] formattedTime];
}

#pragma mark Relative Dates

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *) dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
//    NSDateComponents *c = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL) isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.week != components2.week) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL) isThisYear
{
    // Thanks, baspellis
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL) isLastYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL) isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL) isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}


#pragma mark Roles
- (BOOL) isTypicallyWeekend
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSWeekdayCalendarUnit fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

#pragma mark Adjusting Dates

- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
    return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
    return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
    return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *) dateAtStartOfDay
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
    NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark Decomposing Dates

- (NSInteger) nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
    return components.hour;
}

- (NSInteger) hour
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.hour;
}

- (NSInteger) minute
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.minute;
}

- (NSInteger) seconds
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.second;
}

- (NSInteger) day
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.day;
}

- (NSInteger) month
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.month;
}

- (NSInteger) week
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.week;
}

- (NSInteger) weekday
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger) year
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.year;
}
/// 根据一个时间字符串返回距离1970年的毫秒数
///
/// @param dateStr 时间
///
/// @return 毫秒数
+ (NSString *)timeStampStringFromDateStr:(NSString *)dateStr
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date = [dateFormat dateFromString:dateStr];
//    NSString * dateNow = [dateFormat stringFromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%lld",(long long)([date timeIntervalSince1970]*1000)];
}

//时间戳转换成日期星期几
- (NSString*)weekdayStringFromDate:(NSString *)timeString
{
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeString integerValue]];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六",  nil];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:nd];
    //日期
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM月dd日"];
    NSString *dateString = [dateFormat stringFromDate:nd];
    //星期几
    NSString *weekday = [weekdays objectAtIndex:theComponents.weekday];
    //时间
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"HH:mm"];
    NSString *timesString = [dateFormat1 stringFromDate:nd];
    return [NSString stringWithFormat:@"%@ %@ %@",dateString,weekday,timesString];
    
}

@end
