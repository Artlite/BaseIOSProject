//
//  BaseTableObject.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/25/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

class BaseTableObject: NSObject {

	/**
	 Object priority enumerator

	 - author: Dmitriy Lernatovich

	 - LOW:  low priority
	 - MID:  mid priority
	 - HIGH: high priority
	 */
	enum ObjectPriority: Int {
		case LOW = 0, MID = 1, HIGH = 2;
	}

	// Object priority
	var priority: ObjectPriority = .MID;

	// Object additional fields
	internal var heigh: CGFloat = -1;
	internal var index: NSIndexPath?;
	internal weak var cell: BaseTableViewCell?;
	var isFirstInit: Bool = false;
	var isSelected: Bool = false;

	// Extras field
	private var extras: [String: AnyObject] = [:];

	override init() {
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
	internal func getCellClass() -> AnyClass! {
		fatalError(String(format: "internal func getCellClass() -> Should be overriden in %@", NSStringFromClass(self.classForCoder)));
		return nil;
	}

	/**
	 Method which provide the getting of the header text

	 - returns: header text
	 */
	internal func getHeaderText() -> String? {
		return "";
	}

	/**
	 Method which provide the getting of the header heigh

	 - returns: header heigh
	 */
	internal func getHeaderHeigh() -> CGFloat {
		return -1;
	}

	/**
	 Method which provide the getting of the header view

	 - returns: current header view
	 */
	internal func getHeaderView(heigh: CGFloat) -> UIView? {
		return nil;
	}

	/**
	 Method which provide the generating transparent view for header

	 - parameter heigh: high for view

	 - returns: generated view
	 */
	final func generate(emptyView heigh: CGFloat) -> UIView {
		let view: UIView = UIView(frame: CGRectMake(0, 0, 6000, heigh));
		view.backgroundColor = UIColor.clearColor();
		return view;
	}

	// MARK: Identifier methods
	/**
	 Method which provide to getting of the reuse identifier
	 */
	internal final func getReuseIdentifier() -> String! {
		let cellClass: AnyClass! = self.getCellClass();
		let identifier: String! = NSStringFromClass(cellClass).componentsSeparatedByString(".").last;
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
	final func addExtra(key: String?, value: AnyObject?) -> Bool {
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
	final func getExtra(key: String?) -> AnyObject? {
		if (key != nil) {
			return self.extras[key!];
		}
		return nil;
	}
}
