//
//  NotificationsHelper.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 20.04.16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

class NotificationsHelper: NSObject {
    /**
     Method which provide the registration for notification
     
     - parameter selector:         selector
     - parameter notificationType: notification type
     */
    internal static func registerForNotification(owner:NSObject?,
                                                 selector:Selector?,
                                                 notificationType:NSNotification.Name?){
        if((owner == nil) || (selector == nil) || (notificationType == nil)){
            return;
        }
        NotificationCenter.default.addObserver(owner!,
                                               selector: selector!,
                                               name: notificationType!,
                                               object: nil);
    }
    
    /**
     Method which provide the notification sending
     
     - parameter notificationType: notification type
     */
    internal static func sendNotification(notification notificationType:NSNotification.Name?){
        if let notificationType = notificationType {
            NotificationCenter.default.post(name: notificationType, object: nil);
        }
    }
    
    /**
     Method which provide the remove owner form the notification center
     
     - parameter owner: owner object
     */
    internal static func removeFromNotifications(owner:NSObject?){
        if let owner = owner{
            NotificationCenter.default.removeObserver(owner);
        }
    }
    
}
