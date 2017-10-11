//
//  NSDate+wxl.m
//  wxlCategory
//
//  Created by 李蒙 on 15/7/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "NSDate+WXL.h"

@implementation NSDate (WXL)

#pragma mark 将NSDate转为NSString
 
- (NSString *)wxl_stringWithDateFormat:(WXLDateFormat)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:[NSDate formatString:format]];
    NSString *date_time = [NSString stringWithString:[dateFormatter stringFromDate:self]];
    
    return date_time;
}

+ (NSString *)formatString:(WXLDateFormat)format
{
    NSString *formatString;
    switch (format) {
        case WXLDateFormatWithAll:
            formatString = @"yyyy-MM-dd HH:mm:ss:SS";
            break;
        case WXLDateFormatWithDateAndTime:
            formatString = @"yyyy-MM-dd HH:mm:ss";
            break;
        case WXLDateFormatWithTime:
            formatString = @"HH:mm:ss";
            break;
        case WXLDateFormatWithTimeHourMinute:
            formatString = @"HH:mm";
            break;
        case WXLDateFormatWithPreciseTime:
            formatString = @"HH:mm:ss:SS";
            break;
        case WXLDateFormatWithYearMonthDay:
            formatString = @"yyyy-MM-dd";
            break;
        case WXLDateFormatWithYearMonth:
            formatString = @"yyyy-MM";
            break;
        case WXLDateFormatWithMonthDay:
            formatString = @"MM-dd";
            break;
        case WXLDateFormatWithYear:
            formatString = @"yyyy";
            break;
        case WXLDateFormatWithMonth:
            formatString = @"MM";
            break;
        case WXLDateFormatWithDay:
            formatString = @"dd";
            break;
            
        default:
            break;
    }
    
    return formatString;
}

#pragma mark -.-

#pragma mark 取出年、月、日

- (NSDate *)wxl_subDateWithYearMothDay
{
    return [[self wxl_stringWithDateFormat:WXLDateFormatWithYearMonthDay] wxl_dateWithDateFormat:WXLDateFormatWithYearMonthDay];
}

#pragma mark 是否为今天

- (BOOL)wxl_isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    
    return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.day == nowComponents.day);
}

#pragma mark 是否为昨天

- (BOOL)wxl_isYesterday
{
    NSDate *nowDate = [[NSDate date] wxl_subDateWithYearMothDay];
    NSDate *selfDate = [self wxl_subDateWithYearMothDay];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.day == 1;
}

#pragma mark 是否为今年

- (BOOL)wxl_isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unit = NSCalendarUnitYear;

    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    
    return nowComponents.year == selfComponents.year;
}

#pragma mark 获得与当前时间的差距

- (NSDateComponents *)wxl_deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

#pragma mark - 获取日、月、年、小时、分钟、秒

- (NSUInteger)wxl_day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit) fromDate:self];
#endif
    
    return [components day];
}

- (NSUInteger)wxl_month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitMonth) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSMonthCalendarUnit) fromDate:self];
#endif
    
    return [components month];
}

- (NSUInteger)wxl_year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit) fromDate:self];
#endif
    
    return [components year];
}

- (NSUInteger)wxl_hour
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit) fromDate:self];
#endif
    
    return [components hour];
}

- (NSUInteger)wxl_minute
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitMinute) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSMinuteCalendarUnit) fromDate:self];
#endif
    
    return [components minute];
}

- (NSUInteger)wxl_second
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitSecond) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSSecondCalendarUnit) fromDate:self];
#endif
    
    return [components second];
}

#pragma mark - 获取一年的总天数

- (NSUInteger)wxl_daysInYear
{
    return [self wxl_isLeapYear] ? 366 : 365;
}

#pragma mark - 获取某月的天数

- (NSUInteger)wxl_daysInMonth:(NSUInteger)month
{
    if (month > 12) {
        
        return 0;
    }
    
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
            break;
        case 2:
            return [self wxl_isLeapYear] ? 29 : 28;
        default:
            return 30;
            break;
    }
}

#pragma mark - 判断是否是闰年

- (BOOL)wxl_isLeapYear
{
    NSUInteger year = [self wxl_year];
    
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        
        return YES;
    }
    
    return NO;
}

#pragma mark - offset后的日期

- (NSDate *)wxl_offsetYears:(NSInteger)years
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)wxl_offsetMonths:(NSInteger)months
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)wxl_offsetDays:(NSInteger)days
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)wxl_offsetHours:(NSInteger)hours
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hours];
    
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

@end

@implementation NSString (wxlDateFormat)

#pragma mark 将NSString转为NSDate

- (NSDate *)wxl_dateWithDateFormat:(WXLDateFormat)format
{
    NSDateFormatter *wxlDateFormatter = [[NSDateFormatter alloc] init];
    
    [wxlDateFormatter setDateFormat:[NSDate formatString:format]];
    NSDate *date = [wxlDateFormatter dateFromString:self];
    
    return date;
}

@end
