//
//  AdapteredCollectionDelegate+BackgroundText.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 5/5/16.
//  Copyright © 2016 Magnet. All rights reserved.
//
import UIKit
extension AdapteredCollectionView {

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
