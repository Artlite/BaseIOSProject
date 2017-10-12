//
//  AdapteredTableView+Navigations.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/31/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

public extension AdapteredTableView {

	/**
	 Method which provide the scrolling to bottom

	 - parameter animated: animated
	 */
	public func scroll(toBottom animated: Bool) {
		if (animated == true) {
			Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(scrollToBottomAnimated), userInfo: nil, repeats: false);
		} else {
			Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(scrollToBottomNonAnimated), userInfo: nil, repeats: false);
		}
	}

	/**
	 Method which provide the crolling to index

	 - parameter index: index
	 */
	public func scroll(toIndex index: NSIndexPath, animated: Bool) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            self.tableView.scrollToRow(at: index as IndexPath, at: .bottom, animated: animated);
        }
	}

	/**
	 Method which provide the scrolling to object

	 - parameter object: object
	 */
	public func scroll(toObject object: BaseTableObject?, animated: Bool) {
		if ((object == nil) || (object?.index == nil)) {
			return;
		}
		self.scroll(toIndex: object!.index!, animated: animated);
	}

	/**
	 Method which provide the navigation to bottom with animation
	 */
	public func scrollToBottomAnimated() {
		self.navigateToBottom(animated: true);
	}

	/**
	 Method which provide the navigation to bottom without animation
	 */
	public func scrollToBottomNonAnimated() {
		self.navigateToBottom(animated: false);
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
