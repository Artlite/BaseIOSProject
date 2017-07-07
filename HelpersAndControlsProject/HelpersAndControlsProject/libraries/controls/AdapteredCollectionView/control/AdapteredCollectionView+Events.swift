//
//  AdapteredCollectionView+Events.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 26.04.16.
//  Copyright © 2016 Magnet. All rights reserved.
//
import UIKit
extension AdapteredCollectionView {

	/**
	 Method which provide the sending of the event results

	 - parameter event:  event object
	 - parameter object: result object
	 */
	internal final func sendEventResults(event: AdapteredCollectionView.AdapteredEvent?, object: NSObject?, intdex: Int) {
		var dict: Dictionary<String, AnyObject> = [:];

		dict[AdapteredTableView.K_EVENT_INDEX_KEY] = intdex;

		if (event != nil) {
			dict[AdapteredCollectionView.K_EVENT_KEY] = event!;
		}

		if (object != nil) {
			dict[AdapteredCollectionView.K_EVENT_OBJECT] = object!;
		}

		NSNotificationCenter.defaultCenter().postNotificationName(AdapteredCollectionView.K_EVENT_RESULT_NOTIFICATION, object: nil, userInfo: dict);
	}

}
