//
// Created by Dmitry Lernatovich on 9/8/15.
// Copyright (c) 2015 Magnet. All rights reserved.
//

#import "DateHelper.h"
#import "NSDate+DateTools.h"

@implementation DateHelper

/**
 * Method which provide the converting of the NSDate to NSString with accordance
 * to the
 * date format NSString value
 */
+ (NSString *)dateToString:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

/**
 * Method which provide the converting of the NSDate to NSString with accordance
 * to the posix
 * date format NSString value
 */
+ (NSString *)dateToPosixString:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:format];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    return [dateFormatter stringFromDate:date];
}

/**
 * Method which provide the converting of the NSString to NSDate with accordance
 * to the
 * date format NSString value
 */
+ (NSDate *)stringFromDate:(NSString *)dateString
                withFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:dateString];
}

/**
 *  Method which provide the getting of the NSString from the timestamp with
 *accordance to the current date format
 *
 *  @param timestamp current timestamp value
 *  @param format    current date format
 *
 *  @return formatted string
 */
+ (NSString *)stringFromTimestamp:(long long)timestamp
                           format:(NSString *)format {
    NSDate *date = [self nsDateFromTimestamp:timestamp];
    return [self dateToString:date withFormat:format];
}

/**
 *  Method which provide the getting of the NSString from the timestamp with
 *accordance to the current date format
 *
 *  @param timestamp current timestamp value
 *  @param format    current date format
 *
 *  @return formatted string
 */
+ (NSString *)stringFromTimestampJava:(long long)timestamp
                               format:(NSString *)format {
    NSDate *date = [self nsDateFromTimestampJava:timestamp];
    return [self dateToString:date withFormat:format];
}

/**
 * Method which provide the converting date to long long value
 */
+ (long long)nsDateToLongLong:(NSDate *)date {
    return @(date.timeIntervalSince1970).longLongValue * 1000;
}

/**
 * Method which provide converting the long long to NSDate
 */
+ (NSDate *)nsDateFromTimestamp:(long long)timestamp {
    return [[NSDate alloc] initWithTimeIntervalSince1970:timestamp];
}

/**
 * Method which provide converting the long long to NSDate
 */
+ (NSDate *)nsDateFromTimestampJava:(long long)timestamp {
    return [[NSDate alloc] initWithTimeIntervalSince1970:timestamp / 1000];
}

/**
 * Method which provide the getting of the date ago string form Java timestamp
 */
+ (NSString *)getDateAgoJava:(long long)timestamp {
    NSDate *baseDate = [self nsDateFromTimestampJava:timestamp];
    return baseDate.timeAgoSinceNow;
}

/**
 * Method which provide the getting of the date ago string form iOS timestamp
 */
+ (NSString *)getDateAgo:(long long)timestamp {
    NSDate *baseDate = [self nsDateFromTimestamp:timestamp];
    return baseDate.timeAgoSinceNow;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  method whihc provide to getting of the date ago from the NSDate
 *
 *  @param timestamp current date
 *
 *  @return date ago string value
 */
+ (NSString *)getDateAgoFromDate:(NSDate *)timestamp {
    return timestamp.timeAgoSinceNow;
}

@end