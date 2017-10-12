//
//  CLabel.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 9/23/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "CLabel.h"

@implementation CLabel

- (void)setText:(NSString *)text isNeedJustify:(BOOL)isNeedJustify {
  if (isNeedJustify) {
    self.numberOfLines = 0;
    NSMutableParagraphStyle *paragraphStyle =
        [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{
      NSFontAttributeName : self.font,
      NSBaselineOffsetAttributeName : @0,
      NSParagraphStyleAttributeName : paragraphStyle
    };
    NSAttributedString *attributedText =
        [[NSAttributedString alloc] initWithString:text attributes:attributes];
    self.attributedText = attributedText;
  } else {
    [super setText:text];
  }
}

- (void)setText:(NSString *)text
      textColor:(UIColor *)textColor
  isNeedJustify:(BOOL)isNeedJustify {
  if (isNeedJustify) {
    self.numberOfLines = 0;
    NSMutableParagraphStyle *paragraphStyle =
        [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{
      NSFontAttributeName : self.font,
      NSBaselineOffsetAttributeName : @0,
      NSParagraphStyleAttributeName : paragraphStyle,
      NSForegroundColorAttributeName : textColor
    };
    NSAttributedString *attributedText =
        [[NSAttributedString alloc] initWithString:text attributes:attributes];
    self.attributedText = attributedText;
  } else {
    [super setText:text];
    self.textColor = textColor;
  }
}

/**
 * Method which provide the cut of the string value
 */
- (void)cutStringValue:(int)length {
  NSString *textValue = self.text;
  if (textValue.length > length) {
    // define the range you're interested in
    NSRange stringRange = {0, MIN([textValue length], length)};
    // adjust the range to include dependent chars
    stringRange =
        [textValue rangeOfComposedCharacterSequencesForRange:stringRange];
    // Now you can create the short string
    NSString *shortString = [NSString
        stringWithFormat:@"%@...", [textValue substringWithRange:stringRange]];
    // Set cutted NSString
    self.text = shortString;
  }
}

@end
