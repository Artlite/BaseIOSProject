//
//  AdapteredTableView.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/25/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

@objc public protocol AdapteredTableDelegate: class {
    
    /**
     Method which provide the action when cell send event to the collection view
     
     - parameter event:  event
     - parameter object: object
     - parameter index:  index
     */
    func onEventReceived(eventType event: AdapteredTableView.Event!, object: BaseTableObject!, index: Int, additionalObject: NSObject?);
    
    /**
     Method which provide the lazy load functional
     
     - parameter size: list size
     */
    func onAlmostAtBottom(listSize size: Int);
    
    /**
     Method which provide the refresh data functional
     */
    func onRefreshData();
    
    /**
     Method which provide the object post processing before the displaying inside the table view
     (WARNING: CONTAIN EXAMPLE HOW TO USE)
     
     - author: Dmitriy Lernatovich
     
     - parameter objects: objects for sort
     */
    /*
     HOW TO USE (SORT EXAMPLE):
     func onPostProcessing(objects: [BaseTableObject]) -> [BaseTableObject] {
     if var userObjects = objects as? [FamilyUserMessageCell.Object] {
     userObjects.sortInPlace({ (item1, item2) -> Bool in
     let name1: String? = item1.user?.nickName;
     let name2: String? = item2.user?.nickName;
     if ((name1 != nil) && (name2 != nil)) {
     if (name1!.compare(name2!) == NSComparisonResult.OrderedAscending) {
     return true;
     }
     }
     return false;
     })
     return userObjects;
     }
     return objects;
     }
     */
    @objc optional func onPostProcessing(objects: [BaseTableObject]) -> [BaseTableObject];
}

public protocol AdapteredTableCellDelegate: class {
    /**
     Method which provide the action when cell send event to the collection view
     
     - parameter event: event
     - parameter index: index
     */
    func onEventReceived(eventType event: AdapteredTableView.Event!, index: Int!, additionalObject: NSObject?);
    
    /**
     Method which provide the updating cell by index
     
     - parameter index: index
     */
    func update(cellByIndexPath index: NSIndexPath?);
}

public class AdapteredTableView: UIView, UITableViewDelegate, UITableViewDataSource, AdapteredTableCellDelegate {
    
    // Refresh control
    @IBInspectable var needRefreshControl: Bool = false {
        didSet {
            if (self.needRefreshControl == true) {
                self.onAddRefreshControl();
            }
        }
    }
    
    @IBInspectable var refreshColor: UIColor = UIColor.black {
        didSet {
            self.onSetUpRefreshControl();
        }
    }
    
    @IBInspectable var needVerticalScrollIndicator: Bool = true {
        didSet {
            self.tableView.showsVerticalScrollIndicator = needVerticalScrollIndicator;
        }
    }
    
    @IBInspectable var needVerticalBounce: Bool = true {
        didSet {
            self.tableView.alwaysBounceVertical = needVerticalBounce;
        }
    }
    
    @IBInspectable var backgroundTextFont: CGFloat = 17 {
        didSet {
            self.labelBackgroundText.font = UIFont.systemFont(ofSize: backgroundTextFont);
        }
    }
    
    @IBInspectable var backgroundTextColor: UIColor = UIColor.white {
        didSet {
            self.labelBackgroundText.textColor = self.backgroundTextColor;
        }
    }
    
    @IBInspectable var allowSelection: Bool = true {
        didSet {
            self.setSelectionStyle();
        }
    }
    
    @IBInspectable var allowMultipleSelection: Bool = false {
        didSet {
            self.setSelectionStyle();
        }
    }
    
    @IBInspectable var needEmptyCellLines: Bool = true {
        didSet {
            if (self.needEmptyCellLines == false) {
                self.tableView.tableFooterView = UITableView(frame: CGRect.zero);
            }
        }
    }
    
    @IBInspectable var needSeparator: Bool = true {
        didSet {
            if (self.needSeparator == false) {
                self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
            } else {
                self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine;
            }
        }
    }
    
    @IBInspectable var selectionColor: UIColor = UIColor.clear;
    
    @IBInspectable var cellsPadding: CGFloat = 0;
    
    public static let K_EVENT_RESULT_NOTIFICATION: Notification.Name! = Notification.Name(rawValue: "K_EVENT_RESULT_NOTIFICATION_ADAPTERED_TABLE_CELL");
    public static let K_EVENT_KEY: String! = "K_EVENT_KEY";
    public static let K_EVENT_INDEX_KEY: String! = "K_EVENT_INDEX_KEY";
    public static let K_EVENT_OBJECT: String! = "K_EVENT_OBJECT";
    public static let K_CELL_PRESSED_EVENT: Event! = Event(eventCode: -100);
    
    static let K_EMPTY_CELL: String! = "EmptyTableCell";
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelBackgroundText: UILabel!
    
    private var lastRegIdentifier: String! = "";
    
    public var objects: NSMutableArray = NSMutableArray();
    public var listSizeOld: Int! = -1;
    public var delegate: AdapteredTableDelegate?;
    
    // Selection functional
    private(set) var previousIndex: NSIndexPath?;
    private(set) var previousIndexes: [NSIndexPath] = [];
    
    // MARK: Refresh functional
    private var refreshControl: UIRefreshControl?;
    
    /**
     Constructor which provide the initialization from frame
     
     - parameter frame: frame
     */
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.onViewInitialize();
        self.onCreateView();
    }
    
    /**
     Constructor which provide the initialization from coder
     
     - parameter aDecoder: coder
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.onViewInitialize();
        self.onCreateView();
    }
    
    /**
     Method which provide the view initializations
     */
    private func onViewInitialize() {
        let view: UIView! = Bundle.main.loadNibNamed("AdapteredTableView",
                                                     owner: self,
                                                     options: nil)![0] as! UIView;
        view.frame = self.bounds;
        self.addSubview(view);
    }
    
    /**
     Method which provide the actions when View is created
     */
    func onCreateView() {
        self.registerCellsNib();
        self.registerDefaultCell();
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 160.0;
    }
    
    // MARK: Table view delegates
    
    /**
     Method which provide the count for the numbers of sections
     
     - parameter tableView: table view
     
     - returns: sections value
     */
    public func numberOfSections(in tableView: UITableView) -> Int {
        return objects.count;
    }
    
    /**
     Method which provide the cound of the number of rows in sections
     
     - parameter tableView: table view
     - parameter section:   section
     
     - returns: count value
     */
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    /**
     Method which provide the generating of the cell for object
     
     - parameter tableView: table view
     - parameter indexPath: index
     
     - returns: cell
     */
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let emptyCell: UITableViewCell = self.get(emptyCell: tableView, cellForRowAtIndexPath: indexPath as NSIndexPath);
        // Check indexes
        guard (self.objects.count > indexPath.section) else {
            return emptyCell;
        }
        
        let object: BaseTableObject? = self.objects.object(at: indexPath.section) as? BaseTableObject;
        let identifier: String? = object?.getReuseIdentifier();
        
        if (identifier == nil) {
            return emptyCell;
        }
        
        let cell: BaseTableViewCell? = self.tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath as IndexPath) as? BaseTableViewCell;
        
        if (cell == nil) {
            return emptyCell;
        }
        
        cell!.index = indexPath.section;
        cell!.indexPath = indexPath as NSIndexPath;
        object!.index = indexPath as NSIndexPath;
        
        // Set weak references
        cell!.object = object;
        object!.cell = cell;
        
        if (self.allowSelection == false) {
            cell!.selectionStyle = .none;
        } else {
            cell!.selectionStyle = .default;
        }
        
        // Set deleaget
        if (cell!.delegate == nil) {
            cell!.delegate = self;
        }
        
        // Set up interface
        if (object!.isFirstInit == false) {
            cell!.setInterface(firstTime: object);
            object!.isFirstInit = true;
        } else {
            cell!.setInterface(fromObject: object);
        }
        
        // Set selection collor
        let selectionView: UIView = UIView();
        selectionView.backgroundColor = self.selectionColor;
        cell?.selectedBackgroundView = selectionView;
        
        // Layout if needed
        cell!.layoutIfNeeded();
        self.checkForLazyLoad(index: indexPath.section);
        return cell!;
    }
    
    /**
     Method which provide the calculating table view cell heigh
     
     - parameter tableView: table view
     - parameter indexPath: index
     
     - returns: heigh
     */
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    /**
     Method which provide calculating for header
     
     - parameter tableView: table view
     - parameter section:   section
     
     - returns: heigh
     */
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var padding: CGFloat = self.cellsPadding;
        
        // Guard statement
        guard (section < self.objects.count) else {
            return padding;
        }
        
        if let object = self.objects.object(at: section) as? BaseTableObject {
            if (object.getHeaderHeigh() != -1) {
                padding = object.getHeaderHeigh();
            }
        }
        return padding;
    }
    
    /**
     Method which provide the getting header text for the cell
     
     - parameter tableView: table view
     - parameter section:   section
     
     - returns: text value
     */
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String? = nil;
        
        // Guard statement
        guard (section < self.objects.count) else {
            return title;
        }
        
        if let object = self.objects.object(at: section) as? BaseTableObject {
            if (StringHelper.isEmpty(object.getHeaderText()) == false) {
                title = object.getHeaderText();
            }
        }
        return title;
    }
    
    /**
     Method which provide the getting header view
     
     - parameter tableView: table view
     - parameter section:   section
     
     - returns: header view
     */
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header: UIView? = nil;
        
        // Guard statement
        guard (section < self.objects.count) else {
            return header;
        }
        
        if let object = self.objects.object(at: section) as? BaseTableObject {
            var heigh: CGFloat = object.getHeaderHeigh();
            
            if (heigh == -1) {
                heigh = self.cellsPadding;
            }
            
            if let view = object.getHeaderView(heigh: heigh) {
                header = view;
            }
        }
        return header;
    }
    
    /**
     Method which provide the action performing for the cell pressed
     
     - parameter tableView: table view
     - parameter indexPath: index
     */
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object: BaseTableObject? = self.getObject(byIndex: indexPath.section);
        if (object != nil) {
            object?.isSelected = true;
            self.delegate?.onEventReceived(eventType: AdapteredTableView.K_CELL_PRESSED_EVENT, object: object!, index: indexPath.section, additionalObject: nil);
        }
        
        // Selection indexes
        if (self.allowMultipleSelection == false) {
            self.previousIndex = indexPath as NSIndexPath;
        } else {
            self.previousIndex = self.previousIndexes.first;
            self.previousIndexes.append(indexPath as NSIndexPath);
        }
        
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath;
    }
    
    /**
     Method which provide the indexes deselection
     
     - parameter tableView: table view
     - parameter indexPath: index path
     */
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.previousIndexes.removeObject(object: indexPath as NSIndexPath);
    }
    
    // MARK: Cell actions
    
    /**
     Method which provide the getting of the actions for the table view
     
     - parameter tableView: tbale view
     - parameter indexPath: index path
     
     - returns: actions
     */
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let object: BaseTableObject? = self.getObject(byIndex: indexPath.section);
        if (object != nil) {
            let cell: BaseTableViewCell? = self.tableView.dequeueReusableCell(withIdentifier: object!.getReuseIdentifier(), for: indexPath as IndexPath) as? BaseTableViewCell;
            if let actions = cell?.getCellActions(object: object, indexPath: indexPath as NSIndexPath, delegate: self){
                if (actions.count > 0) {
                    return actions;
                }
            }
        }
        return [];
    }
    
    /**
     Method which provide the defining of the current cell will be able to edit
     
     - parameter tableView: table view
     - parameter indexPath: index path
     
     - returns: definition
     */
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let object: BaseTableObject? = self.getObject(byIndex: indexPath.section);
        if (object != nil) {
            let cell: BaseTableViewCell? = self.tableView.dequeueReusableCell(withIdentifier: object!.getReuseIdentifier(), for: indexPath as IndexPath) as? BaseTableViewCell;
            let canActions: Bool? = cell?.canEditCell(object: object);
            if (canActions == true) {
                return true;
            } else {
                return false;
            }
        }
        return false;
    }
    
    /**
     Method which provide the registering nib inside the collection view
     */
    public func registerCellsNib() {
        for object in self.objects {
            let identifier: String = (object as AnyObject).getReuseIdentifier();
            let nib = UINib.init(nibName: identifier, bundle: Bundle(for: AdapteredTableView.self));
            self.tableView.register(nib, forCellReuseIdentifier: identifier);
        }
    }
    
    // MARK: Lazy load
    /**
     Method which provide the checking if need lazy load callback
     
     - parameter index: index for object
     */
    public func checkForLazyLoad(index: Int!) {
        let listItemSize: Int! = self.objects.count;
        if ((index == listItemSize - 1)
            && (listItemSize > self.listSizeOld)) {
            self.delegate?.onAlmostAtBottom(listSize: listItemSize);
            self.listSizeOld = listItemSize;
        }
    }
    
    // MARK: Cell delegate
    
    /**
     Method which provide the action when cell send event to the collection view
     
     - parameter event: event
     - parameter index: index
     */
    public func onEventReceived(eventType event: AdapteredTableView.Event!, index: Int!, additionalObject: NSObject?) {
        let object = self.getObject(byIndex: index);
        if (object != nil) {
            self.delegate?.onEventReceived(eventType: event, object: object!, index: index, additionalObject: additionalObject);
        }
    }
    
    /**
     Method which provide the cell updating by index path
     
     - parameter index: index
     */
    public func update(cellByIndexPath index: NSIndexPath?) {
        if (index != nil) {
            self.tableView.beginUpdates();
            self.tableView.reloadRows(at: [index! as IndexPath], with: .automatic);
            self.tableView.endUpdates();
        }
    }
    
    /**
     Method which provide the cell updating by index path
     
     - parameter index: index
     */
    public func update(cellByIndex index: Int) {
        
        // Guard statement
        guard (self.objects.count > index) else {
            return;
        }
        
        let object: BaseTableObject? = self.objects.object(at: index) as? BaseTableObject;
        let indexPath: NSIndexPath? = object?.index;
        self.update(cellByIndexPath: indexPath);
    }
    
    // MARK: Refresh control
    
    // MARK: Refresh control
    /**
     Method which provide the addin gof the refresh control
     */
    public func onAddRefreshControl() {
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.addTarget(self, action: #selector(AdapteredTableView.onRefresh), for: .valueChanged);
        self.tableView.addSubview(self.refreshControl!);
        self.onSetUpRefreshControl();
    }
    
    /**
     Method which provide the setting up of the refresh control
     */
    public func onSetUpRefreshControl() {
        self.refreshControl?.tintColor = self.refreshColor;
    }
    
    /**
     Method which provide the executing of the refresh funcional
     */
    public func onRefresh() {
        self.delegate?.onRefreshData();
    }
    
    /**
     Method which provide the hiding of the refresh control
     */
    public func hideRefreshControl() {
        if (self.refreshControl != nil) {
            if (self.refreshControl?.isRefreshing == true) {
                DispatchQueue.main.async(execute: {
                    self.refreshControl?.endRefreshing();
                });
            }
        }
    }
    
    /**
     Method which provide the hiding of the refresh control
     */
    public func showRefreshControl() {
        if (self.refreshControl != nil) {
            if (self.refreshControl?.isRefreshing == false) {
                DispatchQueue.main.async(execute: {
                    self.refreshControl?.beginRefreshing();
                });
            }
        }
    }
    
    /**
     Method which provide the setting of the selection style
     */
    public func setSelectionStyle() {
        if (self.allowSelection == true) {
            self.tableView.allowsSelection = self.allowSelection;
            self.tableView.allowsMultipleSelection = self.allowMultipleSelection;
        } else {
            self.tableView.allowsSelection = false;
            self.tableView.allowsMultipleSelection = false;
        }
    }
    
    // MARK: Previous selection
    /**
     Method which provide the clearing of the selection index
     */
    public final func clearSelectionIndex() {
        self.previousIndex = nil;
    }
    
    /**
     Method which provide the clearing of the selection indexes
     */
    public final func clearSelectionIndexes() {
        self.previousIndexes.removeAll();
    }
    
    /**
     Method which provide the remove indexes
     
     - parameter indexPath: index path
     */
    public final func remove(indexPath: NSIndexPath?) {
        self.previousIndexes.removeObject(object: indexPath);
    }
    
}
