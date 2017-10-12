//
//  InitialTintedImageView.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 11/4/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "InitialTintedImageView.h"

@implementation InitialTintedImageView

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setTintedColor:self.tintColor];
}

@end
