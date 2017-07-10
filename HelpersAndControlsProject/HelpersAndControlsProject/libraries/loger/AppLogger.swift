//
//  AppLogger.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/5/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

class AppLogger: NSObject {

	private static let K_MARKER: String! = "=====>";
	private static let K_ERROR_TAG: String! = "ERROR";
	private static let K_INFO_TAG: String! = "INFO";
	private static let isNeedShowing: Bool! = true;

	/**
	 Method which provide the error showing

	 - parameter owner:         owner (should be class or controller)
	 - parameter messageObject: message object
	 - parameter additional:    additional description
	 */
	internal static func error(owner: NSObject?, messageObject: NSObject?, additional: String?) {
		showMessage(messageType: K_ERROR_TAG, owner: owner, messageObject: messageObject, additional: additional);
	}

	/**
	 Method which provide the information showing

	 - parameter owner:         owner (should be class or controller)
	 - parameter messageObject: message object
	 - parameter additional:    additional description
	 */
	internal static func info(owner: NSObject?, messageObject: NSObject?, additional: String?) {
		showMessage(messageType: K_INFO_TAG, owner: owner, messageObject: messageObject, additional: additional);
	}

	/**
	 Method which provide the message showing

	 - parameter messageType:   message type
	 - parameter owner:         owner (should be class or controller)
	 - parameter messageObject: message object
	 - parameter additional:    additional description
	 */
	private static func showMessage(messageType: String!, owner: NSObject?, messageObject: NSObject?, additional: String?) {

		if (isNeedShowing == false) {
			return;
		}

		var message: String! = String.init(format: "%@[%@] ", K_MARKER, messageType);
		if (owner != nil) {
			let className: String? = NSStringFromClass(owner!.classForCoder).components(separatedBy: "").last;
			if (className != nil) {
				message.append(String.init(format: "[%@]", className!));
			}
		}
		if (additional != nil) {
			message.append(String.init(format: ":[%@]", additional!));
		}

		if (messageObject != nil) {
			message.append(String.init(format: " %@", messageObject!));
		}

		NSLog("%@", message);

	}

}
