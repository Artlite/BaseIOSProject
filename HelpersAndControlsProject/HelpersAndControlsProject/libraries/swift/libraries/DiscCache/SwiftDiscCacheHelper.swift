//
//  CacheHelper+Implementations.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 7/28/16.
//  Copyright © 2016 magnet. All rights reserved.
//

public class SwiftDiscCacheHelper {

	/**
	 Method which provide the getting of the directory path

	 - author: Dmitriy Lernatovich

	 - returns: directory path
	 */
    @discardableResult
	private static func getDirectoryPath() -> String? {
		let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
		if let filePath = paths.first {
			return filePath;
		}
		return nil;
	}

	/**
	 Method which provide the getting of the file name

	 - author: Dmitriy Lernatovich

	 - parameter userID: user ID

	 - returns: file name
	 */
    @discardableResult
	private static func get(filePath prefix: String, fileFormat: String, fileType: String) -> String {
		let fileName: String = String(format: fileFormat, prefix, fileType);
		if let filePath = self.getDirectoryPath()?.stringByAppendingPathComponent(path: fileName) {
			return filePath;
		}
		return "";
	}

	/**
	 Method which provide th getting file paths by type

	 - author: Dmitriy Lernatovich

	 - parameter fileType: file type

	 - returns: paths
	 */
    @discardableResult
	private static func get(filesByType fileType: String) -> [String] {
		var objects: [String] = [];
		do {
			// Get files path
			if let filesPath = self.getDirectoryPath() {
				// get all files in directory
				var dirFiles = try FileManager.default.contentsOfDirectory(atPath: filesPath);
				// Filter array by files extension
				dirFiles = dirFiles.filter({ (value) -> Bool in
					if (value.pathExtension.caseInsensitiveCompare(fileType) == ComparisonResult.orderedSame) {
						return true;
					}
					return false;
				});

				// Get file paths
				for file in dirFiles {
					objects.append(filesPath.stringByAppendingPathComponent(path: file));
				}
			}
		} catch _ {
			print("Can't get of the cahced data");
		}
		return objects;
	}

	// MARK:Functional from previous manager
	/**
	 Method which checking if file is exists

	 - author: Dmitriy Lernatovich

	 - parameter filePath: file path

	 - returns: checking value
	 */
    @discardableResult
	private static func exist(file filePath: String) -> Bool {
		let result: Bool = ((FileManager.default.fileExists(atPath: filePath)) && ((NSData(contentsOfFile: filePath)?.length)! > 0));
		return result;
	}

	/**
	 Method which provide the removing of the file by path

	 - author: Dmitriy Lernatovich

	 - parameter filePath: file path

	 - returns: is removed
	 */
    @discardableResult
	private static func remove(file filePath: String) -> Bool {
		do {
			try FileManager.default.removeItem(atPath: filePath);
		} catch _ {
			return false;
		}
		return true;
	}

	/**
	 Method which provide the saving object to file

	 - author: Dmitriy Lernatovich

	 - parameter object:   object
	 - parameter filePath: file path

	 - returns: sucess
	 */
    @discardableResult
	private static func save<T: NSObject>(object: T?, filePath: String) -> Bool {
		if let strongObject = object {
			self.remove(file: filePath);
			return NSKeyedArchiver.archiveRootObject(strongObject, toFile: filePath);
		}
		return false;
	}

	/**
	 Method which provid the getting ofbject from file path

	 - author: Dmitriy Lernatovich

	 - parameter filePath: file path

	 - returns: object
	 */
    @discardableResult
	private static func get<T: NSObject>(file filePath: String) -> T? {
		if (self.exist(file: filePath) == true) {
			if let object = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? T {
				return object;
			}
		}
		return nil;
	}

	// MARK: Add object
	/**
	 Method which provide the adding of the file to local cache

	 - author: Dmitriy Lernatovich

	 - parameter object:     object
	 - parameter prefix:     prefix, ID, etc.
	 - parameter fileFormat: file format (should be, for example, "%@_users.%@")
	 - parameter fileType:   file type
	 */
    @discardableResult
	public static func add<T: NSObject>(object: T?,
                                        prefix: String?,
                                        fileFormat: String,
                                        fileType: String) -> Bool {
		var result: Bool = false;
		if let strongObject = object {
			if let strongPrefix = prefix {
				let filePath: String = self.get(filePath: strongPrefix,
                                                fileFormat: fileFormat,
                                                fileType: fileType);
				if (self.exist(file: filePath) == true) {
					self.remove(file: filePath);
				}
				self.save(object: strongObject, filePath: filePath);
				result = true;
			}
		}
		return result;
	}

	/**
	 Method which provide the objects adding

	 - author: Dmitriy Lernatovich

	 - parameter objects:    objects
	 - parameter prefixes:   prefixes for objects
	 - parameter fileFormat: file format (should be, for example, "%@_users.%@")
	 - parameter fileType:   file type
	 */
    @discardableResult
	public static func add<T: NSObject>(objects: [T]?,
                                        prefixes: [String]?,
                                        fileFormat: String,
                                        fileType: String) -> Bool {
		var result: Bool = false;
		if let strongObjects = objects {
			if let strongPrefixes = prefixes {
				if ((strongObjects.count != 0) && (strongPrefixes.count != 0)) {
					for i in 0...strongObjects.count - 1 {
						if (i < (prefixes?.count)!) {
							let object: NSObject = strongObjects[i];
							let prefix: String = strongPrefixes[i];
							self.add(object: object,
                                     prefix: prefix,
                                     fileFormat: fileFormat,
                                     fileType: fileType);
						}
					}
					result = true;
				}
			}
		}
		return result;
	}

	// MARK:Remove objects
	/**
	 Method which provide the removing of the file to local cache

	 - author: Dmitriy Lernatovich

	 - parameter prefix:     prefix, ID, etc.
	 - parameter fileFormat: file format (should be, for example, "%@_users.%@")
	 - parameter fileType:   file type
	 */
    @discardableResult
	public static func remove(object prefix: String?,
                              fileFormat: String,
                              fileType: String) -> Bool {
		var result: Bool = false;
		if let strongPrefix = prefix {
			let fileName: String = self.get(filePath: strongPrefix,
                                            fileFormat: fileFormat,
                                            fileType: fileType);
			if (self.exist(file: fileName) == true) {
				self.remove(file: fileName);
				result = true;
			}
		}
		return result;
	}

	/**
	 Method which provide the objects removing

	 - author: Dmitriy Lernatovich

	 - parameter objects:    objects
	 - parameter prefixes:   prefixes for objects
	 - parameter fileFormat: file format (should be, for example, "%@_users.%@")
	 - parameter fileType:   file type
	 */
    @discardableResult
	public static func remove(objects prefixes: [String]?,
                              fileFormat: String,
                              fileType: String) -> Bool {
		var result: Bool = false;
		if let strongPrefixes = prefixes {
			for prefix in strongPrefixes {
				self.remove(object: prefix,
                            fileFormat: fileFormat,
                            fileType: fileType);
			}
			result = true;
		}
		return result;
	}

	/**
	 Method which provide the objects clering

	 - author: Dmitriy Lernatovich

	 - parameter fileType: file type

	 - returns: process result
	 */
    @discardableResult
	public static func clear(objects fileType: String) -> Bool {
		if let paths: [String] = self.get(filesByType: fileType) {
			for path in paths {
				self.remove(file: path);
			}
			return true;
		}
		return false;
	}

	// MARK: Get objects functional
	/**
	 Method which provide the object getting

	 - author: Dmitriy Lernatovich

	 - parameter prefix:     prefix
	 - parameter fileFormat: file format (should be, for example, "%@_users.%@")
	 - parameter fileType:   file type
	 */
    @discardableResult
	public static func get<T: NSObject>(object prefix: String?,
                                        fileFormat: String,
                                        fileType: String) -> T? {
		if let strongPrefix = prefix {
			let fileName: String = self.get(filePath: strongPrefix,
                                            fileFormat: fileFormat,
                                            fileType: fileType);
			if (self.exist(file: fileName) == true) {
				return self.get(file: fileName);
			}
		}
		return nil;
	}

	/**
	 Method which provide the get objects

	 - author: Dmitriy Lernatovich

	 - parameter fileType: file format

	 - returns: objects array
	 */
    @discardableResult
	public static func get<T: NSObject>(objects fileType: String) -> [T] {
		// Creat predefined array
		var objects: [T] = [];
		if let paths: [String] = self.get(filesByType: fileType) {
			for path in paths {
				if let object = self.get(file: path) as? T {
					objects.append(object);
				}
			}
		}
		return objects;
	}

}
