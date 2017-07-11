//
//  BaseTableViewCell.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/25/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {

	var index: Int! = -1;
	var indexPath: NSIndexPath?;
	weak var object: BaseTableObject?;
	weak var delegate: AdapteredTableCellDelegate?;

	override open func awakeFromNib() {
		super.awakeFromNib();
		self.subscribeForNotification();
		self.onCreateCell();
	}

	override open func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	deinit {
		NSLog("Cell(deinit): %@", NSStringFromClass(self.classForCoder));
		NotificationCenter.default.removeObserver(self);
	}

	/**
	 Method which provide the setting up of the interface

	 - parameter object: object for setting up
	 */
	internal func setInterface(fromObject object: BaseTableObject!) {
		// fatalError(String(format:"internal func setInterface(fromObject object:BaseCollectionObject!) -> Should be overriden in %@", NSStringFromClass(self.classForCoder)));
	}

	/**
	 Method which provide the setting interface of the first time

	 - parameter object: object
	 */
	internal func setInterface(firstTime object: BaseTableObject!) {
		self.setInterface(fromObject: object);
	}

	/**
	 Method which provide the give of the additional functional for the cell resizing
	 (WARNING: SHOULD BE OVERRIDEN IN CHILD CLASSES)
	 */
	override open func layoutSubviews() {
		super.layoutSubviews();
		// IF LABELS HAVE ADDITIONAL PADDING FROM RIGHT AND LEFT, IN THIS CASE preferredMaxLayoutWidth SHOULD BE DEFINED, IN
		// OTHER CASE UI WON'T BE DISPLAYING AS WELL
		//
		// EXAMPLE TO USE:
		// super.layoutSubviews();
		// let layoutWidth:CGFloat! = self.bounds.width - K_REMOVABLE_WIDTH;
		// self.labelHeader.preferredMaxLayoutWidth = layoutWidth;
		// self.labelConten.preferredMaxLayoutWidth = layoutWidth;
	}

	/**
	 Method which provide the action when cell is created
	 */
	func onCreateCell() {

	}

	// MARK: Events
	/**
	 Method which provide to send of the event

	 - parameter event: event object
	 */
	final func sendEvent(event: AdapteredTableView.Event!) {
		self.sendEvent(event: event, additionalObject: nil);
	}

	/**
	 Method which provide the event sending with object

	 - parameter event:            event
	 - parameter additionalObject: additional object
	 */
	final func sendEvent(event: AdapteredTableView.Event!, additionalObject: NSObject?) {
		self.delegate?.onEventReceived(eventType: event, index: self.index, additionalObject: additionalObject);
	}

	/**
	 Method which provide the event sending with object

	 - parameter event:            event
	 - parameter additionalObject: additional object
	 */
	final func sendEvent(event: AdapteredTableView.Event!, indexPath: NSIndexPath?, delegate: AdapteredTableCellDelegate?) {
		delegate?.onEventReceived(eventType: event, index: indexPath?.section, additionalObject: nil);
	}

	/**
	 Method which provide the updating of the current cell
	 */
	final func update() {
		self.delegate?.update(cellByIndexPath: self.indexPath);
	}

	// MARK: On event result notification
	/**
	 Method which provide the subscribe for notifications
	 */
	private func subscribeForNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(BaseTableViewCell.onRecieveNotification(notification:)), name: AdapteredTableView.K_EVENT_RESULT_NOTIFICATION, object: nil);
	}

	/**
	 Method which provide the recieve of the notifications

	 - parameter notification: notifications
	 */
	final func onRecieveNotification(notification: NSNotification?) {
		if (notification == nil) {
			return;
		}
		let userInfo: Dictionary<String, AnyObject> = notification!.userInfo as! Dictionary<String, AnyObject>
		let event: AdapteredTableView.Event? = userInfo[AdapteredTableView.K_EVENT_KEY] as? AdapteredTableView.Event;
		let object: NSObject? = userInfo[AdapteredTableView.K_EVENT_OBJECT] as? NSObject;
		let index: Int? = userInfo[AdapteredTableView.K_EVENT_INDEX_KEY] as? Int;
		if (index == self.index) {
			self.onResultEvent(event: event, object: object);
		}
	}

	/**
	 Method which provide the getting of the result from the event
	 (SHOULD BE OVERRIDEN IN CHILD CLASS)

	 - parameter event:  event
	 - parameter object: object
	 */
	func onResultEvent(event: AdapteredTableView.Event?, object: NSObject?) {

	}

	/**
	 Method which provide the getting of the cell actions

	 - returns: cell actions
	 */
	internal func getCellActions(object: BaseTableObject?, indexPath: NSIndexPath?, delegate: AdapteredTableCellDelegate?) -> [UITableViewRowAction] {
		return [];
	}

	/**
	 Method which provide the allowing/disabling editing of the cell

	 - parameter object: object

	 - returns: allowing/not allowing
	 */
	internal func canEditCell(object: BaseTableObject?) -> Bool {
		return false;
	}

	/**
	 Method which provide the disabling of the visual selection style
	 (WARNING: Should be using inside the:
	 1. setInterface(fromObject object: BaseTableObject!);
	 2. setInterface(firstTime object: BaseTableObject!)).
	 */
	@available( *, deprecated : 1.0, message : "Use method final func customize(needSelection: Bool, needUnderline: Bool) instead")
	final func disableClickVisualization() {
		self.selectionStyle = .none;
	}

	/**
	 Method which provide the underline disabling
	 (WARNING: Should be using inside the:
	 1. setInterface(fromObject object: BaseTableObject!);
	 2. setInterface(firstTime object: BaseTableObject!)).

	 - author: Dmitriy Lernatovich
	 */
	@available( *, deprecated : 1.0, message : "Use method final func customize(needSelection: Bool, needUnderline: Bool) instead")
	final func disableUnderline() {
		self.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, self.bounds.size.width);
	}

	/**
	 Method which provide the customize of the underline for the cell and underline
	 (WARNING: Should be using inside the:
	 1. setInterface(fromObject object: BaseTableObject!);
	 2. setInterface(firstTime object: BaseTableObject!)).

	 - author: Dmitriy Lernatovich

	 - parameter needSelection: need selection visualization
	 - parameter needUnderline: need underline for cell
	 */
	final func customize(needSelection: Bool, needUnderline: Bool) {
		if (needSelection == false) {
			self.selectionStyle = .none;
		}

		if (needUnderline == false) {
			self.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, self.bounds.size.width);
		}
	}
}
