//
//  WebViewIgnoreSSL.h
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 30.04.16.
//  Copyright © 2016 Magnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol IgnoringWebDelegate <NSObject>

-(void) onStartLoading;
-(void) onEndLoading: (BOOL) success;

@end

@interface WebViewIgnoreSSL : UIWebView<UIWebViewDelegate, NSURLConnectionDataDelegate>
@property(nonatomic, assign) id<IgnoringWebDelegate> ignoringDelegate;
-(void) loadSSLIgnoredUrl: (NSString *) url;
@end
