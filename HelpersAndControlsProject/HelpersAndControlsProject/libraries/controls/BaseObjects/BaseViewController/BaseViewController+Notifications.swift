//
//  BaseViewController+Notifications.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/7/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

extension BaseViewController {
	// MARK: Notifications
	/**
	 Method which provide the registration for notification

	 - parameter selector:         selector
	 - parameter notificationType: notification type
	 */
	final func registerNotification(selector selector: Selector, notificationType: String!) {
		NotificationsHelper.registerForNotification(owner: self, selector: selector, notificationType: notificationType);
	}

	/**
	 Method which provide the notification sending

	 - parameter notificationType: notification type
	 */
	final func sendNotification(notification notificationType: String!) {
		NotificationsHelper.sendNotification(notification: notificationType);
	}

	/**
	 Method which provide the removing from notification
	 */
	final func removeFromNotifications() {
		NotificationsHelper.removeFromNotifications(owner: self);
	}

	/**
	 Method which provide the notification registration
	 (should be overriden in child class)
	 */
	func registerForNotifications() {

	}

	/**
	 Method which provide the registering for keyboard notification
	 */
	final func registerForKeyboardNotifications() {
		self.registerNotification(selector: #selector(BaseViewController.willShowKeyboard(_:)), notificationType: UIKeyboardWillShowNotification);
		self.registerNotification(selector: #selector(BaseViewController.onHideKeyboard), notificationType: UIKeyboardWillHideNotification);
	}

	/**
	 Method which provide the will show keyboard notification

	 - parameter notification: notification
	 */
	final func willShowKeyboard(notification: NSNotification) {
		let dictionary: NSDictionary? = notification.userInfo;
		if (dictionary != nil) {
			let keyboardSize: CGSize = dictionary!.objectForKey(UIKeyboardFrameBeginUserInfoKey)!.CGRectValue().size;
			self.onShowKeyboard(keyboardSize: keyboardSize);
		}
	}

	/**
	 Method which provide to show keyboard

	 - parameter size: keyboard size
	 */
	func onShowKeyboard(keyboardSize size: CGSize) {

	}

	/**
	 Method which provide the hide keyboard
	 */
	func onHideKeyboard() {

	}

	/**
	 Method which provide to closing of the keyboard
	 */
	final func closeKeyboard() {
		self.view.endEditing(true);
	}
}
