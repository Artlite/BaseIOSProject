//
//  RoundView.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/15/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

class RoundView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.layer.cornerRadius = self.frame.size.width / 2.0;
        self.clipsToBounds = true;
    }
    
}
