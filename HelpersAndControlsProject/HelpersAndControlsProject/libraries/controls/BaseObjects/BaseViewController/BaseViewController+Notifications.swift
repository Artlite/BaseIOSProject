//
//  BaseViewController+Notifications.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/7/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

public extension BaseViewController {
	// MARK: Notifications
	/**
	 Method which provide the registration for notification

	 - parameter selector:         selector
	 - parameter notificationType: notification type
	 */
	public final func registerNotification(selector: Selector, notificationType: Notification.Name!) {
		NotificationsHelper.registerForNotification(owner: self, selector: selector, notificationType: notificationType);
	}

	/**
	 Method which provide the notification sending

	 - parameter notificationType: notification type
	 */
	public final func sendNotification(notification notificationType: Notification.Name!) {
		NotificationsHelper.sendNotification(notification: notificationType);
	}

	/**
	 Method which provide the removing from notification
	 */
	public final func removeFromNotifications() {
		NotificationsHelper.removeFromNotifications(owner: self);
	}

	/**
	 Method which provide the notification registration
	 (should be overriden in child class)
	 */
	open func registerForNotifications() {

	}

	/**
	 Method which provide the registering for keyboard notification
	 */
	public final func registerForKeyboardNotifications() {
		self.registerNotification(selector: #selector(BaseViewController.willShowKeyboard(notification:)), notificationType: NSNotification.Name.UIKeyboardWillShow);
		self.registerNotification(selector: #selector(BaseViewController.onHideKeyboard), notificationType: NSNotification.Name.UIKeyboardWillHide);
	}

	/**
	 Method which provide the will show keyboard notification

	 - parameter notification: notification
	 */
	public final func willShowKeyboard(notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let nsValue = dict.object(forKey: UIKeyboardFrameBeginUserInfoKey) as? NSValue {
                let keyboardSize: CGSize = nsValue.cgRectValue.size;
                self.onShowKeyboard(keyboardSize: keyboardSize);
            }
        }
	}

	/**
	 Method which provide to show keyboard

	 - parameter size: keyboard size
	 */
	open func onShowKeyboard(keyboardSize size: CGSize) {

	}

	/**
	 Method which provide the hide keyboard
	 */
	open func onHideKeyboard() {

	}

	/**
	 Method which provide to closing of the keyboard
	 */
	public final func closeKeyboard() {
		self.view.endEditing(true);
	}
}
