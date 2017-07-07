//
//  ClassHelper.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/24/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

class ClassHelper: NSObject {

	/**
	 Method which provide to getting of the class name from object

	 - parameter object: object

	 - returns: class name
	 */
	static func get(classNameFromClass currentClass: AnyClass?) -> String {
		if (currentClass != nil) {
			let className: String? = NSStringFromClass(currentClass!)
				.components(separatedBy: ".").last;
			if (className != nil) {
				return className!;
			}
		}
		return "";
	}

	/**
	 Method which provide to getting of the class name from object

	 - parameter object: object

	 - returns: class name
	 */
	static func get(classNameFromObject object: NSObject?) -> String {
		if (object != nil) {
			let className: String? = NSStringFromClass(object!.classForCoder)
				.components(separatedBy: ".").last;
			if (className != nil) {
				return className!;
			}
		}
		return "";
	}
}
