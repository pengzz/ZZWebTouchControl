//
//  ZZWebTouchControl.h
//  ZZWebViewDemo_Example
//
//  Created by PengZhiZhong on 2018/10/26.
//  Copyright © 2018 pengzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 两种webView的长按图片动作控制

 *使用示例：
 * __weak typeof(self) this = self;
 * _webTouchControl = [[ZZWebTouchControl alloc] initWithWebView:_kWebView];
 
 *或者：
 * _webTouchControl = [[ZZWebTouchControl alloc] init];
 * _webTouchControl.webView = _kWebView;
 
 *回调：
 * _webTouchControl.webViewlongPressGestureRecognizerWithUrl = ^(NSString * _Nonnull urlStr, CGRect frame) {
 *     NSLog(@"长按：urlStr==%@, frame==%@", urlStr, NSStringFromCGRect(frame));
 * }

 */
@interface ZZWebTouchControl : NSObject

/**
 初始化方法

 @param webView 传入的UIWebView或WkWebView
 @return 返回当前类的实例对象
 */
//- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithWebView:(__kindof UIView *_Nullable)webView NS_DESIGNATED_INITIALIZER;

/**
 待处理的：UIWebView或WKWebView
 */
@property (nonatomic, strong, readwrite) __kindof UIView *_Nonnull webView;

/**
 单击webView
 */
@property(nonatomic, copy) void (^webViewTapGestureRecognizer)(void);

/**
 长按WebView中图片
 */
@property(nonatomic, copy) void (^webViewlongPressGestureRecognizerWithUrl)(NSString * _Nonnull urlStr, CGRect frame);

@end


#pragma mark - 辅助方法 =========================================

@interface UIView (ZZScreenShots)

/**
 屏幕截图

 @return 截图图片对象
 */
- (UIImage *)zz_screenShot;

/**
 获取指定区域的屏幕截图

 @param frame 指定区域
 @return 截图图片对象
 */
- (UIImage *)zz_screenShotAtFrame:(CGRect)frame;

/**
 识别图片中二维码
 
 @param image 传入的要识别的图片对象
 @return 返回识别出的二维码字串
 */
+ (NSString*)zz_getQRCodeStrWithImage:(UIImage*)image;

@end

NS_ASSUME_NONNULL_END




