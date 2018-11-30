//
//  ZZViewController.h
//  ZZWebViewDemo
//
//  Created by pengzz on 10/25/2018.
//  Copyright (c) 2018 pengzz. All rights reserved.
//

@import UIKit;

@interface ZZViewController : UIViewController

@end


//#pragma mark- TapGestureRecognizer
///**
// *  3.允许多个手势识别器共同识别
//
// 默认情况下，两个gesture recognizers不会同时识别它们的手势,但是你可以实现UIGestureRecognizerDelegate协议中的
// gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:方法对其进行控制。这个方法一般在一个手势接收者要阻止另外一个手势接收自己的消息的时候调用，如果返回YES,则两个gesture recognizers可同时识别，如果返回NO，则并不保证两个gesture recognizers必不能同时识别，因为另外一个gesture recognizer的此方法可能返回YES。也就是说两个gesture recognizers的delegate方法只要任意一个返回YES，则这两个就可以同时识别；只有两个都返回NO的时候，才是互斥的。默认情况下是返回NO。
// *
// *  @param gestureRecognizer      手势
// *  @param otherGestureRecognizer 其他手势
// *
// *  @return YES代表可以多个手势同时识别，默认是NO，不可以多个手势同时识别
// */
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    NSLog(@"gestureRecognizer : %@",gestureRecognizer);
//    NSLog(@"otherGestureRecognizer : %@",otherGestureRecognizer);
//    return YES;
//}


///4444=============================================================================================

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(webViewClick:)];
//        self.tap.delegate = self;
//        [self addGestureRecognizer:self.tap];
//    }
//    return self;
//}
//#pragma mark -- webView被点击
//- (void)webViewClick:(UITapGestureRecognizer *)tap{
//    CGPoint point = [tap locationInView:self];
//    NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).tagName", point.x, point.y];
//    [self evaluateJavaScript:js completionHandler:^(id tagName) {
//        NSLog(@"%@",tagName);
//        if ([tap isEqual:@"IMG"]) {
//            NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", point.x, point.y];
//            [self evaluateJavaScript:js completionHandler:^(id src) {
//                NSLog(@"%@",src);
//            }];
//        }
//    }];
//
//}
//
//#pragma mark -- 手势delegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    if (gestureRecognizer == self.tap) {
//        return YES;
//    }
//    return NO;
//}


//5555555==================================
//- (void)longPressed:(UITapGestureRecognizer*)recognizer
//{
//    if (recognizer.state != UIGestureRecognizerStateBegan) {
//        return;
//    }
//    CGPoint touchPoint = [recognizer locationInView:self.webView];
//    NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
//    NSString *imageUrl = [self.webView stringByEvaluatingJavaScriptFromString:js];
//    if (imageUrl.length == 0) {
//        return;
//    }
//    NSLog(@"image url：%@",imageUrl);
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
//    UIImage *image = [UIImage imageWithData:data];
//    if (image) {
//        //......
//        //save image or Extract QR code
//    }
//}
