//
//  String+Additional.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 7/28/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import Foundation

public extension String {

	public var lastPathComponent: String {
		get {
			return (self as NSString).lastPathComponent
		}
	}

	public var pathExtension: String {
		get {
			return (self as NSString).pathExtension
		}
	}

	public var stringByDeletingLastPathComponent: String {
		get {
			return (self as NSString).deletingLastPathComponent
		}
	}

	public var stringByDeletingPathExtension: String {
		get {
			return (self as NSString).deletingPathExtension
		}
	}

	public var pathComponents: [String] {
		get {
			return (self as NSString).pathComponents
		}
	}

	public var length: Int {
		get {
			return self.characters.count;
		}
	}

	public func stringByAppendingPathComponent(path: String) -> String {
		let nsSt = self as NSString
		return nsSt.appendingPathComponent(path)
	}

	public func stringByAppendingPathExtension(ext: String) -> String? {
		let nsSt = self as NSString
		return nsSt.appendingPathExtension(ext)
	}
}
