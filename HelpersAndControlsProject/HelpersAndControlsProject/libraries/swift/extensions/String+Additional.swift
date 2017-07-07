//
//  String+Additional.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 7/28/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import Foundation

extension String {

	var lastPathComponent: String {
		get {
			return (self as NSString).lastPathComponent
		}
	}

	var pathExtension: String {
		get {
			return (self as NSString).pathExtension
		}
	}

	var stringByDeletingLastPathComponent: String {
		get {
			return (self as NSString).deletingLastPathComponent
		}
	}

	var stringByDeletingPathExtension: String {
		get {
			return (self as NSString).stringByDeletingPathExtension
		}
	}

	var pathComponents: [String] {
		get {
			return (self as NSString).pathComponents
		}
	}

	var length: Int {
		get {
			return self.characters.count;
		}
	}

	func stringByAppendingPathComponent(path: String) -> String {
		let nsSt = self as NSString
		return nsSt.stringByAppendingPathComponent(path)
	}

	func stringByAppendingPathExtension(ext: String) -> String? {
		let nsSt = self as NSString
		return nsSt.stringByAppendingPathExtension(ext)
	}
}
