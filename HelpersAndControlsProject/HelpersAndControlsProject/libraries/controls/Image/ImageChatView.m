//
//  ImageChatView.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 11/12/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "ImageChatView.h"

@implementation ImageChatView

- (void)awakeFromNib {
  UIEdgeInsets edgeInsets = UIEdgeInsetsMake(30, 40, 30, 40);

  UIImage *backgroundButtonImage =
      [self.image resizableImageWithCapInsets:edgeInsets
                                 resizingMode:UIImageResizingModeStretch];
  self.image = backgroundButtonImage;
}

@end
