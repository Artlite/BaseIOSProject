//
//  AdapteredCollectionView+Events.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 26.04.16.
//  Copyright © 2016 Magnet. All rights reserved.
//
import UIKit

// MARK: - Extension which provide the Event functional for Adaptered Collection View
public extension AdapteredCollectionView {
    
    /**
     Method which provide the sending of the event results
     
     - parameter event:  event object
     - parameter object: result object
     */
    public final func sendEventResults(event: AdapteredCollectionView.AdapteredEvent?, object: NSObject?, intdex: Int) {
        var dict: Dictionary<String, AnyObject> = [:];
        dict[AdapteredTableView.K_EVENT_INDEX_KEY] = intdex as AnyObject;
        if (event != nil) {
            dict[AdapteredCollectionView.K_EVENT_KEY] = event!;
        }
        if (object != nil) {
            dict[AdapteredCollectionView.K_EVENT_OBJECT] = object!;
        }
        NotificationCenter.default.post(name: AdapteredCollectionView.K_EVENT_RESULT_NOTIFICATION, object: nil, userInfo: dict);
    }
    
}
