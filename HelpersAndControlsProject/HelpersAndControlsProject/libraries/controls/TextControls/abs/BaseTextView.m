//
//  BaseTextView.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/16/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "BaseTextView.h"
#import "UITextView+Placeholder.h"

static const NSInteger K_DEFAULT_LIMITATION = NSIntegerMax;

@implementation BaseTextView

- (void)awakeFromNib {
  self.delegate = self;
  if (self.textLimitation <= 0) {
    self.textLimitation = @(K_DEFAULT_LIMITATION).intValue;
  }
  self.dataDetectorTypes = UIDataDetectorTypeLink;
}

- (BOOL)textView:(UITextView *)textView
    shouldChangeTextInRange:(NSRange)range
            replacementText:(NSString *)text {
  if (([text isEqualToString:@"\n"]) && (self.isNeedNewLineToClose == YES)) {
    [textView resignFirstResponder];
    return NO; // or true, whetever you's like
  }
  BOOL results = textView.text.length + (text.length - range.length) <=
                 self.textLimitation;

  return results;
}

@end
