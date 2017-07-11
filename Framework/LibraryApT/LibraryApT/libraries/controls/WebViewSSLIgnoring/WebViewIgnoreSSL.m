//
//  WebViewIgnoreSSL.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 30.04.16.
//  Copyright © 2016 Magnet. All rights reserved.
//

#import "WebViewIgnoreSSL.h"

@interface WebViewIgnoreSSL ()
#pragma mark - functional for the ignoring SSL
@property(nonatomic, strong) NSURLRequest *requestOther;
@property(nonatomic, strong) NSURLConnection *connection;
@property(nonatomic, assign) BOOL authenticated;
@end

@implementation WebViewIgnoreSSL

-(void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
}

-(void)loadSSLIgnoredUrl:(NSString *)url{
    NSURL *urlRequest = [NSURL URLWithString:url];
    self.requestOther = [NSURLRequest requestWithURL:urlRequest];
    [self loadRequest:self.requestOther];
    if(self.ignoringDelegate != nil){
        [self.ignoringDelegate onStartLoading];
    }
}

#pragma mark - UIWebView delegates
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if(self.ignoringDelegate != nil){
        [self.ignoringDelegate onEndLoading: NO];
    }
}

#pragma mark - UIWebView delegates

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType;
{
    if (!self.authenticated) {
        self.authenticated = NO;
        self.connection =
        [[NSURLConnection alloc] initWithRequest:self.requestOther delegate:self];
        [self.connection start];
        return NO;
    }
    return YES;
}

#pragma mark - NURLConnection delegate

- (void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
    if ([challenge previousFailureCount] == 0) {
        self.authenticated = YES;
        NSURLCredential *credential = [NSURLCredential
                                       credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential
             forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response;
{
    self.authenticated = YES;
    [self loadRequest:self.requestOther];
    [self.connection cancel];
}

- (BOOL)connection:(NSURLConnection *)connection
canAuthenticateAgainstProtectionSpace:
(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod
            isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if(self.ignoringDelegate != nil){
        [self.ignoringDelegate onEndLoading: YES];
    }
}

@end
