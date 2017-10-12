//
// Created by Dmitry Lernatovich on 9/8/15.
// Copyright (c) 2015 Magnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DateHelper : NSObject
+ (NSString *)dateToString:(NSDate *)date withFormat:(NSString *)format;

+ (NSDate *)stringFromDate:(NSString *)dateString withFormat:(NSString *)format;

+ (long long)nsDateToLongLong:(NSDate *)date;

+ (NSDate *)nsDateFromTimestamp:(long long)timestamp;

+ (NSDate *)nsDateFromTimestampJava:(long long)timestamp;

+ (NSString *)getDateAgoJava:(long long)timestamp;

+ (NSString *)getDateAgo:(long long)timestamp;

+ (NSString *)stringFromTimestamp:(long long)timestamp
                           format:(NSString *)format;

+ (NSString *)stringFromTimestampJava:(long long)timestamp
                               format:(NSString *)format;

+ (NSString *)getDateAgoFromDate:(NSDate *)timestamp;

+ (NSString *)dateToPosixString:(NSDate *)date withFormat:(NSString *)format;
@end