//
//  BaseTableObject.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/25/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

open class BaseTableObject: NSObject {

	/**
	 Object priority enumerator

	 - author: Dmitriy Lernatovich

	 - LOW:  low priority
	 - MID:  mid priority
	 - HIGH: high priority
	 */
	public enum ObjectPriority: Int {
		case LOW = 0, MID = 1, HIGH = 2;
	}

	// Object priority
	public var priority: ObjectPriority = .MID;

	// Object additional fields
	public var heigh: CGFloat = -1;
	public var index: NSIndexPath?;
	public weak var cell: BaseTableViewCell?;
	public var isFirstInit: Bool = false;
	public var isSelected: Bool = false;

	// Extras field
	private var extras: [String: AnyObject] = [:];

	override public init() {
		super.init();
		self.priority = .MID;
	}

	deinit {
		NSLog("Cell object(deinit): %@", NSStringFromClass(self.classForCoder));
	}

	// MARK: Methods for override
	/**
	 Method which provide the getting of the class for cell

	 - returns: cell class (Should be child from BaseCollectionCell)
	 */
	open func getCellClass() -> AnyClass! {
		fatalError(String(format: "internal func getCellClass() -> Should be overriden in %@", NSStringFromClass(self.classForCoder)));
	}

	/**
	 Method which provide the getting of the header text

	 - returns: header text
	 */
	open func getHeaderText() -> String? {
		return "";
	}

	/**
	 Method which provide the getting of the header heigh

	 - returns: header heigh
	 */
	open func getHeaderHeigh() -> CGFloat {
		return -1;
	}

	/**
	 Method which provide the getting of the header view

	 - returns: current header view
	 */
	open func getHeaderView(heigh: CGFloat) -> UIView? {
		return nil;
	}

	/**
	 Method which provide the generating transparent view for header

	 - parameter heigh: high for view

	 - returns: generated view
	 */
	public final func generate(emptyView heigh: CGFloat) -> UIView {
        let view: UIView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 6000, height: heigh)));
		view.backgroundColor = UIColor.clear;
		return view;
	}

	// MARK: Identifier methods
	/**
	 Method which provide to getting of the reuse identifier
	 */
	public final func getReuseIdentifier() -> String! {
		let cellClass: AnyClass! = self.getCellClass();
		let identifier: String! = NSStringFromClass(cellClass).components(separatedBy: ".").last;
		return identifier;
	}

	// MARK:Extras functional

	/**
	 Method which provide the adding of extra to the cell
	 (Use for independent object)

	 - author: Dmitriy Lernatovich

	 - parameter key:   kay
	 - parameter value: value

	 - returns: is added
	 */
	public final func addExtra(key: String?, value: AnyObject?) -> Bool {
		if ((key != nil) && (value != nil)) {
			self.extras[key!] = value!;
			return true;
		}
		return false;
	}

	/**
	 Method which provide the extras getting

	 - author: Dmitriy Lernatovich

	 - parameter key: key for extras

	 - returns: object for key
	 */
	public final func getExtra(key: String?) -> AnyObject? {
		if (key != nil) {
			return self.extras[key!];
		}
		return nil;
	}
}
