//
//  ColorHelper.swift
//  EsteeHR
//
//  Created by Vladimir Yevdokimov on 5/10/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

class ColorHelper: NSObject {
    
	/// Method which provide the create of the {@link UIColor} from the rgb
	///
	/// - Parameters:
	///   - r: red code
	///   - g: green code
	///   - b: blue code
	/// - Returns: instance of the {@link UIColor}
	class func rgb(r: Float, g: Float, b: Float) -> UIColor {
		return UIColor.init(colorLiteralRed: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
	}

	/// Method which provide the create of the {@link UIColor} from the hex
	///
	/// - Parameter rgbValue: rgb code
	/// - Returns: instance of the {@link UIColor}
	class func rgb_hex(rgbValue: Int) -> UIColor {
		return UIColor.init(colorLiteralRed: ((Float)((rgbValue & 0xFF0000) >> 16)) / 255.0,
			green: ((Float)((rgbValue & 0x00FF00) >> 8)) / 255.0,
			blue: ((Float)((rgbValue & 0x0000FF) >> 0)) / 255.0,
			alpha: 1.0)
	}
}
