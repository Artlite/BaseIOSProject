//
//  AdapteredTableController.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/31/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

class AdapteredTableController: UIViewController, AdapteredTableDelegate {

	@IBOutlet weak var adapteredTable: AdapteredTableView!

	override func viewDidLoad() {
		super.viewDidLoad();
		self.adapteredTable.delegate = self;
        self.onInitTabledata();
	}
    
    /// Method which provide the initialize of the bable data
    func onInitTabledata(){
        self.adapteredTable.set(objects: [
            BaseTableCell.Object(text: "Don't cry because it's over, smile because it happened."),
            BaseTableCell.Object(text: "I'm selfish, impatient and a little insecure. I make mistakes, I am out of control and at times hard to handle. But if you can't handle me at my worst, then you sure as hell don't deserve me at my best."),
            BaseTableCell.Object(text: "Be yourself; everyone else is already taken."),
            BaseTableCell.Object(text: "You know you're in love when you can't fall asleep because reality is finally better than your dreams."),
            BaseTableCell.Object(text: "Here's to the crazy ones. The misfits. The rebels. The troublemakers. The round pegs in the square holes. The ones who see things differently. They're not fond of rules. And they have no respect for the status quo. You can quote them, disagree with them, glorify or vilify them. About the only thing you can't do is ignore them. Because they change things. They push the human race forward. And while some may see them as the crazy ones, we see genius. Because the people who are crazy enough to think they can change the world, are the ones who do."),
            BaseTableCell.Object(text: "Twenty years from now you will be more disappointed by the things that you didn't do than by the ones you did do. So throw off the bowlines. Sail away from the safe harbor. Catch the trade winds in your sails. Explore. Dream. Discover."),
            ]);
        self.adapteredTable.hideRefreshControl();
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	// MARK: Adaptered delagates
   
    func onEventReceived(eventType event: AdapteredTableView.Event!, object: BaseTableObject!, index: Int, additionalObject: NSObject?) {
        if (event.isEqual(BaseTableCell.EVENT) == true) {
            (object as? BaseTableCell.Object)?.text = "Changed text for background";
            self.adapteredTable.update(cellByIndex: Int(index));
        }
    }
    
    func onAlmostAtBottom(listSize size: Int) {
        
    }

    func onRefreshData() {
        self.onInitTabledata();
        self.adapteredTable.hideRefreshControl();
    }
    
    func onPostProcessing(objects: [BaseTableObject]) -> [BaseTableObject] {
        return objects;
    }
}
