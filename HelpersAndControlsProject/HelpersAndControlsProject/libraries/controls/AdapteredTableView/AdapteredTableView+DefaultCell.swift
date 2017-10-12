//
//  AdapteredTableView+DefaultCell.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 6/13/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

public extension AdapteredTableView {

	/**
	 Method which provide
	 */
	public func registerDefaultCell() {
		let nib = UINib.init(nibName: AdapteredTableView.K_EMPTY_CELL, bundle: Bundle(for: EmptyTableCell.self));
		self.tableView.register(nib, forCellReuseIdentifier: AdapteredTableView.K_EMPTY_CELL);
	}

	/**
	 Method which provide the getting of the empty table view cell

	 - parameter tableView: table view
	 - parameter indexPath: index path

	 - returns: cell
	 */
	public func get(emptyCell tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: AdapteredTableView.K_EMPTY_CELL, for: indexPath as IndexPath);
		return cell;
	}

}
