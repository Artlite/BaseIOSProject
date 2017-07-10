//
//  HeaderCell.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/24/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

class HeaderCell: BaseCollectionCell {

	@IBOutlet weak var labelText: UILabel!

	override func setInterface(fromObject object: BaseCollectionObject!) {
		let cObject: Object? = object as? Object;
		self.labelText.text = cObject?.text;
	}

	internal class Object: BaseCollectionObject {
		public var text: String?;

		init(text: String?) {
			super.init();
			self.text = text;
		}

		override func getCellClass() -> AnyClass! {
			return HeaderCell.classForCoder();
		}
	}

}
