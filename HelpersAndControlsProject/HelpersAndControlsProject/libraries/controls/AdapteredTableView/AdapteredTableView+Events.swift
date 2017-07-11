//
//  AdapteredTableView+Events.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/31/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

public extension AdapteredTableView {

	// MARK: Event class
	public class Event: NSObject {
		public var eventCode: Int! = nil;
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
		public func getEventCode() -> Int! {
			return self.eventCode;
		}
        
        /// Method which provide the equaling of the object
        ///
        /// - Parameter object: {@link Any} object
        /// - Returns: equaling result
        override public func isEqual(_ object: Any?) -> Bool {
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
	public final func sendEventResults(event: Event?, object: NSObject?, intdex: Int) {
		var dict: Dictionary<String, AnyObject> = [:];

		dict[AdapteredTableView.K_EVENT_INDEX_KEY] = intdex as AnyObject;

		if (event != nil) {
			dict[AdapteredTableView.K_EVENT_KEY] = event!;
		}

		if (object != nil) {
			dict[AdapteredTableView.K_EVENT_OBJECT] = object!;
		}
        
        NotificationCenter.default.post(name: AdapteredTableView.K_EVENT_RESULT_NOTIFICATION, object: nil, userInfo: dict);
	}
}
