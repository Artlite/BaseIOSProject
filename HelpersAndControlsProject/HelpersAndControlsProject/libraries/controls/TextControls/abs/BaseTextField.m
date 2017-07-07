//
//  BaseTextField.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/16/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "BaseTextField.h"
IB_DESIGNABLE
@interface BaseTextField ()
@property(nonatomic) IBInspectable int textLimitation;
@end

@implementation BaseTextField

- (void)awakeFromNib {
  self.delegate = self;
  if (self.textLimitation <= 0) {
    self.textLimitation =
        [[NSNumber alloc] initWithInteger:NSIntegerMax].intValue;
  }
}

/**
 *  Method which provide the action when user press the return button on
 *keyboard
 *
 *  @param textField current UITextField
 *
 *  @return return boolean value
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return NO;
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  return textField.text.length + (string.length - range.length) <=
         self.textLimitation;
}

@end
