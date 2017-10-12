//
//  ThreadHelper.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/8/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

public class ThreadHelper: NSObject {
    
    public typealias OnThreadPerformer = () -> Void;
    
    /**
     Method which provide the action on the main thread
     
     - parameter action: action
     */
    public static func runOnMain(action:OnThreadPerformer!){
        DispatchQueue.main.async(execute: {
            action();
        });
    }
    
    /**
     Method which provide the action on the main thread after delay
     
     - parameter action: action
     */
    public static func runOnMain(afterDelay delay:Double!, action:OnThreadPerformer!){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            action();
        }
    }
    
    /**
     Method which provide the action on the background
     
     - parameter action: action
     */
    public static func runOnBackground(action:OnThreadPerformer!){
        DispatchQueue.global().async {
            action();
        }
    }
    
    /**
     Method which provide the action on the background after delay
     
     - parameter action: action
     */
    public static func runOnBackground(afterDelay delay:Double!, action:OnThreadPerformer!){
        DispatchQueue.global().asyncAfter(deadline: .now() + delay) { 
            action();
        }
    }
    
    
}
