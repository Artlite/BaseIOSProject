//
//  MessageComposer.swift
//  Result sent to phone
//
//  Created by Dmitry Lernatovich on 26.06.16.
//  Copyright © 2016 Ji Qi. All rights reserved.
//

import Foundation
import MessageUI

public class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {

	// A wrapper function to indicate whether or not a text message can be sent from the user's device
	func canSendText() -> Bool {
		return MFMessageComposeViewController.canSendText()
	}

	// Configures and returns a MFMessageComposeViewController instance
	func create(messageController body: String?) -> MFMessageComposeViewController {
		let controller = MFMessageComposeViewController();
		controller.messageComposeDelegate = self;
		controller.body = body;
		return controller;
	}

	// MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
	public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
		controller.dismiss(animated: true, completion: nil)
	}
}
