//
//  ZZWebTouchControl.m
//  ZZWebViewDemo_Example
//
//  Created by PengZhiZhong on 2018/10/26.
//  Copyright © 2018 pengzz. All rights reserved.
//

#import "ZZWebTouchControl.h"

#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;

@interface ZZWebTouchControl ()
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;
@end

@implementation ZZWebTouchControl
- (instancetype)init {
    return [self initWithWebView:nil];
}
- (instancetype)initWithWebView:(__kindof UIView *_Nullable)webView {
    self = [super init];
    if (self) {
        _webView = webView;
        
        [self addTapGestureRecognizer];
        [self addLongPressGestureRecognizer];
    }
    return self;
}

- (void)setWebView:(__kindof UIView *)webView {
    [_webView removeGestureRecognizer:self.tapGestureRecognizer];
    [_webView removeGestureRecognizer:self.longPressGestureRecognizer];
    if ([webView isKindOfClass:[UIWebView class]] || [webView isKindOfClass: [WKWebView class]]) {
        _webView = webView;
        [self addTapGestureRecognizer];
        [self addLongPressGestureRecognizer];
    }
}

 #pragma mark- TapGestureRecognizer
 /**
  *  3.允许多个手势识别器共同识别
 
  默认情况下，两个gesture recognizers不会同时识别它们的手势,但是你可以实现UIGestureRecognizerDelegate协议中的
  gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:方法对其进行控制。这个方法一般在一个手势接收者要阻止另外一个手势接收自己的消息的时候调用，如果返回YES,则两个gesture recognizers可同时识别，如果返回NO，则并不保证两个gesture recognizers必不能同时识别，因为另外一个gesture recognizer的此方法可能返回YES。也就是说两个gesture recognizers的delegate方法只要任意一个返回YES，则这两个就可以同时识别；只有两个都返回NO的时候，才是互斥的。默认情况下是返回NO。
  *
  *  @param gestureRecognizer      手势
  *  @param otherGestureRecognizer 其他手势
  *
  *  @return YES代表可以多个手势同时识别，默认是NO，不可以多个手势同时识别
  */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
//    NSLog(@"gestureRecognizer : %@",gestureRecognizer);
//    NSLog(@"otherGestureRecognizer : %@",otherGestureRecognizer);
    {
        if (otherGestureRecognizer == self.tapGestureRecognizer) {
            return NO;
        }
        return YES;
    }
    
    /*
    //只加长按手势时才加下面这几行代码
    otherGestureRecognizer.cancelsTouchesInView = NO;
    if ([otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        otherGestureRecognizer.enabled = NO;
    }
     */
    
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}


#pragma mark - GestureRecognizer

- (void)addTapGestureRecognizer {
    [self.webView addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)addLongPressGestureRecognizer {
    [self.webView addGestureRecognizer:self.longPressGestureRecognizer];
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    NSLog(@"处理点击手势");
    dispatch_async(dispatch_get_main_queue(), ^{
        !self.webViewTapGestureRecognizer?:self.webViewTapGestureRecognizer();
    });
}

- (void)handleLongPressGestureRecognizer:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    NSLog(@"处理长按手势");
    if (longPressGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [longPressGestureRecognizer locationInView:self.webView];
        NSString *imgJs = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
        
        if ([_webView isKindOfClass:[UIWebView class]]) {
            [self handleLongPressGestureRecognizerOfUIWebView:imgJs andPoint:touchPoint];
            return;
        }
        
        if ([_webView isKindOfClass:[WKWebView class]]) {
            [self handleLongPressGestureRecognizerOfWKWebView:imgJs andPoint:touchPoint];
            return;
        }
        
        NSLog(@"webView 不存在");
    }
}

- (void)handleLongPressGestureRecognizerOfUIWebView:(NSString *)imgJs andPoint:(CGPoint)point {
    NSString *url = [_webView stringByEvaluatingJavaScriptFromString:imgJs];
    if (url.length == 0) {
        NSLog(@"长按点击的不是图片，且返回图片的.src为空...");
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect frame = [self uiWebView_elementFrameWithPoint:point];
        [self callBackOfLongPressGestureRecognizer:url andPoint:frame];
    });
}

- (void)handleLongPressGestureRecognizerOfWKWebView:(NSString *)imgeJs andPoint:(CGPoint)point{
    // 执行对应的JS代码 获取url
    WeakSelf
    [(WKWebView*)self.webView evaluateJavaScript:imgeJs completionHandler:^(id _Nullable url, NSError * _Nullable error) {
        if (url) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf wkWebView_elementFrameWithPoint:point callBlock:^(CGRect frame) {
                    [weakSelf callBackOfLongPressGestureRecognizer:url andPoint:frame];
                }];
            });
        } else {
            NSLog(@"长按点击的不是图片，且返回图片的.src为空...");
        }
    }];
}

- (void)callBackOfLongPressGestureRecognizer:(NSString *)url andPoint:(CGRect)frame {
    CGRect kframe = frame; //[_webView convertRect:frame toView:[[[UIApplication sharedApplication] delegate] window]];
    if (@available(iOS 11.0, *)) {
        if ([_webView isKindOfClass:[UIWebView class]]) {
            kframe.origin.y += ((UIWebView*)_webView).scrollView.adjustedContentInset.top;//发现方法出的frame上面差一个adjustedContentInset.top
        }
        if ([_webView isKindOfClass:[WKWebView class]]) {
            kframe.origin.y += ((WKWebView*)_webView).scrollView.adjustedContentInset.top;// Fallback on earlier versions
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        !self.webViewlongPressGestureRecognizerWithUrl?:self.webViewlongPressGestureRecognizerWithUrl(url, kframe);
    });
    //NSLog(@"长按：urlStr==%@, frame==%@", urlStr, NSStringFromCGRect(frame));
}

#pragma mark - elementFrameWithPoint
- (CGRect)uiWebView_elementFrameWithPoint:(CGPoint)touchPoint {
    NSString *jsElementRect = [NSString stringWithFormat:@"function f(){ var r = document.elementFromPoint(%f, %f).getBoundingClientRect(); return '{{'+r.left+','+r.top+'},{'+r.width+','+r.height+'}}'; } f();",touchPoint.x,touchPoint.y];
    NSString *result = [(UIWebView*)_webView stringByEvaluatingJavaScriptFromString:jsElementRect];
    CGRect rect = CGRectFromString(result);
    return rect;
}
- (void)wkWebView_elementFrameWithPoint:(CGPoint)touchPoint callBlock:(void(^)(CGRect frame)) block {
    NSString *jsElementRect = [NSString stringWithFormat:@"function f(){ var r = document.elementFromPoint(%f, %f).getBoundingClientRect(); return '{{'+r.left+','+r.top+'},{'+r.width+','+r.height+'}}'; } f();",touchPoint.x,touchPoint.y];
    [(WKWebView*)_webView evaluateJavaScript:jsElementRect completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        CGRect rect = CGRectFromString(result);
        !block?:block(rect);
    }];
}

#pragma mark - 懒加载
- (UITapGestureRecognizer *)tapGestureRecognizer {
    if (nil == _tapGestureRecognizer) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
        _tapGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
        [_tapGestureRecognizer requireGestureRecognizerToFail:self.longPressGestureRecognizer];
    }
    return _tapGestureRecognizer;
}
- (UILongPressGestureRecognizer *)longPressGestureRecognizer {
    if (nil == _longPressGestureRecognizer) {
        _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestureRecognizer:)];
        _longPressGestureRecognizer.minimumPressDuration = 0.3;
        _longPressGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;;
    }
    return _longPressGestureRecognizer;
}

@end



#pragma mark - ......::::::: 辅助方法 :::::::......

@implementation UIView (ZZScreenShots)

/**
 屏幕截图
 
 @return 截图图片对象
 */
- (UIImage *)zz_screenShot {
    return [self zz_screenShotAtFrame:self.bounds];
}

/**
 获取指定区域的屏幕截图
 
 @param frame 指定区域
 @return 截图图片对象
 */
- (UIImage *)zz_screenShotAtFrame:(CGRect)frame {
    //for retina displays
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(frame.size);
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, -frame.origin.x, -frame.origin.y);
    [self.layer renderInContext:ctx];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}

/**
 识别图片中二维码
 
 @param image 传入的要识别的图片对象
 @return 返回识别出的二维码字串
 */
+ (NSString*)zz_getQRCodeStrWithImage:(UIImage*)image {
    CIImage *ciImage = [[CIImage alloc] initWithCGImage:image.CGImage options:nil];
    CIContext *ciContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}]; // 软件渲染
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:ciContext options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];// 二维码识别
    NSArray *features = [detector featuresInImage:ciImage];
    for (CIQRCodeFeature *feature in features) {
        NSLog(@"msg = %@",feature.messageString); // 打印二维码中的信息
        NSString *messageString = feature.messageString;
        return messageString;
    }
    return nil;
}

@end

