//
//  TintedImageView.h
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/5/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TintedImageView : UIImageView

- (void)setTintedImage:(UIImage *)image color:(UIColor *)color;

- (void)setTintedImageName:(NSString *)imageName color:(UIColor *)color;

- (void)setTintedImage:(UIImage *)image;

- (void)setTintedImageName:(NSString *)imageName;

- (void)setTintedColor:(UIColor *)tintedColor;

@end
