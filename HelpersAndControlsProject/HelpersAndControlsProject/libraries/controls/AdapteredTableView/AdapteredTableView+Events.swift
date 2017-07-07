//
//  AdapteredTableView+Events.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/31/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

extension AdapteredTableView {

	// MARK: Event class
	internal class Event: NSObject {
		private var eventCode: Int! = nil;
		/**
		 Constructor which provide the class creating with the event code

		 - parameter eventCode: event code

		 - returns: self object
		 */
		init(eventCode: Int!) {
			super.init();
			self.eventCode = eventCode;
		}

		/**
		 Method which provide to getting of the event code

		 - returns: event code
		 */
		internal func getEventCode() -> Int! {
			return self.eventCode;
		}

		override func isEqual(object: AnyObject?) -> Bool {
			let eventObject: Event? = object as? Event;
			if (eventObject != nil) {
				if (eventObject?.getEventCode() == self.eventCode) {
					return true;
				}
			}
			return false;
		}
	}

	/**
	 Method which provide the sending of the event results

	 - parameter event:  event object
	 - parameter object: result object
	 */
	internal final func sendEventResults(event event: Event?, object: NSObject?, intdex: Int) {
		var dict: Dictionary<String, AnyObject> = [:];

		dict[AdapteredTableView.K_EVENT_INDEX_KEY] = intdex;

		if (event != nil) {
			dict[AdapteredTableView.K_EVENT_KEY] = event!;
		}

		if (object != nil) {
			dict[AdapteredTableView.K_EVENT_OBJECT] = object!;
		}

		NSNotificationCenter.defaultCenter().postNotificationName(AdapteredTableView.K_EVENT_RESULT_NOTIFICATION, object: nil, userInfo: dict);
	}
}
