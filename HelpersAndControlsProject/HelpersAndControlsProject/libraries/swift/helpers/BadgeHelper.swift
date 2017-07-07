//
//  BadgeHelper.swift
//  HelpersAndControlsProject
//
//  Created by Dmitry Lernatovich on 5/24/16.
//  Copyright © 2016 ApTJIauT. All rights reserved.
//

import UIKit

class BadgeHelper: NSObject {
    
    /**
     Method which provide the setting of the badge value for the application
     
     - parameter value: value
     */
    static func set(applicationBadge value: Int) {
        self.set(badgeValue: UIApplication.shared, value: value);
    }
    
    /**
     Method which provide the clearing of the badge value
     */
    static func clear() {
        let app: UIApplication? = UIApplication.shared;
        self.set(badgeValue: app, value: 0);
        app?.cancelAllLocalNotifications();
    }
    
    /**
     Method which provide the setting of the badge number value for the application
     
     - parameter application: application
     - parameter value:       value for set
     */
    private static func set(badgeValue application: UIApplication?, value: Int) {
        application?
            .registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge],
                                                                         categories: nil));
        application?.applicationIconBadgeNumber = value;
    }
    
}
