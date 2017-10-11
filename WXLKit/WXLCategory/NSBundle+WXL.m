//
//  NSBundle+WXL.m
//  WXLCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "NSBundle+WXL.h"

@implementation NSBundle (WXL)

#pragma mark 获取应用名称

+ (NSString *)wxl_appName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

#pragma mark 获取应用Identifier

+ (NSString *)wxl_appIdentifier
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

#pragma mark 获取应用Version

+ (NSString *)wxl_appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark 获取应用Bulid

+ (NSString *)wxl_appBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

@end
