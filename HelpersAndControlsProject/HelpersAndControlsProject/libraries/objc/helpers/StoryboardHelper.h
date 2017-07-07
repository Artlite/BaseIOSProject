//
//  StoryboardManager.h
//  M.A.C.
//
//  Created by Vladimir Yevdokimov on 5/15/15.
//  Copyright (c) 2015 magnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StoryboardHelper : NSObject

/**
 *  Make defined storyboard as application root
 */
+ (void)initiateStoryboard:(NSString *)storyboard;

/**
 *  Get controllers from defines storyboards
 */
+ (id)initialController:(NSString *)storyboard;
+ (id)controllerFrom:(NSString *)storyboard withID:(NSString *)controllerId;

@end
