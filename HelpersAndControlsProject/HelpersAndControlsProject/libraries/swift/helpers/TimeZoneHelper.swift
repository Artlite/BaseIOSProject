//
//  TimeZoneHelper.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 7/19/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

public class TimeZoneHelper: NSObject {

	/**
	 Method which provide the getting of the timezone name

	 - author: Dmitriy Lernatovich

	 - returns: time zone name
	 */
	public static func getTimezoneName() -> String {
		return NSTimeZone.local.identifier;
	}

}
