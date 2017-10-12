//
//  AppLogger.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/5/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

/// Class which provide the logining functional
public class AppLogger: NSObject {

    /// {@link String} constants of the marker
	private static let K_MARKER: String! = "=====>";
    /// {@link String} constants of the info tag
	private static let K_ERROR_TAG: String! = "ERROR";
    /// {@link String} constants of the error tag
	private static let K_INFO_TAG: String! = "INFO";
    /// {@link Bool} value if need to show of the info
	private static let isNeedShowing: Bool! = true;

    /**
     Method which provide the error showing
     
     - parameter owner:         owner (should be class or controller)
     - parameter message:       message object
     - parameter additional:    additional description
     */
    public static func error(owner: NSObject?,
                               message: NSString?,
                               additional: String?) {
        showMessage(messageType: K_ERROR_TAG,
                    owner: owner,
                    messageObject: message,
                    additional: additional);
    }
    
	/**
	 Method which provide the error showing

	 - parameter owner:         owner (should be class or controller)
	 - parameter messageObject: message object
	 - parameter additional:    additional description
	 */
	public static func error(owner: NSObject?,
                               messageObject: NSObject?,
                               additional: String?) {
		showMessage(messageType: K_ERROR_TAG,
                    owner: owner,
                    messageObject: messageObject,
                    additional: additional);
	}

    /**
     Method which provide the information showing
     
     - parameter owner:         owner (should be class or controller)
     - parameter message:       message object
     - parameter additional:    additional description
     */
    public static func info(owner: NSObject?,
                              message: NSString?,
                              additional: String?) {
        self.showMessage(messageType: K_INFO_TAG,
                         owner: owner,
                         messageObject: message,
                         additional: additional);
    }
    
	/**
	 Method which provide the information showing

	 - parameter owner:         owner (should be class or controller)
	 - parameter messageObject: message object
	 - parameter additional:    additional description
	 */
	public static func info(owner: NSObject?,
                              messageObject: NSObject?,
                              additional: String?) {
		showMessage(messageType: K_INFO_TAG,
                    owner: owner,
                    messageObject: messageObject,
                    additional: additional);
	}

	/**
	 Method which provide the message showing

	 - parameter messageType:   message type
	 - parameter owner:         owner (should be class or controller)
	 - parameter messageObject: message object
	 - parameter additional:    additional description
	 */
	private static func showMessage(messageType: String!,
                                    owner: NSObject?,
                                    messageObject: NSObject?,
                                    additional: String?) {
		if (isNeedShowing == false) {
			return;
		}
		var message: String! = String.init(format: "%@[%@] ", K_MARKER, messageType);
		if (owner != nil) {
			let className: String? = NSStringFromClass(owner!.classForCoder)
                .components(separatedBy: "").last;
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
