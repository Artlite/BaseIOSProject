//
//  AdapteredCollectionDelegate+Management.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/13/16.
//  Copyright © 2016 Magnet. All rights reserved.
//
import UIKit
public extension AdapteredCollectionView {

	/**
	 Method which provide the object adding

	 - parameter object: object for add
	 */
	public func add(object: BaseCollectionObject?) {
		if (object != nil) {
			self.add(objects: [object!]);
		}
	}

	/**
	 Method which provide the objects adding

	 - parameter objects: objects for add
	 */
	public func add(objects: [BaseCollectionObject]?) {
		if (objects != nil) {
			self.objects.addObjects(from: objects!);
			self.registerCellsNib();
			self.notifyDataSetChanged();
		}
	}

	/**
	 Method which provide the objects adding

	 - parameter objects: objects for add
	 */
	public func set(objects: [BaseCollectionObject]?) {
		if (objects != nil) {
			self.objects = NSMutableArray(array: objects!);
			self.listSizeOld = self.objects.count - 1;
			self.registerCellsNib();
			self.notifyDataSetChanged();
		}
	}

	/**
	 Method which provide the removing of the cell

	 - parameter object: cell object
	 */
	public func remove(object: BaseCollectionObject?) {
		if (object != nil) {
			self.remove(objects: [object!]);
		}
	}

	/**
	 Method which provide the removing objects from the collection view

	 - parameter objects: objects to remove
	 */
	public func remove(objects: [BaseCollectionObject]?) {
		if ((objects != nil) && (objects?.isEmpty == false)) {
			self.objects.removeObjects(in: objects!);
			self.listSizeOld = self.objects.count - 1;
			self.notifyDataSetChanged();
		}
	}

	/**
	 Method which provide the updating cell by object

	 - parameter object: object
	 */
	public func update(byObject object: BaseCollectionObject?) {
		self.update(byIndex: object?.index);
	}

	/**
	 Method which provide the updating object by index path

	 - parameter index: index path
	 */
	public func update(byIndex index: NSIndexPath?) {
		if (index != nil) {
			DispatchQueue.main.async(execute: {
				self.collectionView.reloadItems(at: [index! as IndexPath]);
			});
		}
	}

	/**
	 Method which provide the getting of the objects array

	 - returns: objects array
	 */
	public func getObjectsArray() -> [BaseCollectionObject]? {
		var array: [BaseCollectionObject]! = [];
		let currentElements: [BaseCollectionObject]? = (self.objects as [AnyObject]) as? [BaseCollectionObject];
		if (currentElements != nil) {
			array.append(contentsOf: currentElements!);
		}
		return array;
	}

	/**
	 Method which provide to getting of the elements count

	 - returns: elements count
	 */
	public func getElementCount() -> Int {
		return self.objects.count;
	}

	/**
	 Method which provide the getting ofbject by index

	 - parameter index: index

	 - returns: getting object
	 */
	public func getObject(byIndex index: Int!) -> BaseCollectionObject? {
		return self.objects[index] as? BaseCollectionObject;
	}

	/**
	 Method which provide the data cleaning

	 - parameter needInterfaceUpdate: is need UI refresh
	 */
	public final func removeAll() {
		self.listSizeOld = -1;
		self.objects.removeAllObjects();
		self.notifyDataSetChanged();
	}

	/**
	 Method which provide the content updating
	 */
	public final func notifyDataSetChanged() {
		DispatchQueue.main.async(execute: {
			self.collectionView.reloadData();
			self.collectionView.reloadInputViews();
		});
	}

}
