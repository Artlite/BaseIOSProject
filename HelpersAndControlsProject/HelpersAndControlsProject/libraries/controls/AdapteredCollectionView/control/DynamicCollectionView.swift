//
//  ZHDynamicCollectionView.swift
//
//  Created by Honghao on 1/1/15.
//  Copyright (c) 2015 Honghao. All rights reserved.
//

import UIKit

public class DynamicCollectionView: UICollectionView {
	// A dictionary of offscreen cells that are used within the sizeForItemAtIndexPath method to handle the size calculations. These are never drawn onscreen. The dictionary is in the format:
	// { NSString *reuseIdentifier : UICollectionViewCell *offscreenCell, ... }
    
    /// Instance of the {@link Dictionary}
    private var offscreenCells = Dictionary<String, UICollectionViewCell>();
    /// Instance of the {@link Dictionary}
    private var registeredCellNibs = Dictionary<String, UINib>();
    /// Instance of the {@link Dictionary}
    private var registeredCellClasses = Dictionary<String, UICollectionViewCell.Type>();

    /// Method which provide the registering of the cell
    ///
    /// - Parameters:
    ///   - cellClass: {@link AnyClass} value of the cell class
    ///   - identifier: {@link String} value of the cell reuse identifier
	override func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
		super.register(cellClass, forCellWithReuseIdentifier: identifier)
		registeredCellClasses[identifier] = cellClass as! UICollectionViewCell.Type!
	}

    /// Method which provide the registering of the cell
    ///
    /// - Parameters:
    ///   - nib: {@link UINib} value of the cell class
    ///   - identifier: {@link String} value of the cell reuse identifier
	override func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
		super.register(nib, forCellWithReuseIdentifier: identifier)
		registeredCellNibs[identifier] = nib
	}

	/**
	 Returns a reusable collection cell object located by its identifier.
	 This collection cell is not showing on screen, it's useful for calculating dynamic cell size
	 - parameter identifier: A string identifying the cell object to be reused. This parameter must not be nil.

	 - returns: UICollectionViewCell?
	 */
	func dequeueReusableOffScreenCellWithReuseIdentifier(identifier: String) -> UICollectionViewCell? {
		var cell: UICollectionViewCell? = offscreenCells[identifier]
		if cell == nil {
			if registeredCellNibs.index(forKey: identifier) != nil {
				let cellNib: UINib = registeredCellNibs[identifier]! as UINib
				cell = cellNib.instantiate(withOwner: nil, options: nil)[0] as? UICollectionViewCell
			} else if registeredCellClasses.index(forKey: identifier) != nil {
				let cellClass = registeredCellClasses[identifier] as UICollectionViewCell.Type!
				cell = cellClass?.init()
			} else {
				return nil;
			}
			offscreenCells[identifier] = cell
		}
		return cell
	}
}
