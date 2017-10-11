//
//  UIWebView+WXL.h
//  WXLCategory
//
//  Created by 李蒙 on 15/8/10.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (WXL)

/**
 *  请求URLString
 *
 *  @param URLString 网址
 */
- (void)wxl_loadRequestURL:(NSString *)URLString;

/**
 *  加载本地Html
 *
 *  @param htmlName 文件名
 */
- (void)wxl_loadLocalHtml:(NSString *)htmlName;

/**
 *  清除缓存
 */
+ (void)wxl_clearCookies;

@end
