//
//  CTextField.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 02.09.15.
//  Copyright (c) 2015 Magnet. All rights reserved.
//

#import "CTextField.h"

IB_DESIGNABLE
@interface CTextField ()
@property(nonatomic) IBInspectable UIColor *placeholderColor;
@end

@implementation CTextField

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self updatePlaceHolder];
}

- (void)updatePlaceHolder {
  if (self.placeholderColor == nil) {
    self.placeholderColor = [UIColor darkGrayColor];
  }
  NSString *placeholderText = self.placeholder;
  NSAttributedString *attributedText = [[NSAttributedString alloc]
      initWithString:placeholderText
          attributes:@{NSForegroundColorAttributeName : self.placeholderColor}];
  self.attributedPlaceholder = attributedText;
}

@end
