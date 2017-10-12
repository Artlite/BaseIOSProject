//
//  StringHelper.h
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/9/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringHelper : NSObject
+ (BOOL)isEmptyString:(NSString *)str;
+ (BOOL)isContainString:(NSString *)string subString:(NSString *)subString;
+ (NSString *)removeFromString:(NSString *)string
                     subString:(NSString *)subStrig;
+ (NSString *)removeCommas:(NSString *)string;
+ (BOOL)compareString:(NSString *)firstString another:(NSString *)anotherString;
+ (NSString *)removeNewLineSymbols:(NSString *)requiredString;
+ (NSString *)trimToIndex:(NSString *)originalText index:(int)index;
+ (NSString *)trim:(NSString *)originalText;
+ (NSString *)removeLastChar:(NSString *)originalText;
+ (NSString *)checkPassword:(NSString *)password
                     retype:(NSString *)retypedPassword;

@end
