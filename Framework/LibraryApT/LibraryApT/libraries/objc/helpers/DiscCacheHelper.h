//
//  DiscCacheHelper.h
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 2/5/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DiscCacheHelper : NSObject

+ (BOOL)isFileExist:(NSString *)name;

+ (BOOL)saveFile:(NSString *)name object:(NSObject *)object;

+ (NSObject *)getFile:(NSString *)name;

+ (BOOL)removeFile:(NSString *)name;

@end
