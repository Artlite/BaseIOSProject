//
//  BaseViewController+Navigations.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 6/7/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

public extension BaseViewController {

	/**
	 Method which provide the navigation by controller name and storyboard

	 - parameter name:       controller name
	 - parameter storyboard: storyboard name
	 - parameter hideBottom: need hide bottom bar
	 */
	public final func show(controller name: String?, storyboard: String?, hideBottom: Bool) {
		if ((name == nil) || (storyboard == nil)) {
			return;
		}

		let controller: UIViewController? = StoryboardHelper.controller(from: storyboard!, withID: name!) as? UIViewController;
		if (controller != nil) {
			controller?.hidesBottomBarWhenPushed = hideBottom;
			self.show(controller!, sender: self);
		}
	}

	/**
	 Method which provide the navigation by controller name and storyboard

	 - parameter name:       controller name
	 - parameter storyboard: storyboard name
	 - parameter hideBottom: need hide bottom bar
	 */
	public final func show(modallyController name: String?, storyboard: String?, completion: (() -> Void)?) {
		if ((name == nil) || (storyboard == nil)) {
			return;
		}

		let controller: UIViewController? = StoryboardHelper.controller(from: storyboard!, withID: name!) as? UIViewController;
		if (controller != nil) {
			self.present(controller!, animated: true, completion: completion);
		}
	}

}
