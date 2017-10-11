//
//  UIWebView+WXL.m
//  WXLCategory
//
//  Created by 李蒙 on 15/8/10.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIWebView+WXL.h"
#import "NSString+WXL.h"

@implementation UIWebView (WXL)

- (void)wxl_loadRequestURL:(NSString *)URLString
{
#if DEBUG
    NSLog(@"\n---------------------loadRequestURL--------------------\n%@\n---------------------loadRequestURL--------------------", URLString);
#endif
    [self loadRequest:[NSURLRequest requestWithURL:[URLString wxl_urlEncode]]];
}

- (void)wxl_loadLocalHtml:(NSString *)htmlName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
}

+ (void)wxl_clearCookies
{
    NSHTTPCookieStorage *storage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    
    for (NSHTTPCookie *cookie in storage.cookies) {
        
        [storage deleteCookie:cookie];
    }
    
    [NSUserDefaults.standardUserDefaults synchronize];
}

@end
