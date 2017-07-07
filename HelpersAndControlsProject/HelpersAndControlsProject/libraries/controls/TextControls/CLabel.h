//
//  CLabel.h
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 9/23/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLabel : UILabel

- (void)setText:(NSString *)text isNeedJustify:(BOOL)isNeedJustify;

- (void)setText:(NSString *)text
      textColor:(UIColor *)textColor
  isNeedJustify:(BOOL)isNeedJustify;

- (void)cutStringValue:(int)length;
@end
