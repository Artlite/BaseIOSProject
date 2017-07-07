//
//  AdapteredTableView+DefaultCell.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 6/13/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

extension AdapteredTableView {

	/**
	 Method which provide
	 */
	func registerDefaultCell() {
		let nib = UINib.init(nibName: AdapteredTableView.K_EMPTY_CELL, bundle: NSBundle(forClass: EmptyTableCell.self));
		self.tableView.registerNib(nib, forCellReuseIdentifier: AdapteredTableView.K_EMPTY_CELL);
	}

	/**
	 Method which provide the getting of the empty table view cell

	 - parameter tableView: table view
	 - parameter indexPath: index path

	 - returns: cell
	 */
	func get(emptyCell tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(AdapteredTableView.K_EMPTY_CELL, forIndexPath: indexPath);
		return cell;
	}

}
