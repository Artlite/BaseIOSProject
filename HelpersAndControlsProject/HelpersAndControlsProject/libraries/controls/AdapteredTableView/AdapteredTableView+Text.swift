//
//  AdapteredTableView+Text.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/31/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

extension AdapteredTableView {
	/**
	 Method which provide the setting of the background text

	 - parameter text: text
	 */
	func setBackgroundText(text: String?) {
		DispatchQueue.main.async(execute: {
			self.labelBackgroundText.text = text;
		});
	}

	/**
	 Method which provide the crearing of the background text
	 */
	func clearBackgroundText() {
		self.setBackgroundText(text: "");
	}
}
