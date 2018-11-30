//
//  ZZViewController.m
//  ZZWebViewDemo
//
//  Created by pengzz on 10/25/2018.
//  Copyright (c) 2018 pengzz. All rights reserved.
//

#import "ZZViewController.h"
#import <WebKit/WebKit.h>
#import "ZZWebTouchControl.h"

#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;

@interface ZZViewController ()
@property(nonatomic, strong)WKWebView *kWebView;
@property(nonatomic, strong)ZZWebTouchControl *webTouchControl;
@end

@implementation ZZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    if(0){
//        MWebView *webView = [[MWebView alloc]
//                             initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
//                             andRequestUrlString:@"https://www.jianshu.com"
//                             ];
//        [self.view addSubview:webView];
//        webView.delegate = self;
//        [webView startLoadData];
//    }
    
    {
        //## 初始化_kWebView
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *controller = [[WKUserContentController alloc] init];
        [controller addScriptMessageHandler:(id<WKScriptMessageHandler>)self name:@"web_observe"];
        configuration.userContentController = controller;
        //
        self.kWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        _kWebView.allowsBackForwardNavigationGestures = YES;
        _kWebView.navigationDelegate = (id<WKNavigationDelegate>)self;
        _kWebView.UIDelegate = (id<WKUIDelegate>)self;
        _kWebView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        //
        _kWebView.frame = self.view.bounds;
        [self.view addSubview:_kWebView];
        
        
        //## 初始化TouchControl
        //_webTouchControl = [[ZZWebTouchControl alloc] initWithWebView:_kWebView];
        _webTouchControl = [[ZZWebTouchControl alloc] init];
        _webTouchControl.webView = _kWebView;
        
        //## 长按图片回调：
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
        
        
        //## 加载网址：
        //NSString *urlStr = @"https://www.jianshu.com";
        //NSString *urlStr = @"https://www.cnblogs.com/daipianpian/p/6421843.html";
        NSString *urlStr = @"https://blog.csdn.net/iplaycoder/article/details/47609885?utm_source=blogxgwz1";
        //NSString *urlStr = @"www.baidu.com";
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]
                                                 cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                             timeoutInterval:20*3
                                 ];
        [_kWebView loadRequest:request];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    //NSLog(@"网页加载结束");
    //WKWebview--didFinishNavigation--禁止长按图片弹窗alert
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    
    //其它：
//    if (self.delegate && [self.delegate respondsToSelector:@selector(mWebViewDidFinishMWebView:)]) {
//        [self.delegate mWebViewDidFinishMWebView:self];
//    }
//    CGFloat height = webView.scrollView.contentSize.height;
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (self.delegate && [self.delegate respondsToSelector:@selector(mWebViewHeightChange:andMWebView:)]) {
//            [self.delegate mWebViewHeightChange:height andMWebView:self];
//        }
//    });
//    self.isLoadCpmplete = YES;
    
}

@end
