//
//  AdapteredTableView+Management.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/31/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

extension AdapteredTableView {

	/**
	 Method which provide the adding of the table view object

	 - parameter object: object
	 */
	final func add(object: BaseTableObject?) {
		if (object != nil) {
			self.add(objects: [object!]);
		}
	}

	/**
	 Method which provide the adding of the table view objects

	 - parameter objects: objects
	 */
	final func add(objects: [BaseTableObject]?) {
		if (objects != nil) {
			self.objects.addObjects(from: objects!);
			self.registerCellsNib();
			self.notifyDataSetChanged();
		}
	}

	/**
	 Method which provide the object setting

	 - parameter object: object
	 */
	final func set(object: BaseTableObject?) {
		if (object != nil) {
			self.set(objects: [object!]);
		}
	}

	/**
	 Method which provide the adding of the table view objects

	 - parameter objects: objects
	 */
	final func set(objects: [BaseTableObject]?) {
		if (objects != nil) {
			self.objects = NSMutableArray(array: objects!);
			// CLear previous selection indexes
			self.clearSelectionIndex();
			self.clearSelectionIndexes();
			// Clear size list for paging
			self.listSizeOld = self.objects.count - 1;
			self.registerCellsNib();
			self.notifyDataSetChanged();
		}
	}

	/**
	 Method which provide the object removing

	 - parameter object: object for remove
	 */
	final func remove(object: BaseTableObject?) {
		self.remove(object: object, needNotify: true);
	}

	/**
	 Method which provide the removing object by index

	 - parameter index: index
	 */
	final func remove(objectByIndex index: Int) {
		let object = self.getObject(byIndex: index);
		self.remove(object: object, needNotify: true);
	}

	/**
	 Method which provide the object removing

	 - parameter object: object for remove
	 */
	private func remove(object: BaseTableObject?, needNotify: Bool) {
		if (object != nil) {
			self.objects.remove(object!);

			// Remove selection index path
			if let index = object?.index {
                self.remove(indexPath: index);
			}

			if (needNotify == true) {
				self.notifyDataSetChanged();
			}
		}
	}

	/**
	 Method which provide the objects removing

	 - parameter objects: objects
	 */
	final func remove(objects: [BaseTableObject]?) {
		if (objects != nil) {
			for object in objects! {
				self.remove(object: object, needNotify: false);
			}
			self.notifyDataSetChanged();
		}
	}

	/**
	 Method which provide the removing of the all of objects inside the AdapteredTableView

	 - author: Dmitriy Lernatovich
	 */
	final func removeAll() {
		self.objects.removeAllObjects();
		self.notifyDataSetChanged();
	}

	/**
	 Method which provide the getting of the table object by index

	 - parameter index: index

	 - returns: object
	 */
	final func getObject(byIndex index: Int) -> BaseTableObject? {
		if (index < self.objects.count) {
			let object: BaseTableObject? = self.objects.object(at: index) as? BaseTableObject;
			return object;
		}
		return nil;
	}

	/**
	 Method which provide the getting of the selected object
	 (WARNING: if self.allowMultipleSelection == true in this case method will
	 return first object)

	 - returns: selected object
	 */
	final func getSelectedObject() -> BaseTableObject? {
		if (self.previousIndex != nil) {
			if let object = self.getObject(byIndex: self.previousIndex!.section) {
				return object;
			}
		}
		return nil;
	}

	/**
	 Method which provide the getting of the selecting objects

	 - returns: selecting objects
	 */
	final func getSelectedObjects() -> [BaseTableObject] {
		var objects: [BaseTableObject] = [];
		if (self.allowMultipleSelection == true) {
			for index in self.previousIndexes {
				if let object = self.getObject(byIndex: index.section) {
					objects.append(object);
				}
			}
		} else {
			if let object = self.getSelectedObject() {
				objects.append(object);
			}
		}
		return objects;
	}

	/**
	 Method which provide the getting of the object count

	 - returns: object count
	 */
	final func getObjectsCount() -> Int {
		return self.objects.count;
	}

	/**
	 Method which provide the notifying of the data set changed
	 */
	final func notifyDataSetChanged() {
		self.sortByPriority();
		// Post processing functional before table update
		if let typedObjects = self.objects as? NSArray as? [BaseTableObject] {
			if let postProcessedObjects = self.delegate?.onPostProcessing?(objects: typedObjects) {
				let array: NSMutableArray = NSMutableArray(array: postProcessedObjects);
				self.objects = array;
			}
		}
		// Notify data set changed
		DispatchQueue.main.async(execute: { [weak self] in
			self?.tableView.reloadData();
			self?.tableView.reloadInputViews();
			self?.onRestoreSelection();
			self?.onRestoreSelections();
		});
	}

	/**
	 Method which provide the selection restoring
	 if self.allowMultipleSelection == false
	 */
	private func onRestoreSelection() {
		if (self.allowMultipleSelection == false) {
			if (self.previousIndex != nil) {
				self.tableView.selectRow(at: self.previousIndex! as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none);
			}
		}
	}

	/**
	 Method which provide the selections restoring
	 if self.allowMultipleSelection == true
	 */
	private func onRestoreSelections() {
		if (self.allowMultipleSelection == true) {
			for index in self.previousIndexes {
				self.tableView.selectRow(at: index as IndexPath, animated: true,
					scrollPosition: UITableViewScrollPosition.none);
			}
		}
	}

	// MARK: management with animations
	/**
	 Method which provide the object removing with remove animation

	 - parameter object: object for remove
	 */
	final func remove(objectWithAnimation object: BaseTableObject?) {
		DispatchQueue.main.async(execute: { [weak self] in
			if (object != nil) {
				if let index = object?.index {
					self?.tableView.beginUpdates();
					self?.tableView.deleteSections(NSIndexSet(index: index.section) as IndexSet, with: UITableViewRowAnimation.automatic);
					self?.objects.remove(object!);
					self?.tableView.endUpdates();
					// Notify data set changed
                    DispatchQueue.global().asyncAfter(deadline: .now() + 0.8) {
                        self?.notifyDataSetChanged();
                    }
				}
			}
		});
	}

	/**
	 Method which provide the removing object by index

	 - parameter index: index
	 */
	final func remove(objectByIndexWithAnimation index: Int) {
		let object = self.getObject(byIndex: index);
		self.remove(objectWithAnimation: object);
	}

}
