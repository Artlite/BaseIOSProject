//
//  AdapteredCollectionDelegate+BackgroundText.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 5/5/16.
//  Copyright © 2016 Magnet. All rights reserved.
//
import UIKit

// MARK: - Extension which provide the Text functional for Adaptered Collection View
public extension AdapteredCollectionView {
    
    /**
     Method which provide the setting of the background text
     
     - parameter text: text
     */
    public func setBackgroundText(text: String?) {
        DispatchQueue.main.async(execute: {
            self.labelBackgroundText.text = text;
        });
    }
    
    /**
     Method which provide the crearing of the background text
     */
    public func clearBackgroundText() {
        self.setBackgroundText(text: "");
    }
}
