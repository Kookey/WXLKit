//
//  NSBundle+WXL.h
//  WXLCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WXLAppName [NSBundle wxl_appName]
#define WXLAppIdentifier [NSBundle wxl_appIdentifier]
#define WXLAppVersion [NSBundle wxl_appVersion]
#define WXLAppBuild [NSBundle wxl_appBuild]

@interface NSBundle (WXL)

/**
 *  获取应用名称
 *
 *  @return 当前应用名称
 */
+ (NSString *)wxl_appName;

/**
 *  获取应用Identifier
 *
 *  @return 当前应用Identifier
 */
+ (NSString *)wxl_appIdentifier;

/**
 *  获取应用Version
 *
 *  @return 当前应用Version
 */
+ (NSString *)wxl_appVersion;

/**
 *  获取应用Bulid
 *
 *  @return 当前应用Bulid
 */
+ (NSString *)wxl_appBuild;

@end
