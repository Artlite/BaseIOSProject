//
//  BaseTableCell.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/31/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

class BaseTableCell: BaseTableViewCell {

	static let EVENT: AdapteredTableView.Event = AdapteredTableView.Event(eventCode: 1);

	@IBOutlet weak var labelText: UILabel!
	@IBOutlet weak var labelTitle: UILabel!

	override func setInterface(fromObject object: BaseTableObject!) {
		let cObject: Object? = object as? Object;
		self.labelText.text = cObject?.text;
		self.labelTitle.text = cObject?.text;
	}

	@IBAction func onImagePressed(sender: AnyObject) {
		self.sendEvent(event: BaseTableCell.EVENT);
	}

	override func getCellActions() -> [UITableViewRowAction] {
		let action: UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Some Action") { (action, indexPath) in

		};
		action.backgroundColor = UIColor.orangeColor();
		return [action];
	}

	internal class Object: BaseTableObject {

		var text: String?;

		init(text: String?) {
			super.init();
			self.text = text;
		}

		override func getCellClass() -> AnyClass! {
			return BaseTableCell.classForCoder();
		}

	}

}
