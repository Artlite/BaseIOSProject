//
//  ViewController.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/24/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AdapteredCollectionDelegate {

	@IBOutlet weak var adapteredView: AdapteredCollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
		self.adapteredView.adapteredDelegate = self;
		self.adapteredView.add(objects: [
			HeaderCell.Object(text: "Badge Helper"),
			DefaultCell.Object(text: "Set badge to 100", needLine: true),
			DefaultCell.Object(text: "Clear badge", needLine: false),
			HeaderCell.Object(text: "Class helper"),
			DefaultCell.Object(text: "Get class name from object", needLine: true),
			DefaultCell.Object(text: "Get class name from class", needLine: false),
			HeaderCell.Object(text: "Smile View"),
			DefaultCell.Object(text: "Show \"Smile View\"", needLine: true),
			DefaultCell.Object(text: "Show \"AdapteredTableView\"", needLine: true),
		]);

		// toAdapteredTable
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning();
	}

	// MARK: Adaptered event
    
    func onEventReceived(eventType event: AdapteredCollectionView.AdapteredEvent!, object: BaseCollectionObject!, index: Int, additionalObject: NSObject?) {
            switch index {
            // MARK: Badge helper
            case 1:
                BadgeHelper.set(applicationBadge: 100);
                break;
            case 2:
                BadgeHelper.clear();
                break;
            // MARK: Class helper
            case 4:
                let className: String? = ClassHelper.get(classNameFromObject: object);
                DialogHelper.show(dialogWithTitle: "Class", message: className, style: .alert, actions: nil, controller: self);
                break;
            case 5:
                let className: String? = ClassHelper.get(classNameFromClass: DefaultCell.classForCoder());
                DialogHelper.show(dialogWithTitle: "Class", message: className, style: .alert, actions: nil, controller: self);
                break;
            case 7:
                let storyboard: UIStoryboard? = UIStoryboard(name: "Smile", bundle: nil);
                let controller: UIViewController? = storyboard?.instantiateViewController(withIdentifier: "SmileController");
                if (controller != nil) {
                    self.navigationController?.present(controller!, animated: true, completion: nil);
                }
                break;
            case 8:
                self.performSegue(withIdentifier: "toAdapteredTable", sender: self);
                break;
            default:
                break;
            }
    }

    func onAlmostAtBottom(listSize size: Int) {
        
    }

	func onRefreshData() {
        self.adapteredView.hideRefreshControl();
	}

}

