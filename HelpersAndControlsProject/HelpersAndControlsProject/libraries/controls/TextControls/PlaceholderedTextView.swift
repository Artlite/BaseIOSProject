//
//  PlaceholderedTextView.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/25/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

public class PlaceholderedTextView: BaseTextView {

	@IBInspectable var hintColor: UIColor = UIColor.lightGray {
		didSet {
			self.placeholderColor = self.hintColor;
		}
	}

	@IBInspectable var hintText: String = "Enter text here" {
		didSet {
			self.placeholder = hintText;
		}
	}

	@IBInspectable var characterLimit: Int = Int.max {
		didSet {
			super.textLimitation = Int32(self.characterLimit);
		}
	}

	@IBInspectable var newLineKeyboardHiding: Bool = true {
		didSet {
			super.isNeedNewLineToClose = self.newLineKeyboardHiding;
		}
	}

	@IBInspectable var swipeDownKeyboard: Bool = true {
		didSet {
			if (self.swipeDownKeyboard == true) {
				self.addSwipeDownClose();
			}
		}
	}

	private var swipe: UISwipeGestureRecognizer?;

	override func awakeFromNib() {
		super.awakeFromNib();
		super.isNeedNewLineToClose = self.newLineKeyboardHiding;
		if (self.swipeDownKeyboard == true) {
			self.addSwipeDownClose();
		}
	}

	private func addSwipeDownClose() {
		if (self.swipe == nil) {
			self.swipe = GetsureHelper.addSwipe(target: self, view: self, direction: .down, selector: #selector(PlaceholderedTextView.closeKeyboard));
		}
	}

	/**
	 Method which provide the keyboard closing
	 */
	public final func closeKeyboard() {
		self.endEditing(true);
	}

}
