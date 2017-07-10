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

    @IBAction func onImagePressed(_ sender: Any) {
        self.sendEvent(event: BaseTableCell.EVENT);
    }
    
    override func getCellActions(object: BaseTableObject?, indexPath: NSIndexPath?, delegate: AdapteredTableCellDelegate?) -> [UITableViewRowAction] {
        let action: UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Some Action") { (action, indexPath) in
            
        };
        action.backgroundColor = UIColor.orange;
        return [action];
    }
    
    override func canEditCell(object: BaseTableObject?) -> Bool {
        return true;
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
