//
//  Array+Removing.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/18/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import Foundation
// Swift 2 Array Extension
public extension Array where Element: Equatable {
    
    mutating public func removeObject(object: Element?) {
        if(object == nil){
            return;
        }
        
        if let index = self.index(of: object!) {
            self.remove(at: index)
        }
    }
    
    mutating public func removeObjectsInArray(array: [Element]?) {
        if(array == nil){
            return;
        }
        
        for object in array! {
            self.removeObject(object: object)
        }
    }
    
    public func removeDuplicates() -> [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}
