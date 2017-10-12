//
//  AdapteredCollectionView+Navigations.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/18/16.
//  Copyright © 2016 Magnet. All rights reserved.
//
import UIKit

// MARK: - Extension which provide the Navigation functional for Adaptered Collection View
public extension AdapteredCollectionView {

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
        ThreadHelper.runOnMain(afterDelay: 0.1) { 
            self.collectionView.scrollToItem(at: index as IndexPath, at: .bottom, animated: animated);
        }
	}

	/**
	 Method which provide the scrolling to object

	 - parameter object: object
	 */
	public func scroll(toObject object: BaseCollectionObject?, animated: Bool) {
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
		let section: NSInteger = self.collectionView.numberOfSections - 1;
		let item: NSInteger = self.collectionView.numberOfItems(inSection: section) - 1;
		if (item < 0) {
			return;
		}
        let indexPath: NSIndexPath = NSIndexPath(item: item, section: section);
		self.collectionView.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: animated);
	}

}
