//
//  DialogHelper.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 5/17/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

public class DialogHelper: NSObject {

	/**
	 Method which provide the dialog creating

	 - returns: dialog
	 */
	public static func create(dialogWithTitle title: String?, message: String?, style: UIAlertControllerStyle, actions: [UIAlertAction]? = nil) -> UIAlertController {
		let alert = UIAlertController(title: title, message: message, preferredStyle: style);

		if (actions != nil) {
			for action in actions! {
				alert.addAction(action);
			}
		} else {
			alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil));
		}
		return alert;
	}

	/**
	 Method which provide the creating input dialog

	 - author: Dmitriy Lernatovich

	 - parameter title:   title
	 - parameter edit:    edit field
	 - parameter style:   style
	 - parameter actions: actions

	 - returns: dialog
	 */
	private static func create(dialog title: String?, message: String?, editTextHandler: ((UITextField) -> Void)?, style: UIAlertControllerStyle, actions: [UIAlertAction]? = nil) -> UIAlertController {
		let alert = UIAlertController(title: title, message: message, preferredStyle: style);
		alert.addTextField(configurationHandler: editTextHandler);
		if (actions != nil) {
			for action in actions! {
				alert.addAction(action);
			}
		} else {
			alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil));
		}
		return alert;
	}

	/**
	 Method which provid the create dialog with input field

	 - author: Dmitriy Lernatovich

	 - parameter title:      title
	 - parameter message:    message
	 - parameter okText:     ok text
	 - parameter cancelText: cancel text
	 - parameter style:      style
	 - parameter controller: controller
	 - parameter callback:   callback
	 */
	public static func create(dialogWithInput title: String?, message: String?, okText: String?, cancelText: String?, style: UIAlertControllerStyle, capitalizationType: UITextAutocapitalizationType = UITextAutocapitalizationType.sentences, actions: [UIAlertAction]? = nil, callback: ((_ text: String?) -> Void)?) -> UIAlertController {
		var inputText: UITextField?;
		let dialog = self.create(dialog: title, message: message, editTextHandler: { (edit) in
			edit.font = UIFont.systemFont(ofSize: 17);
			edit.autocapitalizationType = capitalizationType;
			inputText = edit;
			}, style: style, actions: [
			UIAlertAction(title: okText, style: UIAlertActionStyle.default, handler: { (alert) in
				callback?(inputText?.text);
			})
		]);

		// Add additional actions
		if (actions != nil) {
			for action in actions! {
				dialog.addAction(action);
			}
		}
		// Add cancel action
		dialog.addAction(UIAlertAction(title: cancelText, style: UIAlertActionStyle.cancel, handler: nil));
		return dialog;
	}

	/**
	 Method which provide the dialog showing

	 - author: Dmitriy Lernatovich

	 - parameter title:           title
	 - parameter message:         message
	 - parameter editTextHandler: edit handler
	 - parameter style:           style
	 - parameter controller:      controller to show
	 - parameter actions:         actions
	 */
	private static func show(dialog title: String?, message: String?, editTextHandler: ((UITextField) -> Void)?, style: UIAlertControllerStyle, controller: UIViewController?, actions: [UIAlertAction]? = nil) {
		let alert = self.create(dialog: title, message: message, editTextHandler: editTextHandler, style: style, actions: actions);
		controller?.present(alert, animated: true, completion: nil);
	}

	/**
	 Method which provid the showing dialog with input field

	 - author: Dmitriy Lernatovich

	 - parameter title:      title
	 - parameter message:    message
	 - parameter okText:     ok text
	 - parameter cancelText: cancel text
	 - parameter style:      style
	 - parameter controller: controller
	 - parameter callback:   callback
	 */
	public static func show(dialogWithInput title: String?, message: String?, okText: String?, cancelText: String?, controller: UIViewController?, capitalizationType: UITextAutocapitalizationType = UITextAutocapitalizationType.sentences, actions: [UIAlertAction]? = nil, callback: ((_ text: String?) -> Void)?) {
		let dialog = self.create(dialogWithInput: title, message: message, okText: okText, cancelText: cancelText, style: .alert, capitalizationType: capitalizationType, actions: actions, callback: callback);
		controller?.present(dialog, animated: true, completion: nil);
	}

	/**
	 Method which provide the dialog showing

	 - parameter title:   title
	 - parameter message: message
	 - parameter style:   style
	 - parameter actions: actions
	 */
	public static func show(dialogWithTitle title: String?, message: String?, style: UIAlertControllerStyle, actions: [UIAlertAction]?, controller: UIViewController?) {
		let alert = self.create(dialogWithTitle: title, message: message, style: style, actions: actions);
		controller?.present(alert, animated: true, completion: nil);
	}

}
