//
//  DiscCacheHelper.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 2/5/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

#import "DiscCacheHelper.h"

static NSString *const K_CACHE_EXTENSION = @".CACHE";

@implementation DiscCacheHelper

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the generating of the file path
 *
 *  @return file path
 */
+ (NSString *)getFilePath:(NSString *)name {
  NSString *channelFileName = [NSString
      stringWithFormat:@"%@%@", [name uppercaseString], K_CACHE_EXTENSION];
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                       NSUserDomainMask, YES);
  NSString *filePath =
      [paths[0] stringByAppendingPathComponent:channelFileName];
  return filePath;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide to checking if channel is already cached
 *
 *  @param channelName channel name
 *
 *  @return checking result
 */
+ (BOOL)isFileExist:(NSString *)name {
  NSString *filePath = [self getFilePath:name];
  BOOL result = ([[NSFileManager defaultManager] fileExistsAtPath:filePath] &&
                 ([NSData dataWithContentsOfFile:filePath].length > 0));
  return result;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the save file
 *
 *  @param name current file name
 *
 *  @return saving result
 */
+ (BOOL)saveFile:(NSString *)name object:(NSObject *)object {
  @try {
    [self removeFile:name];
    NSString *filePath = [self getFilePath:name];
    [NSKeyedArchiver archiveRootObject:object toFile:filePath];
    return YES;
  } @catch (NSException *exception) {
    return NO;
  }
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the getting cached object
 *
 *  @param name current object name
 *
 *  @return cached object
 */
+ (NSObject *)getFile:(NSString *)name {
  NSString *filePath = [self getFilePath:name];
  if ([self isFileExist:name]) {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
  }
  return nil;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the file removing
 *
 *  @param name file name
 *
 *  @return success value
 */
+ (BOOL)removeFile:(NSString *)name {
  NSString *filePath = [self getFilePath:name];
  NSError *error;
  BOOL isSuccess =
      [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
  return isSuccess;
}

@end
