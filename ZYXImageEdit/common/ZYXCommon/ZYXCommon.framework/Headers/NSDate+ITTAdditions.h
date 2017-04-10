//
//  NSDate+ITTAdditions.h
//
//  Created by guo hua on 11-9-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate(ITTAdditions)
+ (NSString *)timeStringWithInterval:(NSTimeInterval) time;
+ (NSString *) timeDayStringWithInterval:(NSTimeInterval)time;
+ (NSDate *)dateWithString:(NSString *)str formate:(NSString *)formate;
+ (NSDate *)relativedDateWithInterval:(NSInteger)interval;
+ (NSInteger)howManyDaysInYear:(NSInteger)year Month:(NSInteger)imonth;

- (NSString *)timeString;
- (NSString *)timeDayString;
- (NSString *)stringWithSeperator:(NSString *)seperator;
- (NSString *)stringWithFormat:(NSString*)format;
- (NSString *)stringWithSeperator:(NSString *)seperator includeYear:(BOOL)includeYear;
- (NSDate *)relativedDateWithInterval:(NSInteger)interval ;
- (NSString *)weekdayStr;
- (NSInteger)totalDaysFromDate:(NSDate*)fromDate;
- (NSString*)chineseMonthStr;
- (NSInteger)howManyDays;
- (NSInteger) timeDaysWithInterval:(NSTimeInterval)time;
-(NSDate *)lastMonth;
-(NSDate *)nextMonth;
-(NSDate*)lastDate;
- (NSDate*)nextDate;
@end