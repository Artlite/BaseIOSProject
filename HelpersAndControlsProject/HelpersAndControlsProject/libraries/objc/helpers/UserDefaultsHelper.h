//
//  UserDefaultsHelper.h
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 11/3/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum { STRING, INTEGER, BOOLEAN, ARRAY } DataType;

@interface UserDefaultsHelper : NSObject
+ (void)saveValue:(NSString *)value key:(NSString *)key;
+ (NSString *)getValue:(NSString *)key;
+ (void)saveBoolValue:(BOOL)value key:(NSString *)key;
+ (BOOL)getBoolValue:(NSString *)key;
+ (void)saveIntegerValue:(int)value key:(NSString *)key;
+ (int)getIntegerValue:(NSString *)key;
+ (void)removeFromDefauls:(NSString *)key type:(DataType)dataType;
+ (void)saveArrayValue:(NSArray *)value key:(NSString *)key;
+ (NSArray *)getArrayValue:(NSString *)key;
@end
