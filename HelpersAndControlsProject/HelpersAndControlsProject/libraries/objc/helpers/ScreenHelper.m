//
//  ScreenHelper.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/22/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "ScreenHelper.h"

@implementation ScreenHelper

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the getting of the iOS screen size
 *
 *  @return current screen size
 */
+ (CGRect)getScreenSize {
  CGRect screenRect = [[UIScreen mainScreen] bounds];
  return screenRect;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the getting of the screen height
 *
 *  @return current screen height
 */
+ (CGFloat)getScreenHeight {
  CGRect size = [self getScreenSize];
  return size.size.height;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the getting of the screen width
 *
 *  @return current screen width
 */
+ (CGFloat)getScreenWitdh {
  CGRect size = [self getScreenSize];
  return size.size.width;
}

@end
