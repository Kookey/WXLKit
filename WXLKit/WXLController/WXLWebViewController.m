//
//  WXLWebViewController.m
//  WXLWebViewController
//
//  Created by 李蒙 on 15/8/11.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "WXLWebViewController.h"
#import "UIWebView+WXL.h"

@interface WXLWebViewController () <UIWebViewDelegate>

@property(strong, nonatomic) UIProgressView *progressView;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation WXLWebViewController

+ (instancetype)webViewControllerLoadRequestsURL:(NSString *)URLString {
    
    return [[self alloc] initWithRequestsURL:URLString];
}

+ (instancetype)webViewControllerLoadLocalHtml:(NSString *)htmlName {
    
    return [[self alloc] initWithLocalHtml:htmlName];
}

- (UIWebView *)wxl_webView {
    
    if (!_wxl_webView) {
        
        self.wxl_webView = [[UIWebView alloc] init];
        self.wxl_webView.delegate = self;
        self.wxl_webView.frame  = self.view.bounds;
        [self.wxl_webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.wxl_webView setScalesPageToFit:YES];
        
        [self.view addSubview:self.wxl_webView];
    }
    
    return _wxl_webView;
}

- (UIProgressView *)progressView {
    
    if (!_progressView) {
        
        self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        self.progressView.progressTintColor = self.wxl_progressBarTintColor;
        self.progressView.trackTintColor = [UIColor clearColor];
        self.progressView.frame = CGRectMake(0, self.navigationController.navigationBar ? 64.0f : 0, self.view.frame.size.width, self.progressView.frame.size.height);
        [self.progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
        
        [self.view addSubview:self.progressView];
    }
    
    return _progressView;
}

- (instancetype)initWithRequestsURL:(NSString *)URLString {
    
    if (self = [super init]) {
        
        [self.wxl_webView wxl_loadRequestURL:URLString];
    }
    
    return self;
}

- (instancetype)initWithLocalHtml:(NSString *)htmlName {
    
    if (self = [super init]) {
        
        [self.wxl_webView wxl_loadLocalHtml:htmlName];
    }
    
    return self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (self.wxl_progressBarTintColor) {
        
        if (self.timer && self.timer.isValid) {
            
            [self.timer invalidate];
            self.timer = nil;
        }
        
        [self.progressView removeFromSuperview];
    }
}

- (BOOL)wxl_navigationShouldPopOnBackButton
{
    if (self.wxl_showGoBack) {
        
        if ([self.wxl_webView canGoBack]) {
            
            [self.wxl_webView goBack];
            
        } else {
            
            return YES;
        }
        
        return NO;
    }
    
    return YES;
}

- (void)fire:(id)sender
{
    CGFloat increment = 0.005 / (self.progressView.progress + 0.2f);
    
    if ([self.wxl_webView isLoading]) {
        
        CGFloat progress = (self.progressView.progress < 0.75f) ? self.progressView.progress + increment : self.progressView.progress + 0.0005;
        
        if (self.progressView.progress < 0.9) {
            
            [self.progressView setProgress:progress animated:YES];
        }
    }
}

- (void)startProgressViewLoading
{
    [self.progressView setAlpha:1.0f];
    
    if (!self.timer) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 / 60.0f target:self selector:@selector(fire:) userInfo:nil repeats:YES];
    }
}

- (void)stopProgressBarLoading
{
    if (self.timer && self.timer.isValid) {
        
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [self.progressView setProgress:1.0f animated:YES];
    
    [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [self.progressView setAlpha:0.0f];
        
    } completion:^(BOOL finished) {
        
        [self.progressView setProgress:0.0f animated:NO];
    }];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    if (self.wxl_progressBarTintColor) {
        
        [self startProgressViewLoading];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (self.wxl_showHtmlTitle) {
        
        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    
    if (self.wxl_progressBarTintColor) {
        
        [self stopProgressBarLoading];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (self.wxl_progressBarTintColor) {
        
        [self stopProgressBarLoading];
    }
}

@end
