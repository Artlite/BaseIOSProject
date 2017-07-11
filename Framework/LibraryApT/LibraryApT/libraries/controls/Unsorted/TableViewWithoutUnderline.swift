//
//  TableViewWithoutUnderline.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 5/18/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

class TableViewWithoutUnderline: UITableView {

    override func awakeFromNib() {
        self.tableFooterView = UITableView(frame: CGRect.zero);
    }

}
