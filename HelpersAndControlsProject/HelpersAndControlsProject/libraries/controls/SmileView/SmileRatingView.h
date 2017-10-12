//
//  SmileRatingView.h
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/2/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmileRatingView : UIView
@property(nonatomic, strong) NSNumber *rating;
- (void)setInitialRating:(int)rating;
+ (UIImage *) getImageByRating: (int) rating;
+ (NSString *) getTextByRating: (int) rating;
@end
