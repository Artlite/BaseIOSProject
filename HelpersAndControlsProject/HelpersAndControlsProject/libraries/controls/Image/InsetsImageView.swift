//
//  InsetsImageView.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/19/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

class InsetsImageView: UIImageView {
    
    @IBInspectable var insetTop:CGFloat = 0 {
        didSet{
            self.setImageInsets();
        }
    }
    
    @IBInspectable var insetLeft:CGFloat = 0 {
        didSet{
            self.setImageInsets();
        }
    }
    
    @IBInspectable var insetBottom:CGFloat = 0 {
        didSet{
            self.setImageInsets();
        }
    }
    
    @IBInspectable var insetRight:CGFloat = 0 {
        didSet{
            self.setImageInsets();
        }
    }
    
    @IBInspectable var tintImageColor:UIColor = UIColor.clearColor() {
        didSet{
            self.setImageInsets();
        }
    }
    
    final func setImageInsets(){
        let originalImage:UIImage? = self.image;
        let tintedImage:UIImage? = originalImage?.imageWithRenderingMode(.AlwaysTemplate);
        let resizedImage:UIImage? = tintedImage?.resizableImageWithCapInsets(UIEdgeInsetsMake(self.insetTop, self.insetLeft, self.insetBottom, self.insetRight));
        self.image = resizedImage;
        self.tintColor = tintImageColor;
    }
    
//    /**
//     *  Method which provide the setting of the image tinting
//     *
//     *  @param image current image
//     *  @param color current image tint color
//     */
//    - (void)setTintedImage:(UIImage *)image color:(UIColor *)color {
//    UIImage *originalImage = image;
//    UIImage *imageForRendering =
//    [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    self.image = imageForRendering;
//    self.tintColor = color;
//    }

}
