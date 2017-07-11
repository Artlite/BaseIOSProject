//
//  BaseTableCell.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 6/13/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

open class EmptyTableCell: UITableViewCell {

	override open func awakeFromNib() {
		super.awakeFromNib()
		self.selectionStyle = .none;
	}

	override open func setSelected(_ selected: Bool, animated: Bool) {
		self.selectionStyle = .none;
		super.setSelected(selected, animated: animated)
	}

}
