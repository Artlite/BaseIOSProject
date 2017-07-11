//
//  SwipeHelper.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/18/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

public class GetsureHelper: NSObject {
    
    /**
     Method which provide to add of the swipe to the UIView
     
     - parameter view:      UIView object
     - parameter direction: direction example .Right .Left
     - parameter selector:  selector example: #selector(showMenu)
     
     - returns: getsure direction
     */
    @discardableResult
    public static func addSwipe(target owner:NSObject?, view:UIView?, direction:UISwipeGestureRecognizerDirection?, selector:Selector?) -> UISwipeGestureRecognizer?{
        if((view == nil) || (direction == nil) || (selector == nil) || (owner == nil)){
            return nil;
        }
        let swipe = UISwipeGestureRecognizer(target: owner, action: selector!);
        swipe.direction = direction!;
        view!.addGestureRecognizer(swipe);
        return swipe;
    }
    
    /**
     Method which provide to add of the border swipe to the UIView
     
     - parameter view:      UIView object
     - parameter direction: direction example .Right .Left
     - parameter selector:  selector example: #selector(showMenu)
     
     - returns: getsure direction
     */
    @discardableResult
    public static func addBorderSwipe(target owner:NSObject?, view:UIView?, direction:UIRectEdge?, selector:Selector?) -> UIScreenEdgePanGestureRecognizer?{
        if((view == nil) || (direction == nil) || (selector == nil) || (owner == nil)){
            return nil;
        }
        let swipe = UIScreenEdgePanGestureRecognizer(target: owner, action: selector!);
        swipe.edges = direction!;
        view!.addGestureRecognizer(swipe);
        return swipe;
    }
    
    /**
     Method which provide to add of the border swipe to the UIView
     
     - parameter view:      UIView object
     - parameter direction: direction example .Right .Left
     - parameter selector:  selector example: #selector(showMenu)
     
     - returns: getsure direction
     */
    @discardableResult
    public static func addClick(target owner:NSObject?, view:UIView?, selector:Selector?) -> UITapGestureRecognizer?{
        if((view == nil) || (selector == nil) || (owner == nil)){
            return nil;
        }
        let tap = UITapGestureRecognizer(target: owner, action: selector!);
        view!.addGestureRecognizer(tap);
        return tap;
    }


}
