//
//  TintedImageView.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/5/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "TintedImageView.h"

IB_DESIGNABLE
@interface TintedImageView ()
@property(nonatomic) IBInspectable BOOL initialTint;
@property(nonatomic) IBInspectable UIColor *imageTintColor;
@end

@implementation TintedImageView

- (void)awakeFromNib {
  if (self.initialTint == YES) {
    if (self.imageTintColor != nil) {
      [self setTintedColor:self.imageTintColor];
    }
  }
}

/**
 *  Method which provide the setting of the image tinting
 *
 *  @param image current image
 *  @param color current image tint color
 */
- (void)setTintedImage:(UIImage *)image color:(UIColor *)color {
  UIImage *originalImage = image;
  UIImage *imageForRendering =
      [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.image = imageForRendering;
  self.tintColor = color;
}

/**
 *  Method which provide the setting of the image by it name with tint color
 *
 *  @param imageName current image name
 *  @param color     current tint color
 */
- (void)setTintedImageName:(NSString *)imageName color:(UIColor *)color {
  UIImage *image = [UIImage imageNamed:imageName];
  if (image) {
    [self setTintedImage:image color:color];
  }
}

/**
 *  Method which provide the settong tint image from the default color
 *
 *  @param image current image
 */
- (void)setTintedImage:(UIImage *)image {
  UIColor *tintColor = self.tintColor;
  [self setTintedImage:image color:tintColor];
}

/**
 *  Method which provide the settong tint image from the default color
 *
 *  @param imageName current image name
 */
- (void)setTintedImageName:(NSString *)imageName {
  UIImage *image = [UIImage imageNamed:imageName];
  if (image) {
    [self setTintedImage:image];
  }
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the setting of the tint for the default image
 *
 *  @param tintedColor current tint color
 */
- (void)setTintedColor:(UIColor *)tintedColor {
  [self setTintedImage:self.image color:tintedColor];
}

@end
