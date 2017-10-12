//
//  UIImage.swift
//  MoDo
//
//  Created by Dmitry Lernatovich on 8/29/17.
//  Copyright © 2017 Magnet. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /// Method which provide the convert image to the grayscale
    ///
    /// - Returns: instance of the gray scaled {@link UIImage}
    public func getGrayScaleImage() -> UIImage {
        let originalScale = self.scale;
        let originalOrientation = self.imageOrientation;
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        // convert UIImage to CIImage and set as input
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")
        // get output CIImage, render as CGImage first to retain proper UIImage scale
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        let grayImage = UIImage(cgImage: cgImage!);
        return UIImage(cgImage: grayImage.cgImage!, scale: originalScale, orientation: originalOrientation);
    }
    
    /// Method which provide the image resizing
    ///
    /// - Parameter size: instance of the {@link CGSize}
    /// - Returns: instance of the {@link UIImage}
    public func resize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        self.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: size.width, height: size.height)));
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    
    /// Method which provide the return of the rounded {@link UIImage}
    ///
    /// - Returns: instance of the {@link UIImage}
    public func roundImage() -> UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: self.size.height
            ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
}
