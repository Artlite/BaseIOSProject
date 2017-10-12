//
//  CTextFieldValidator.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 8/10/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

public class CTextFieldValidator: TextFieldValidator {

	/// Custom text field delegate
	class CTextFieldValidatorDelegate: NSObject, UITextFieldDelegate {
		/**
		 Method which provide the managing action when user press return button
		 (USE FOR HIDE AUTOMATIC HIDING OF THE KEYBOARD)

		 - author: Dmitriy Lernatovich

		 - parameter textField: text field

		 - returns: result
		 */
		func textFieldShouldReturn(_ textField: UITextField) -> Bool {
			if let cTextField = textField as? CTextFieldValidator {
				if (cTextField.needHideKeyboard == true) {
					textField.resignFirstResponder();
					return false;
				}
			}
			return true;
		}

		/**
		 Method which provide the text charakter in range
		 (USE FOR TEXT LIMITATION)

		 - author: Dmitriy Lernatovich

		 - parameter textField: text fild
		 - parameter range:     range
		 - parameter string:    text

		 - returns: result
		 */
		func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
			if let cTextField = textField as? CTextFieldValidator {
				if let textFromEdit = textField.text {
					return textFromEdit.length + (string.length - range.length) <=
						cTextField.textLimitation;
				}
			}
			return true;
		}
	}

	@IBInspectable var textLimitation: Int = Int(INT32_MAX);

	/**
	 Constructor which provide the create object with frame

	 - author: Dmitriy Lernatovich

	 - parameter frame: frame

	 - returns: object
	 */
	override init(frame: CGRect) {
		super.init(frame: frame);
		self.onCreate();
	}

	/**
	 Constructor which provide to create object with coder

	 - author: Dmitriy Lernatovich

	 - parameter aDecoder: coder

	 - returns: object
	 */
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
		self.onCreate();
	}

	/**
	 Method which provid the on create functional

	 - author: Dmitriy Lernatovich
	 */
	private func onCreate() {
		super.delegate = CTextFieldValidatorDelegate();
	}
}
