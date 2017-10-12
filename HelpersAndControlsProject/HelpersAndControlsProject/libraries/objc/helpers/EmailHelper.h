//
//  EmailHelper.h
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 11/15/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EmailHelper : NSObject

+ (void)sendEmail:(NSString *)email;
+ (void)sendEmailTo:(NSString*)email subject:(NSString*)subject body:(NSString*)body;

@end
