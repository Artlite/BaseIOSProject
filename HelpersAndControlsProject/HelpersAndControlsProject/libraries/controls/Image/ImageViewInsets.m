//
//  ImageViewInsets.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 9/8/15.
//  Copyright (c) 2015 Magnet. All rights reserved.
//

#import "ImageViewInsets.h"

@implementation ImageViewInsets

- (void)awakeFromNib {
  [self.image resizableImageWithCapInsets:UIEdgeInsetsMake(
                                              (self.frame.size.height / 2 - 5),
                                              (self.frame.size.width / 2 - 5),
                                              (self.frame.size.height / 2 - 5),
                                              (self.frame.size.width / 2 - 5))
                             resizingMode:UIImageResizingModeTile];
}

@end
