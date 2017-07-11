//
// Created by Dmitry Lernatovich on 9/21/15.
// Copyright (c) 2015 Magnet. All rights reserved.
//

#import "ImageHelper.h"

static const float K_IMAGE_QUALITY = 0.3f;

@implementation ImageHelper

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the converting the image for the Base64 value
 *
 *  @param image current image
 *
 *  @return current Base64 value
 */
+ (NSString *)imageToBase64:(UIImage *)image {
  return [UIImageJPEGRepresentation(image, K_IMAGE_QUALITY)
      base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the converting the image for the Base64 value with
 *resizing
 *
 *  @param image  current image
 *  @param width  current width
 *  @param height current height
 *
 *  @return current Base64 value
 */
+ (NSString *)imageToBase64:(UIImage *)image
                      width:(int)width
                     height:(int)height {
  UIImage *resizedImage =
      [self imageWithImage:image scaledToSize:CGSizeMake(width, height)];
  return [UIImageJPEGRepresentation(resizedImage, K_IMAGE_QUALITY)
      base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide the converting the Base64 value to UIimage
 *
 *  @param base64String current Base64 value
 *
 *  @return current image
 */
+ (UIImage *)base64ToImage:(NSString *)base64String {
  NSData *data = [[NSData alloc]
      initWithBase64EncodedString:base64String
                          options:NSDataBase64DecodingIgnoreUnknownCharacters];
  return [UIImage imageWithData:data];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide the resizing of the image
 *
 *  @param image   current image
 *  @param newSize destination size
 *
 *  @return resized UIImage
 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
  CGFloat widthRatio = newSize.width / image.size.width;
  CGFloat heightRatio = newSize.height / image.size.height;
  if (widthRatio > heightRatio) {
    newSize = CGSizeMake(image.size.width * heightRatio,
                         image.size.height * heightRatio);
  } else {
    newSize = CGSizeMake(image.size.width * widthRatio,
                         image.size.height * widthRatio);
  }
  UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
  [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return newImage;
}

@end