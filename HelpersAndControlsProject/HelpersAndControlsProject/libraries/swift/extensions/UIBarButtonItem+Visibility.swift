//
//  UIBarButtonItem+Visibility.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 01.05.16.
//  Copyright © 2016 Magnet. All rights reserved.
//

extension UIBarButtonItem {
    
    /**
     Method which provide the hiding of the view
     */
    internal func hide(){
        self.customView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0)));
    }
    
    
}
