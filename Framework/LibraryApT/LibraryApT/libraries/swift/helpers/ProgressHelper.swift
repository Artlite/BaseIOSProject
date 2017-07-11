//
//  ProgressHelper.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/6/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

public class ProgressHelper: NSObject {

	/**
	 Method which provide the show progress with message

	 - parameter message: message
	 */
	public static func showProgress(message: String!) {
		self.showProgress(message: message, style: SVProgressHUDStyle.dark);
	}

	/**
	 Method which provide the show progress with message

	 - parameter message: message
	 - parameter style:   progress style
	 */
	public static func showProgress(message: String!, style: SVProgressHUDStyle!) {
		DispatchQueue.main.async(execute: {
			self.setUpProgressHUD(style: style);
			SVProgressHUD.show(withStatus: message);
		});
	}

	/**
	 Method which provide the showing information with status

	 - parameter message: message
	 */
	public static func showInformation(message: String!) {
		self.showInformation(message: message, style: SVProgressHUDStyle.dark);
	}

	/**
	 Method which provide the showing information with status

	 - parameter message: message
	 - parameter style:   style
	 */
	public static func showInformation(message: String!, style: SVProgressHUDStyle!) {
		DispatchQueue.main.async(execute: {
			self.setUpProgressHUD(style: style);
			SVProgressHUD.showInfo(withStatus: message);
		});
	}

	/**
	 Method which provide the showing error with message

	 - parameter message: message
	 */
	public static func showError(message: String!) {
		self.showError(message: message, style: SVProgressHUDStyle.dark);
	}

	/**
	 Method which provide the showing error with message

	 - parameter message: message
	 - parameter style:   style
	 */
	public static func showError(message: String!, style: SVProgressHUDStyle!) {
		DispatchQueue.main.async(execute: {
			self.setUpProgressHUD(style: style);
			SVProgressHUD.showError(withStatus: message);
		});
	}

	/**
	 Message with provide the showing success with message

	 - parameter message: message
	 */
	public static func showSuccess(message: String!) {
		self.showSuccess(message: message, style: SVProgressHUDStyle.dark);
	}

	/**
	 Message with provide the showing success with message

	 - parameter message: message
	 - parameter style:   style
	 */
	public static func showSuccess(message: String!, style: SVProgressHUDStyle!) {
		DispatchQueue.main.async(execute: {
			self.setUpProgressHUD(style: style);
			SVProgressHUD.showSuccess(withStatus: message);
		});
	}

	/**
	 Method which provide the progress hiding
	 */
	public static func hideProgress() {
		DispatchQueue.main.async(execute: {
			SVProgressHUD.dismiss();
		});
	}

	/**
	 Method which provide the setting up of the progress HUD

	 - parameter style: progress style
	 */
	public static func setUpProgressHUD(style: SVProgressHUDStyle!) {
		SVProgressHUD.setMinimumDismissTimeInterval(0.5);
		SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear);
		SVProgressHUD.setDefaultStyle(style);
	}

}
