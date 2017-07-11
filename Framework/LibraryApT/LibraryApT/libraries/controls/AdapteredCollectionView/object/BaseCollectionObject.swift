//
//  BaseCollectionObject.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/13/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

//MARK: Object
open class BaseCollectionObject: NSObject {

	internal var heigh: CGFloat = -1;
	internal var index: NSIndexPath?;
	internal weak var cell: BaseCollectionCell?;

	var isFirstInit: Bool = false;

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

	// MARK: Identifier methods
	/**
	 Method which provide to getting of the reuse identifier
	 */
	internal final func getReuseIdentifier() -> String! {
		let cellClass: AnyClass! = self.getCellClass();
		let identifier: String! = NSStringFromClass(cellClass).components(separatedBy: (".")).last;
		return identifier;
	}

}
