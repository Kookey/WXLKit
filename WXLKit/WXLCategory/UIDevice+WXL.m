//
//  UIDevice+WXL.m
//  WXLCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIDevice+WXL.h"
#import "sys/utsname.h"

@implementation UIDevice (WXL)

#pragma mark 创建UUID(通用唯一识别码)

+ (NSString *)wxl_UUIDCreate
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    
    return uuid;
}

#pragma mark 获取系统名称

+ (NSString *)wxl_systemName
{
    return [self currentDevice].systemName;
}

#pragma mark 获取手机型号

+ (NSString *)wxl_systemVersion
{
    return [self currentDevice].systemVersion;
}

#pragma mark 获取设备型号

+ (NSString *)wxl_deviceMachine
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString *)wxl_deviceName
{
    NSArray *modelArray = @[
                            @"i386", @"x86_64",
                            
                            @"iPhone1,1",
                            @"iPhone1,2",
                            @"iPhone2,1",
                            @"iPhone3,1",
                            @"iPhone3,2",
                            @"iPhone3,3",
                            @"iPhone4,1",
                            @"iPhone5,1",
                            @"iPhone5,2",
                            @"iPhone5,3",
                            @"iPhone5,4",
                            @"iPhone6,1",
                            @"iPhone6,2",
                            @"iPhone7,1",
                            @"iPhone7,2",
                            
                            @"iPod1,1",
                            @"iPod2,1",
                            @"iPod3,1",
                            @"iPod4,1",
                            @"iPod5,1",
                            
                            @"iPad1,1",
                            @"iPad2,1",
                            @"iPad2,2",
                            @"iPad2,3",
                            @"iPad2,4",
                            @"iPad3,1",
                            @"iPad3,2",
                            @"iPad3,3",
                            @"iPad3,4",
                            @"iPad3,5",
                            @"iPad3,6",
                            @"iPad4,1",
                            @"iPad4,2",
                            @"iPad4,3",
                            
                            @"iPad2,5",
                            @"iPad2,6",
                            @"iPad2,7",
                            @"iPad4,4",
                            @"iPad4,5",
                            @"iPad4,6",
                            ];
    
    NSArray *modelNameArray = @[
                                @"iPhone",
                                @"iPhone",
                                
                                @"iPhone 2G",
                                @"iPhone 3G",
                                @"iPhone 3GS",
                                @"iPhone 4",
                                @"iPhone 4",
                                @"iPhone 4",
                                @"iPhone 4S",
                                @"iPhone 5",
                                @"iPhone 5",
                                @"iPhone 5c",
                                @"iPhone 5c",
                                @"iPhone 5s",
                                @"iPhone 5s",
                                @"iPhone 6 Plus",
                                @"iPhone 6",
                                
                                @"iPod Touch 1G",
                                @"iPod Touch 2G",
                                @"iPod Touch 3G",
                                @"iPod Touch 4G",
                                @"iPod Touch 5G",
                                
                                @"iPad",
                                @"iPad 2",
                                @"iPad 2",
                                @"iPad 2",
                                @"iPad 2",
                                @"iPad 3",
                                @"iPad 3",
                                @"iPad 3",
                                @"iPad 4",
                                @"iPad 4",
                                @"iPad 4",
                                @"iPad Air",
                                @"iPad Air",
                                @"iPad Air",
                                
                                @"iPad mini",
                                @"iPad mini",
                                @"iPad mini",
                                @"iPad mini 2G",
                                @"iPad mini 2G",
                                @"iPad mini 2G"
                                ];
    
    NSInteger modelIndex = - 1;
    NSString *modelNameString = @"";
    modelIndex = [modelArray indexOfObject:[UIDevice wxl_deviceMachine]];
    
    if (modelIndex >= 0 && modelIndex < [modelNameArray count]) {
        
        modelNameString = [modelNameArray objectAtIndex:modelIndex];
    }
    
    return modelNameString;
}

#pragma mark - 是否有摄像头

+ (BOOL)wxl_availableCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

@end
