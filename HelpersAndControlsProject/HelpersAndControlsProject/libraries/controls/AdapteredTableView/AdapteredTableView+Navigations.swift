//
//  AdapteredTableView+Navigations.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/31/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

extension AdapteredTableView {

	/**
	 Method which provide the scrolling to bottom

	 - parameter animated: animated
	 */
	internal func scroll(toBottom animated: Bool) {
		if (animated == true) {
			NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(scrollToBottomAnimated), userInfo: nil, repeats: false);
		} else {
			NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(scrollToBottomNonAnimated), userInfo: nil, repeats: false);
		}
	}

	/**
	 Method which provide the crolling to index

	 - parameter index: index
	 */
	internal func scroll(toIndex index: NSIndexPath, animated: Bool) {
		let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
		dispatch_after(delayTime, dispatch_get_main_queue(), {
			self.tableView.scrollToRowAtIndexPath(index, atScrollPosition: .Bottom, animated: animated);
		});
	}

	/**
	 Method which provide the scrolling to object

	 - parameter object: object
	 */
	internal func scroll(toObject object: BaseTableObject?, animated: Bool) {
		if ((object == nil) || (object?.index == nil)) {
			return;
		}
		self.scroll(toIndex: object!.index!, animated: animated);
	}

	/**
	 Method which provide the navigation to bottom with animation
	 */
	func scrollToBottomAnimated() {
		self.navigateToBottom(true);
	}

	/**
	 Method which provide the navigation to bottom without animation
	 */
	func scrollToBottomNonAnimated() {
		self.navigateToBottom(false);
	}

	/**
	 Method which provide the navigation to bottom

	 - parameter animated: is need animation
	 */
	private func navigateToBottom(animated: Bool) {
		if let object: BaseTableObject = self.objects.lastObject as? BaseTableObject {
			self.scroll(toObject: object, animated: animated);
		}
	}

}
