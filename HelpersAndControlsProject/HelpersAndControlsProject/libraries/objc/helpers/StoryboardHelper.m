//
//  StoryboardManager.m
//  M.A.C.
//
//  Created by Vladimir Yevdokimov on 5/15/15.
//  Copyright (c) 2015 magnet. All rights reserved.
//

#import "StoryboardHelper.h"

@implementation StoryboardHelper

+ (void)initiateStoryboard:(NSString *)storyboard {
  UIViewController *controller = [UIViewController new];

  UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboard bundle:nil];
  if (sb) {
    controller = [sb instantiateInitialViewController];
    UIWindow *win = [UIApplication sharedApplication].windows[0];
    win.rootViewController = controller;
    [win makeKeyAndVisible];
  }
}

+ (id)initialController:(NSString *)storyboard {
  id controller = nil; //[UIViewController new];

  UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboard bundle:nil];
  if (sb) {
    controller = [sb instantiateInitialViewController];
  }
  return controller;
}

+ (id)controllerFrom:(NSString *)storyboard withID:(NSString *)controllerId {
  id controller = nil; //[UIViewController new];

  UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboard bundle:nil];
  if (sb) {
    id new = [ sb instantiateViewControllerWithIdentifier : controllerId ];
    if (new) {
      controller = new;
    }
  }
  return controller;
}

@end
