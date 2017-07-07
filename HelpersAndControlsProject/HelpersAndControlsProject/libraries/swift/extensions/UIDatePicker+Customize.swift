//
//  UIDatePicker+Customize.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 7/15/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

extension UIDatePicker {

	/**
	 Method which provide the picker customization

	 - author: Dmitriy Lernatovich

	 - parameter needSelectionLines: need selection
	 - parameter textColor:          text color
	 */
	final func customize(needSelectionLines: Bool, textColor: UIColor?) {
		if (needSelectionLines == false) {
			self.disableSelectionLines();
		}

		if (textColor != nil) {
			self.setColors(color: textColor!);
		}
	}

	/**
	 Method which provide the setting of the text color

	 - author: Dmitriy Lernatovich

	 - parameter color: text color
	 */
	private func setColors(color: UIColor) {
		// text color of today string
		self.performSelector(Selector("setHighlightsToday:"), withObject: color);
		// text color for hoglighted color
		self.performSelector(Selector("_setHighlightColor:"), withObject: color);
		// other text color
		self.setValue(color, forKey: "textColor");
	}

	/**
	 Method which provide the disabling of the selection lines

	 - author: Dmitriy Lernatovich
	 */
	private func disableSelectionLines() {
		// Hide lines
		self.subviews[0].subviews[1].hidden = true;
		self.subviews[0].subviews[2].hidden = true;
	}

}
