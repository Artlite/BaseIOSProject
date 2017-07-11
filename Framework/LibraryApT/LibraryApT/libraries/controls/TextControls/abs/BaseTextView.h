//
//  BaseTextView.h
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/16/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextView : UITextView <UITextViewDelegate>
@property(nonatomic, assign) int textLimitation;
@property(nonatomic, assign) BOOL isNeedNewLineToClose;
@end
