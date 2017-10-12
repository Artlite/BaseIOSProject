//
// Created by Dmitry Lernatovich on 9/21/15.
// Copyright (c) 2015 Magnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageHelper : NSObject

+ (NSString *)imageToBase64:(UIImage *)image;

+ (UIImage *)base64ToImage:(NSString *)base64String;

+ (NSString *)imageToBase64:(UIImage *)image
                      width:(int)width
                     height:(int)height;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end