//
//  WXLWebViewController.h
//  WXLWebViewController
//
//  Created by 李蒙 on 15/8/11.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXLWebViewController : UIViewController

@property (strong, nonatomic) UIWebView *wxl_webView;

@property (assign, nonatomic) BOOL wxl_showHtmlTitle;

@property (assign, nonatomic) BOOL wxl_showGoBack;

@property (strong, nonatomic) UIColor *wxl_progressBarTintColor;

+ (instancetype)webViewControllerLoadRequestsURL:(NSString *)URLString;

+ (instancetype)webViewControllerLoadLocalHtml:(NSString *)htmlName;

@end
