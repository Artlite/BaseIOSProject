//
//  BaseCollectionCell.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/13/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

//MARK: View

/// Class which provide the collection cell functional
open class BaseCollectionCell: UICollectionViewCell {

    /// {@link Int} value of the index
	public var index: Int! = -1;
    /// Instance of the {@link NSIndexPath}
	public var indexPath: NSIndexPath?;
    /// Instance of the {@link AdapteredCellDelegate}
	public weak var delegate: AdapteredCellDelegate?;
    /// Instance of the {@link BaseCollectionObject}
	public weak var object: BaseCollectionObject?;
    /// Instance of the {@link UITapGestureRecognizer}
	public var tap: UITapGestureRecognizer?;

    /// Method which provide the deinit functional
	deinit {
		NSLog("Cell(deinit): %@", NSStringFromClass(self.classForCoder));
		NotificationCenter.default.removeObserver(self);
	}

	/**
	 Method which provide the setting up of the interface

	 - parameter object: object for setting up
	 */
	open func setInterface(fromObject object: BaseCollectionObject!) {
		// fatalError(String(format:"internal func setInterface(fromObject object:BaseCollectionObject!) -> Should be overriden in %@", NSStringFromClass(self.classForCoder)));
	}

	/**
	 Method which provide the setting interface of the first time

	 - parameter object: object
	 */
	open func setInterface(firstTime object: BaseCollectionObject!) {
		self.setInterface(fromObject: object);
	}

	/**
	 Method which provide the give of the additional functional for the cell resizing
	 (WARNING: SHOULD BE OVERRIDEN IN CHILD CLASSES)
	 */
	override func layoutSubviews() {
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
	open func onCreateCell() {

	}

	/**
	 Method which provide to send of the event

	 - parameter event: event object
	 */
	public final func sendEvent(event: AdapteredCollectionView.AdapteredEvent!) {
		self.sendEvent(event: event, additionalObject: nil);
	}

	/**
	 Method which provide the event sending with object

	 - parameter event:            event
	 - parameter additionalObject: additional object
	 */
	public final func sendEvent(event: AdapteredCollectionView.AdapteredEvent!, additionalObject: NSObject?) {
		self.delegate?.onEventReceived(eventType: event, index: self.index, additionalObject: additionalObject);
	}

	/**
	 Method which provide the updating of the current cell
	 */
	public final func update() {
		self.delegate?.update(cellByIndexPath: self.indexPath);
	}

	/**
	 Method which provide the functional when cell awake from nib (same as onResume in Android)
	 */
	override func awakeFromNib() {
		super.awakeFromNib();
		self.subscribeForNotification();
		self.onAddDefaultClick();
		self.onCreateCell();
	}

	// MARK: On event result notification
	/**
	 Method which provide the subscribe for notifications
	 */
	private func subscribeForNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(BaseCollectionCell.onRecieveNotification(notification:)), name: AdapteredCollectionView.K_EVENT_RESULT_NOTIFICATION, object: nil);
	}

	/**
	 Method which provide the adding of the default click
	 */
	private func onAddDefaultClick() {
		if (self.tap == nil) {
			self.tap = UITapGestureRecognizer(target: self, action: #selector(BaseCollectionCell.onDefaultClick));
			self.contentView.addGestureRecognizer(self.tap!);
		}
	}

	/**
	 Method which provide the default clicking
	 WARNIG: This method can be overriding
	 */
	public func onDefaultClick() {
		let defaultEvent: AdapteredCollectionView.AdapteredEvent = AdapteredCollectionView.AdapteredEvent(eventCode: -1);
		self.sendEvent(event: defaultEvent);
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
		let event: AdapteredCollectionView.AdapteredEvent? = userInfo[AdapteredCollectionView.K_EVENT_KEY] as? AdapteredCollectionView.AdapteredEvent;
		let object: NSObject? = userInfo[AdapteredCollectionView.K_EVENT_OBJECT] as? NSObject;
		let index: Int? = userInfo[AdapteredCollectionView.K_EVENT_INDEX_KEY] as? Int;
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
	open func onResultEvent(event: AdapteredCollectionView.AdapteredEvent?, object: NSObject?) {

	}
}
