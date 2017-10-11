//
//  UIApplication+WXL.h
//  WXLCategory
//
//  Created by 李蒙 on 15/7/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WXLCallTelephone(tel) [[UIApplication sharedApplication] wxl_callTelephone:tel]
#define WXLOpenAppStoreDetails(identifier) [[UIApplication sharedApplication] wxl_openAppDetailsURLForIdentifier:identifier]
#define WXLOpenAppStoreReviews(identifier) [[UIApplication sharedApplication] wxl_openAppReviewsURLForIdentifier:identifier]
#define WXLOpenAppForURLSchemes(schemes) [[UIApplication sharedApplication] wxl_openAppForURLSchemes:schemes]

#define WXLAlertShowGrantedAccessDenied(type, alertTitle, cancelTitle) [[UIApplication sharedApplication] wxl_showGrantedAccessDeniedWithType:type title:alertTitle cancelButtonTitle:cancelTitle]


#define WXLAlertShowGrantedAccessDeniedCalendar(alertTitle, cancelTitle) WXLAlertShowGrantedAccessDenied(@"日历", alertTitle, cancelTitle)
#define WXLAlertShowGrantedAccessDeniedContacts(alertTitle, cancelTitle) WXLAlertShowGrantedAccessDenied(@"通讯录", alertTitle, cancelTitle)
#define WXLAlertShowGrantedAccessDeniedMicrophone(alertTitle, cancelTitle) WXLAlertShowGrantedAccessDenied(@"麦克风", alertTitle, cancelTitle)
#define WXLAlertShowGrantedAccessDeniedCamera(alertTitle, cancelTitle) WXLAlertShowGrantedAccessDenied(@"相机", alertTitle, cancelTitle)
#define WXLAlertShowGrantedAccessDeniedPhotos(alertTitle, cancelTitle) WXLAlertShowGrantedAccessDenied(@"照片", alertTitle, cancelTitle)
#define WXLAlertShowGrantedAccessDeniedReminders(alertTitle, cancelTitle) WXLAlertShowGrantedAccessDenied(@"提醒事项", alertTitle, cancelTitle)
#define WXLAlertShowGrantedAccessDeniedLocation(alertTitle, cancelTitle) WXLAlertShowGrantedAccessDenied(@"定位服务", alertTitle, cancelTitle)

@interface UIApplication (WXL)

/**
 *  是否首次打开这个应用
 *
 *  @param block 是/不是
 */
- (void)wxl_firstOpenedApp:(void (^)(BOOL isFirstOpened))block;

/**
 *  是否首次打开这个build
 *
 *  @param block 是/不是
 */
- (void)wxl_firstOpenedBuild:(void (^)(BOOL isFirstOpened))block;

/**
 *  是否首次打开这个Version
 *
 *  @param block 是/不是
 */
- (void)wxl_firstOpenedVersion:(void (^)(BOOL isFirstOpened))block;

/**
 *  是否首次打开
 *
 *  @param key   key
 *  @param block 是/不是
 */
- (void)wxl_firstOpenedKey:(NSString *)key flag:(void (^)(BOOL isFirstOpened))block;

/**
 *  请求Calendar权限
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)wxl_requestAccessGrantedToCalendarWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

/**
 *  请求Contacts权限
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)wxl_requestAccessGrantedToContactsWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

/**
 *  请求Microphone权限
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)wxl_requestAccessGrantedToMicrophoneWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

/**
 *  请求Camera权限
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)wxl_requestAccessGrantedToCameraWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
/**
 *  请求Photos权限
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)wxl_requestAccessGrantedToPhotosWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

/**
 *  请求Reminders权限
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)wxl_requestAccessGrantedToRemindersWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

/**
 *  请求Motion权限(授权失败也可以用)
 *
 *  @param accessGranted 授权成功
 */
- (void)wxl_requestAccessGrantedToMotionWithSuccess:(void(^)())accessGranted;

/**
 *  请求Location权限(iOS8需要在Info.plist添加NSLocationWhenInUseUsageDescription)
 *
 *  获取断授权状态[CLLocationManager authorizationStatus]
 *  kCLAuthorizationStatusNotDetermined -> 第一次授权
 *  kCLAuthorizationStatusAuthorizedWhenInUse、kCLAuthorizationStatusAuthorizedAlways -> 已授权
 *  kCLAuthorizationStatusDenied -> 拒绝授权
 *
 *  @param accessGranted 授权成功
 *  @param accessDenied  授权失败
 */
- (void)wxl_requestAccessGrantedToLocationWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

/**
 *  授权失败提醒
 *
 *  @param type              授权类型(e.g.通讯录)
 *  @param title             title
 *  @param cancelButtonTitle cancelButtonTitle
 */
- (void)wxl_showGrantedAccessDeniedWithType:(NSString *)type title:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle;

/**
 *  调用定位获取GPS坐标(CLLocation)
 *
 *  @param didUpdateLocations 成功回调
 */
- (void)wxl_locationDidUpdate:(void (^)(NSArray *locations, NSError *error))didUpdateLocations;

/**
 *  打电话
 *
 *  @param tel 电话号码
 *
 *  @return 是否拨打成功
 */
- (BOOL)wxl_callTelephone:(NSString *)tel;

/**
 *  跳转到appStroe应用详情
 *
 *  @param identifier 应用identifier
 *
 *  @return 是否跳转成功
 */
- (BOOL)wxl_openAppDetailsURLForIdentifier:(NSUInteger)identifier;

/**
 *  跳转到appStroe应用评论
 *
 *  @param identifier 应用identifier
 *
 *  @return 是否跳转成功
 */
- (BOOL)wxl_openAppReviewsURLForIdentifier:(NSUInteger)identifier;

/**
 *  跳转到App
 *
 *  @param schemes URLSchemes
 *
 *  @return 是否跳转成功
 */
- (BOOL)wxl_openAppForURLSchemes:(NSString *)schemes;

@end
