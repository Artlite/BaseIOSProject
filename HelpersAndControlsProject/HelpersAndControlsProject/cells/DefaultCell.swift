//
//  SetBadgeCell.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/24/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

class DefaultCell: BaseCollectionCell {

	@IBOutlet weak var labelText: UILabel!
	@IBOutlet weak var viewBottom: UIView!

	override func setInterface(fromObject object: BaseCollectionObject!) {
		let cObject: Object? = object as? Object;
		self.labelText.text = cObject?.text;
		self.viewBottom.hidden = !cObject!.needLine;
	}

	internal class Object: BaseCollectionObject {
		private var text: String?;
		private var needLine: Bool = true;

		init(text: String?, needLine: Bool) {
			super.init();
			self.text = text;
			self.needLine = needLine;
		}

		override func getCellClass() -> AnyClass! {
			return DefaultCell.classForCoder();
		}
	}

}
