//
//  BaseView.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/5/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit
/// Base view protocol
@objc protocol BaseViewDelegate: class {
	/**
	 Method which provide the getting of the current controller

	 - author: Dmitriy Lernatovich

	 - returns: current view controller
	 */
	optional func getCurrentController() -> UIViewController?;
}

class BaseView: UIView {

	/// Delegate
	var delegate: BaseViewDelegate? {
		didSet {
			self.onDelegateSetted();
		}
	};

	/**
	 Constructor which provide the initialization from frame

	 - parameter frame: frame
	 */
	override init(frame: CGRect) {
		super.init(frame: frame);
		self.onViewInitialize();
		self.onCreateView();
	}

	/**
	 Constructor which provide the initialization from coder

	 - parameter aDecoder: coder
	 */
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
		self.onViewInitialize();
		self.onCreateView();
	}

	/**
	 Method which provide the view initializations
	 */
	private final func onViewInitialize() {
		let view: UIView! = NSBundle.mainBundle().loadNibNamed(ClassHelper.get(classNameFromClass: self.classForCoder),
			owner: self,
			options: nil)![0] as! UIView;
		view.frame = self.bounds;
		self.addSubview(view);
	}

	/**
	 Method which provide the actions when View is created
	 */
	func onCreateView() {
		fatalError(String.init(format: "func onCreateView() -> Should be overriden in %@ class", self));
	}

	/**
	 Method which provide the action when controller created
	 */
	func onCreateController() {
	}

	/**
	 Method which provide the action when controller destroyed
	 */
	func onDestroyController() {
	}

	/**
	 Method which provide the action when controller resumed
	 */
	func onResumeController() {
	}

	/**
	 Method which provide the action when controller paused
	 */
	func onPauseController() {
	}

	/**
	 Method which provide the notification when delegate setted

	 - author: Dmitriy Lernatovich
	 */
	func onDelegateSetted() {

	}

}
