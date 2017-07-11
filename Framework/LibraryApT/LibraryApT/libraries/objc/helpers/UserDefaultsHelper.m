//
//  UserDefaultsHelper.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 11/3/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "UserDefaultsHelper.h"

static NSString *const K_PREFIX_STRING_KEY = @"K_STRING_";
static NSString *const K_PREFIX_INTEGER_KEY = @"K_INTEGER_";
static NSString *const K_PREFIX_BOOLEAN_KEY = @"K_BOOLEAN_";
static NSString *const K_PREFIX_ARRAY_KEY = @"K_ARRAY_";

@implementation UserDefaultsHelper

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide to getting of the user defaults
 *
 *  @return user defaults
 */
+ (NSUserDefaults *)getUserDefaults {
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark - NSString methods

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide the saving value for the key
 *
 *  @param value value
 *  @param key   key
 */
+ (void)saveValue:(NSString *)value key:(NSString *)key {
    [[self getUserDefaults]
     setValue:value
     forKey:[[NSString stringWithFormat:@"%@%@", K_PREFIX_STRING_KEY, key]
             uppercaseString]];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the getting value from the user defaults
 *
 *  @param key user defaults key
 *
 *  @return user defaults value
 */
+ (NSString *)getValue:(NSString *)key {
    return [[self getUserDefaults]
            stringForKey:[[NSString stringWithFormat:@"%@%@", K_PREFIX_STRING_KEY,
                           key] uppercaseString]];
}

#pragma mark - BOOL methods

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide the saving value for the key
 *
 *  @param value value
 *  @param key   key
 */
+ (void)saveBoolValue:(BOOL)value key:(NSString *)key {
    [[self getUserDefaults]
     setBool:value
     forKey:[[NSString stringWithFormat:@"%@%@", K_PREFIX_BOOLEAN_KEY, key]
             uppercaseString]];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the getting value from the user defaults
 *
 *  @param key user defaults key
 *
 *  @return user defaults value
 */
+ (BOOL)getBoolValue:(NSString *)key {
    return [[self getUserDefaults]
            boolForKey:[[NSString stringWithFormat:@"%@%@", K_PREFIX_BOOLEAN_KEY, key]
                        uppercaseString]];
}

#pragma mark - int methods
/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide the saving value for the key
 *
 *  @param value value
 *  @param key   key
 */
+ (void)saveIntegerValue:(int)value key:(NSString *)key {
    [[self getUserDefaults]
     setInteger:value
     forKey:[[NSString stringWithFormat:@"%@%@", K_PREFIX_INTEGER_KEY, key]
             uppercaseString]];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the getting value from the user defaults
 *
 *  @param key user defaults key
 *
 *  @return user defaults value
 */
+ (int)getIntegerValue:(NSString *)key {
    return @([[self getUserDefaults]
              integerForKey:[[NSString stringWithFormat:@"%@%@",
                              K_PREFIX_INTEGER_KEY,
                              key] uppercaseString]])
    .intValue;
}

#pragma mark - array methods
/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide the saving value for the key
 *
 *  @param value value
 *  @param key   key
 */
+ (void)saveArrayValue:(NSArray *)value key:(NSString *)key {
    [[self getUserDefaults]
     setObject:value
     forKey:[[NSString stringWithFormat:@"%@%@", K_PREFIX_ARRAY_KEY, key]
             uppercaseString]];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the getting value from the user defaults
 *
 *  @param key user defaults key
 *
 *  @return user defaults value
 */
+ (NSArray *)getArrayValue:(NSString *)key {
    return (NSArray *) [[self getUserDefaults]
              objectForKey:[[NSString stringWithFormat:@"%@%@",
                              K_PREFIX_ARRAY_KEY,
                              key] uppercaseString]];
}

#pragma mark - global methods

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the removing of the object from the user defaults
 *
 *  @param key for remove
 */
+ (void)removeFromDefauls:(NSString *)key type:(DataType)dataType {
    NSString *dataTypeString = K_PREFIX_STRING_KEY;
    switch (dataType) {
        case STRING:
            dataTypeString = K_PREFIX_STRING_KEY;
            break;
        case INTEGER:
            dataTypeString = K_PREFIX_INTEGER_KEY;
            break;
        case BOOLEAN:
            dataTypeString = K_PREFIX_BOOLEAN_KEY;
            break;
        case ARRAY:
            dataTypeString = K_PREFIX_ARRAY_KEY;
            break;
        default:
            break;
    }
    [[self getUserDefaults]
     removeObjectForKey:[[NSString stringWithFormat:@"%@%@", dataTypeString,
                          key] uppercaseString]];
}

@end
