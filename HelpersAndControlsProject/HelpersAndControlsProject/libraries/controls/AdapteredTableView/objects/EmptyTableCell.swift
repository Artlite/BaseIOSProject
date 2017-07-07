//
//  BaseTableCell.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 6/13/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

class EmptyTableCell: UITableViewCell {

	override func awakeFromNib() {
		super.awakeFromNib()
		self.selectionStyle = .None;
	}

	override func setSelected(selected: Bool, animated: Bool) {
		self.selectionStyle = .None;
		super.setSelected(selected, animated: animated)
	}

}
