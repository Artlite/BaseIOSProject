//
//  SystemHelper.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 12/18/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "SystemHelper.h"

@implementation SystemHelper

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the checking if application in background
 *
 *  @return checking value
 */
+ (BOOL)isAppInBackground {
  UIApplicationState state =
      [[UIApplication sharedApplication] applicationState];

  if (state == UIApplicationStateBackground) {
    return YES;
  }

  return NO;
}

@end
