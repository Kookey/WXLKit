//
//  NSDate+wxl.h
//  wxlCategory
//
//  Created by 李蒙 on 15/7/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    /**
     *  e.g.2014-03-04 13:23:35:67
     */
    WXLDateFormatWithAll,
    /**
     *  e.g.2014-03-04 13:23:35
     */
    WXLDateFormatWithDateAndTime,     //
    /**
     *  e.g.13:23:35
     */
    WXLDateFormatWithTime,
    /**
     *  e.g.13:23
     */
    WXLDateFormatWithTimeHourMinute,
    /**
     *  e.g.13:23:35:67
     */
    WXLDateFormatWithPreciseTime,
    
    /**
     *  e.g.2014-03-04
     */
    WXLDateFormatWithYearMonthDay,
    /**
     *  e.g.2014-03
     */
    WXLDateFormatWithYearMonth,
    /**
     *  e.g.03-04
     */
    WXLDateFormatWithMonthDay,
    /**
     *  e.g.2014
     */
    WXLDateFormatWithYear,
    /**
     *  e.g.03
     */
    WXLDateFormatWithMonth,
    /**
     *  e.g.04
     */
    WXLDateFormatWithDay,
} WXLDateFormat;

@interface NSDate (WXL)

/**
 *  将NSDate转为NSString
 *
 *  @param format wxlDateFormat
 *
 *  @return NSString
 */
- (NSString *)wxl_stringWithDateFormat:(WXLDateFormat)format;

/**
 *  取出年、月、日
 *
 *  @return e.g.2015-01-02
 */
- (NSDate *)wxl_subDateWithYearMothDay;

/**
 *  是否为今天
 *
 *  @return 是/不是
 */
- (BOOL)wxl_isToday;

/**
 *  是否为昨天
 *
 *  @return 是/不是
 */
- (BOOL)wxl_isYesterday;

/**
 *  是否为今年
 *
 *  @return 是/不是
 */
- (BOOL)wxl_isThisYear;

/**
 *  获得与当前时间的差距
 *
 *  @return NSDateComponents
 */
- (NSDateComponents *)wxl_deltaWithNow;

/**
 *  获取日
 *
 *  @return 日
 */
- (NSUInteger)wxl_day;

/**
 *  获取月
 *
 *  @return 月
 */
- (NSUInteger)wxl_month;

/**
 *  获取年
 *
 *  @return 年
 */
- (NSUInteger)wxl_year;

/**
 *  获取小时
 *
 *  @return 小时
 */
- (NSUInteger)wxl_hour;

/**
 *  获取分钟
 *
 *  @return 分钟
 */
- (NSUInteger)wxl_minute;

/**
 *  获取秒
 *
 *  @return 秒
 */
- (NSUInteger)wxl_second;

/**
 *  获取一年的总天数
 *
 *  @return 天
 */
- (NSUInteger)wxl_daysInYear;

/**
 *  获取某月的天数
 *
 *  @param month 月
 *
 *  @return 获取某月的天数
 */
- (NSUInteger)wxl_daysInMonth:(NSUInteger)month;

/**
 *  判断是否是闰年
 *
 *  @return 闰年/平年
 */
- (BOOL)wxl_isLeapYear;

/**
 *  years年后的日期
 *
 *  @param years 年
 *
 *  @return 日期
 */
- (NSDate *)wxl_offsetYears:(NSInteger)years;

/**
 *  months月后的日期
 *
 *  @param months 月
 *
 *  @return 日期
 */
- (NSDate *)wxl_offsetMonths:(NSInteger)months;

/**
 *  days天的日期
 *
 *  @param days 天
 *
 *  @return 日期
 */
- (NSDate *)wxl_offsetDays:(NSInteger)days;

/**
 *  hours小时后的日期
 *
 *  @param hours 小时
 *
 *  @return 日期
 */
- (NSDate *)wxl_offsetHours:(NSInteger)hours;

@end

@interface NSString (wxlDateFormat)

/**
 *  将NSString转为NSDate
 *
 *  @param format wxlDateFormat
 *
 *  @return NSDate
 */
- (NSDate *)wxl_dateWithDateFormat:(WXLDateFormat)format;

@end
