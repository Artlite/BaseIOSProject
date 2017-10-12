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

    /// {@link CGFloat} value of the height
	public var heigh: CGFloat = -1;
    /// Instance of the {@link NSIndexPath}
	public var index: NSIndexPath?;
    /// Instance of the {@link BaseCollectionCell}
	public weak var cell: BaseCollectionCell?;
    /// {@link Bool} value if it first init
	var isFirstInit: Bool = false;

    /// Method which provide the deinit functional
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

	// MARK: Identifier methods
    
	/**
	 Method which provide to getting of the reuse identifier
	 */
	public final func getReuseIdentifier() -> String! {
		let cellClass: AnyClass! = self.getCellClass();
		let identifier: String! = NSStringFromClass(cellClass).components(separatedBy: (".")).last;
		return identifier;
	}

}
