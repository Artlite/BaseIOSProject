//
//  EmailHelper.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 11/15/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "EmailHelper.h"

@implementation EmailHelper

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide the sending of the email using the default email client
 *
 *  @param email recepient email
 */
+ (void)sendEmail:(NSString *)email {
    [EmailHelper sendEmailTo:email subject:@"" body:@""];
}

+ (void)sendEmailTo:(NSString*)email subject:(NSString*)subject body:(NSString*)body
{
    NSString *URLEMail =
    [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", email,subject,body];
    NSString *url =
    [URLEMail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
