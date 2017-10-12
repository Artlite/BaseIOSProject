//
//  BaseView.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/5/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit
/// Base view protocol
@objc public protocol BaseViewDelegate: class {
	/**
	 Method which provide the getting of the current controller

	 - author: Dmitriy Lernatovich

	 - returns: current view controller
	 */
	@objc optional func getCurrentController() -> UIViewController?;
}

public class BaseView: UIView {

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
        let className = ClassHelper.get(classNameFromClass: self.classForCoder);
		let view: UIView! = Bundle.main.loadNibNamed(className,
			owner: self,
			options: nil)![0] as! UIView;
		view.frame = self.bounds;
		self.addSubview(view);
	}

	/**
	 Method which provide the actions when View is created
	 */
	open func onCreateView() {
		fatalError(String.init(format: "func onCreateView() -> Should be overriden in %@ class", self));
	}

	/**
	 Method which provide the action when controller created
	 */
	open func onCreateController() {
	}

	/**
	 Method which provide the action when controller destroyed
	 */
	open func onDestroyController() {
	}

	/**
	 Method which provide the action when controller resumed
	 */
	open func onResumeController() {
	}

	/**
	 Method which provide the action when controller paused
	 */
	open func onPauseController() {
	}

	/**
	 Method which provide the notification when delegate setted

	 - author: Dmitriy Lernatovich
	 */
	open func onDelegateSetted() {

	}

}
