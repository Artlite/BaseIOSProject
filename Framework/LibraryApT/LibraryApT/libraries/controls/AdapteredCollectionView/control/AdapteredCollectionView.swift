//
//  AdapteredCollectionView.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/13/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

public protocol AdapteredCollectionDelegate: class {
    /**
     Method which provide the action when cell send event to the collection view
     
     - parameter event:  event
     - parameter object: object
     - parameter index:  index
     */
    func onEventReceived(eventType event: AdapteredCollectionView.AdapteredEvent!, object: BaseCollectionObject!, index: Int, additionalObject: NSObject?);
    
    /**
     Method which provide the refresh data functional
     */
    func onRefreshData();
    /**
     Method which provide the lazy load functional
     
     - parameter size: list size
     */
    func onAlmostAtBottom(listSize size: Int);
}

public protocol AdapteredCellDelegate: class {
    /**
     Method which provide the action when cell send event to the collection view
     
     - parameter event: event
     - parameter index: index
     */
    func onEventReceived(eventType event: AdapteredCollectionView.AdapteredEvent!, index: Int!, additionalObject: NSObject?);
    
    /**
     Method which provide the cell updating by index path
     
     - parameter index: index
     */
    func update(cellByIndexPath index: NSIndexPath?);
}

//@IBDesignable
public class AdapteredCollectionView: UIView,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
AdapteredCellDelegate {
    
    public static let K_EVENT_RESULT_NOTIFICATION: Notification.Name! = Notification.Name(rawValue: "K_EVENT_RESULT_NOTIFICATION_ADAPTERED_COLLECTION_CELL");
    public static let K_EVENT_KEY: String! =  "K_EVENT_KEY";
    public static let K_EVENT_OBJECT: String! = "K_EVENT_OBJECT";
    public static let K_EVENT_INDEX_KEY: String! = "K_EVENT_INDEX_KEY";
    
    private var lastRegIdentifier: String! = "";
    
    @IBOutlet weak var collectionView: DynamicCollectionView!
    @IBOutlet weak var labelBackgroundText: UILabel!
    
    // MARK: Inspectable
    @IBInspectable var bounces: Bool = true {
        didSet {
            self.collectionView.bounces = self.bounces;
        }
    }
    @IBInspectable var alwaysBounceVertical: Bool = true {
        didSet {
            self.collectionView.alwaysBounceVertical = self.alwaysBounceVertical;
        }
    }
    @IBInspectable var showsVerticalScrollIndicator: Bool = true {
        didSet {
            self.collectionView.showsVerticalScrollIndicator = showsVerticalScrollIndicator;
        }
    }
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
    
    @IBInspectable var verticalSpace: CGFloat = 0.0 {
        didSet {
            
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
    
    public var objects: NSMutableArray = NSMutableArray();
    public weak var adapteredDelegate: AdapteredCollectionDelegate?;
    public var listSizeOld: Int! = -1;
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
        let view: UIView! = Bundle.main.loadNibNamed("AdapteredCollectionView",
                                                     owner: self,
                                                     options: nil)![0] as! UIView;
        view.frame = self.bounds;
        self.addSubview(view);
    }
    
    /**
     Method which provide the actions when View is created
     */
    private func onCreateView() {
        self.registerCellsNib();
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
    }
    
    // MARK: Refresh control
    /**
     Method which provide the addin gof the refresh control
     */
    private func onAddRefreshControl() {
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.addTarget(self, action: #selector(AdapteredCollectionView.onRefresh), for: .valueChanged);
        self.collectionView.addSubview(self.refreshControl!);
        self.onSetUpRefreshControl();
    }
    
    /**
     Method which provide the setting up of the refresh control
     */
    private func onSetUpRefreshControl() {
        self.refreshControl?.tintColor = self.refreshColor;
    }
    
    /**
     Method which provide the executing of the refresh funcional
     */
    public func onRefresh() {
        self.adapteredDelegate?.onRefreshData();
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
    
    // MARK: Collection view delegates
    
    /// Method which provide the number of sections in the collection view
    ///
    /// - Parameter collectionView: {@link UICollectionView} instance
    /// - Returns: count value
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    /// Method which provide the number of items in sections in the collection view
    ///
    /// - Parameters:
    ///   - collectionView: {@link UICollectionView} instance
    ///   - section: {@link Int} value of the section index
    /// - Returns: count value
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objects.count;
    }
    
    /// Method which provide the create of the cell for the collection view
    ///
    /// - Parameters:
    ///   - collectionView: {@link UICollectionView} instance
    ///   - indexPath: {@link Int} value of the index
    /// - Returns: {@link UICollectionViewCell} instance
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: BaseCollectionCell! = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.lastRegIdentifier, for: indexPath as IndexPath) as! BaseCollectionCell;
        
        if self.objects.count == 0 {
            return cell
        }
        
        let object: BaseCollectionObject! = self.objects[indexPath.item] as! BaseCollectionObject;
        
        cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: object.getReuseIdentifier(), for: indexPath as IndexPath) as! BaseCollectionCell;
        
        cell.index = indexPath.item;
        cell.indexPath = indexPath as NSIndexPath;
        object.index = indexPath as NSIndexPath;
        // Set deleaget
        if (cell.delegate == nil) {
            cell.delegate = self;
        }
        // Set weak references
        cell.object = object;
        object.cell = cell;
        
        // Set up interface
        if (object.isFirstInit == false) {
            cell.setInterface(firstTime: object);
            object.isFirstInit = true;
        } else {
            cell.setInterface(fromObject: object);
        }
        
        // Layout if needed
        cell.layoutIfNeeded();
        self.checkForLazyLoad(index: indexPath.item);
        return cell;
    }
    
    /// Method which provide the define size for the item inside the collection view
    ///
    /// - Parameters:
    ///   - sizeForItemAtcollectionView: {@link UICollectionView} instance
    ///   - collectionViewLayout: {@link UICollectionViewLayout} instance
    ///   - indexPath: {@link Int} value of the index
    /// - Returns: instance of the {@link CGSize}
    public func collectionView(_ sizeForItemAtcollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat! = self.collectionView.bounds.width;
        let object: BaseCollectionObject! = self.objects[indexPath.row] as! BaseCollectionObject;
        let cell: BaseCollectionCell? = self.collectionView.dequeueReusableOffScreenCellWithReuseIdentifier(identifier: object.getReuseIdentifier()) as? BaseCollectionCell
        
        if (cell == nil) {
            //			return CGSizeMake(width, 0.0);
            return CGSize(width: 0, height: 0);
        }
        
        if (object.heigh == -1) {
            if (object.isFirstInit == true) {
                cell!.setInterface(firstTime: object);
            } else {
                cell!.setInterface(fromObject: object);
            }
            //			cell!.bounds = CGRectMake(0, 0, width, cell!.bounds.height);
            cell!.bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: cell!.bounds.height));
            cell!.contentView.bounds = cell!.bounds;
            // Layout subviews, this will let labels on this cell to set preferredMaxLayoutWidth
            cell!.setNeedsLayout();
            cell!.layoutIfNeeded();
            
            let size = cell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize);
            object.heigh = size.height;
        }
        
        let heigh: CGFloat! = object.heigh;
        //return CGSizeMake(width, heigh);
        return CGSize(width: width, height: heigh);
    }
    
    /**
     Method which provide the registering nib inside the collection view
     */
    public func registerCellsNib() {
        for object in self.objects {
            self.lastRegIdentifier = (object as AnyObject).getReuseIdentifier();
            //			let nib = UINib.init(nibName: self.lastRegIdentifier, bundle: Bundle(forClass: AdapteredCollectionView.self));
            let nib = UINib.init(nibName: self.lastRegIdentifier, bundle: Bundle(for: AdapteredCollectionView.self));
//            self.collectionView.register(nib: nib, forCellWithReuseIdentifier: self.lastRegIdentifier);
            self.collectionView.register(nib, forCellWithReuseIdentifier: self.lastRegIdentifier);
        }
    }
    
    // MARK: Adaptered cell delegate
    /**
     Method which provide the action when cell send event to the collection view
     
     - parameter event: event
     - parameter index: index
     */
    public func onEventReceived(eventType event: AdapteredCollectionView.AdapteredEvent!, index: Int!, additionalObject: NSObject?) {
        let object: BaseCollectionObject? = self.objects[index] as? BaseCollectionObject;
        if (object != nil) {
            self.adapteredDelegate?.onEventReceived(eventType: event, object: object!, index: index, additionalObject: additionalObject);
        }
    }
    
    /**
     Method which provide the cell updating by index path
     
     - parameter index: index
     */
    public func update(cellByIndexPath index: NSIndexPath?) {
        if (index != nil) {
            self.collectionView.reloadItems(at: [index! as IndexPath]);
        }
    }
    
    /**
     Method which provide the cell updating by index path
     
     - parameter index: index
     */
    public func update(cellByIndex index: Int) {
        let object: BaseCollectionObject? = self.objects.object(at: index) as? BaseCollectionObject;
        let indexPath: NSIndexPath? = object?.index;
        self.update(cellByIndexPath: indexPath);
    }
    
    // MARK: Lazy load
    /**
     Method which provide the checking if need lazy load callback
     
     - parameter index: index for object
     */
    private func checkForLazyLoad(index: Int!) {
        let listItemSize: Int! = self.objects.count;
        if ((index == listItemSize - 1)
            && (listItemSize > self.listSizeOld)) {
            self.adapteredDelegate?.onAlmostAtBottom(listSize: listItemSize);
            self.listSizeOld = listItemSize;
        }
    }
    
    // MARK: Event class
    
    public class AdapteredEvent: NSObject {
        
        public var eventCode: Int! = nil;
        /**
         Constructor which provide the class creating with the event code
         
         - parameter eventCode: event code
         
         - returns: self object
         */
        init(eventCode: Int!) {
            super.init();
            self.eventCode = eventCode;
        }
        
        /**
         Method which provide to getting of the event code
         
         - returns: event code
         */
        public func getEventCode() -> Int! {
            return self.eventCode;
        }
        
        /// Method which provide the objects equaling
        ///
        /// - Parameter object: {@link Any} object of the description
        /// - Returns: equaling result
        override public func isEqual(_ object: Any?) -> Bool {
            let eventObject: AdapteredEvent? = object as? AdapteredEvent;
            if (eventObject != nil) {
                if (eventObject?.getEventCode() == self.eventCode) {
                    return true;
                }
            }
            return false;
        }
    }
}
