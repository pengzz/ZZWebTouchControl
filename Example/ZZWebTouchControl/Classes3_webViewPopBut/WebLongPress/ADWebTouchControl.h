//
//  ADWebTouchControl.h
//  DZWebViewTouch
//
//  Created by Chen Andy on 15/7/23.
//  Copyright (c) 2015年 Andy Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLDContextSheet.h"
//X#import "iBWKWebView.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
//#import "Masonry.h"

@interface ADWebTouchControl : NSObject
@property(nonatomic, weak)UIWebView *webView;
//X@property(nonatomic, weak)iBWKWebView *wkWebView;
@property(nonatomic, weak)WKWebView *wkWebView;
- (id)initWithWebView:(UIWebView *)webView completionBlock:(void(^)(NSDictionary *rs))completionBlock;//只适用于ios8UIWebview
- (id)initWithWebView:(UIWebView *)webView orWKWebVIew:(WKWebView *)wkWebView completionBlock:(void(^)(NSDictionary *rs))completionBlock;
@end
