//
//  UIDevice+WXL.h
//  WXLCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WXLUUIDCreat [UIDevice wxl_UUIDCreate]
#define WXLSystemName [UIDevice wxl_systemName]
#define WXLSystemVersion [UIDevice wxl_systemVersion]
#define WXLDeviceMachine [UIDevice wxl_deviceMachine]
#define WXLDeviceName [UIDevice wxl_deviceName]
#define WXLAvailableCamera [UIDevice wxl_availableCamera]

@interface UIDevice (WXL)

/**
 *  创建UUID(通用唯一识别码)
 *
 *  @return 通用唯一标识符
 */
+ (NSString *)wxl_UUIDCreate;

/**
 *  获取系统名称
 *
 *  @return 系统名称(iPhone OS)
 */
+ (NSString *)wxl_systemName;

/**
 *  获取系统版本号
 *
 *  @return 系统版本号(8.4)
 */
+ (NSString *)wxl_systemVersion;

/**
 *  获取设备型号
 *
 *  @return (iPhone7,2)
 */
+ (NSString *)wxl_deviceMachine;

/**
 *  获取设备型号
 *
 *  @return 设备型号(iPhone 6 Plus)
 */
+ (NSString *)wxl_deviceName;

/**
 *  是否有摄像头
 *
 *  @return 可以/不可以
 */
+ (BOOL)wxl_availableCamera;

@end
