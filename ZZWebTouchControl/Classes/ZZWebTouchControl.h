//
//  ZZWebTouchControl.h
//  ZZWebViewDemo_Example
//
//  Created by pzz on 2018/10/26.
//  Copyright © 2018 zz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 ......:::::::两种webView的长按图片动作控制类:::::::......
 
 ## 类初始化使用示例：
    方式一：
    _webTouchControl = [[ZZWebTouchControl alloc] initWithWebView:_kWebView];
    方式二：
    _webTouchControl = [[ZZWebTouchControl alloc] init];
    _webTouchControl.webView = _kWebView;
 
 ## 回调：
    _webTouchControl.webViewlongPressGestureRecognizerWithUrl = ^(NSString * _Nonnull urlStr, CGRect frame) {
    NSLog(@"长按：urlStr==%@, frame==%@", urlStr, NSStringFromCGRect(frame));
    }

 @warning 注意：在使用WKWebView时，为屏蔽其自带的长按图片弹窗alert，须在在其WKNavigationDelegate代理的didFinishNavigation事件中，添加如下两句：
    （WKWebview--didFinishNavigation--禁止长按图片弹窗alert）
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];


 ## 长按图片回调示例：
    __weak typeof(self) weakSelf = self;
    _webTouchControl.webViewlongPressGestureRecognizerWithUrl = ^(NSString * _Nonnull urlStr, CGRect frame) {
        NSLog(@"长按：urlStr==%@, frame==%@", urlStr, NSStringFromCGRect(frame));
        //以url同步下载图片方式
        if(0){
            NSLog(@"image url：%@",urlStr);
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                //save image or Extract QR code
                NSString *str1 = [UIView zz_getQRCodeStrWithImage:image];
                NSLog(@"str1==%@", str1);
            }
        }
        //截图方式（推荐）
        if(1){
            //1::
            UIImage *image = [weakSelf.kWebView zz_screenShotAtFrame:frame];
            NSString *str1 = [UIView zz_getQRCodeStrWithImage:image];
            //2::
            UIImage *allimage = [weakSelf.kWebView zz_screenShotAtFrame:weakSelf.kWebView.bounds];
            NSString *str2 = [UIView zz_getQRCodeStrWithImage:allimage];
            NSLog(@"str1==%@, str2==%@", str1, str2);
        }
    };
 
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



#pragma mark - ......::::::: 辅助方法 :::::::......

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




