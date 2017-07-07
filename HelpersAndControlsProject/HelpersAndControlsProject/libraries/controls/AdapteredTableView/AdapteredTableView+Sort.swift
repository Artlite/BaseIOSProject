//
//  AdapteredTableView+Sort.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 7/11/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

extension AdapteredTableView {

	/**
	 Method which provide the sorting object by priority

	 - author: Dmitriy Lernatovich
	 */
	final func sortByPriority() {
		self.objects.sortUsingComparator { (obj1, obj2) -> NSComparisonResult in
			let tObj1: BaseTableObject! = obj1 as! BaseTableObject;
			let tObj2: BaseTableObject! = obj2 as! BaseTableObject;
			if (tObj1.priority.rawValue > tObj2.priority.rawValue) {
				return NSComparisonResult.OrderedAscending;
			} else if (tObj1.priority.rawValue < tObj2.priority.rawValue) {
				return NSComparisonResult.OrderedDescending;
			}
			return NSComparisonResult.OrderedSame;
		}
	}

}
