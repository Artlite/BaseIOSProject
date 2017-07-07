//
//  BaseViewController+Navigations.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 6/7/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

extension BaseViewController {

	/**
	 Method which provide the navigation by controller name and storyboard

	 - parameter name:       controller name
	 - parameter storyboard: storyboard name
	 - parameter hideBottom: need hide bottom bar
	 */
	final func show(controller name: String?, storyboard: String?, hideBottom: Bool) {
		if ((name == nil) || (storyboard == nil)) {
			return;
		}

		let controller: UIViewController? = StoryboardHelper.controllerFrom(storyboard!, withID: name!) as? UIViewController;
		if (controller != nil) {
			controller?.hidesBottomBarWhenPushed = hideBottom;
			self.showViewController(controller!, sender: self);
		}
	}

	/**
	 Method which provide the navigation by controller name and storyboard

	 - parameter name:       controller name
	 - parameter storyboard: storyboard name
	 - parameter hideBottom: need hide bottom bar
	 */
	final func show(modallyController name: String?, storyboard: String?, completion: (() -> Void)?) {
		if ((name == nil) || (storyboard == nil)) {
			return;
		}

		let controller: UIViewController? = StoryboardHelper.controllerFrom(storyboard!, withID: name!) as? UIViewController;
		if (controller != nil) {
			self.presentViewController(controller!, animated: true, completion: completion);
		}
	}

}
