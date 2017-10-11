//
//  UIImage+wxl.h
//  wxlCategory
//
//  Created by 李蒙 on 15/7/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^wxl_WriteToSavedPhotosSuccess)();
typedef void(^wxl_WriteToSavedPhotosError)(NSError *error);

@interface UIImage (wxl)

/**
 *  调整图片大小、质量
 *
 *  @param size    大小
 *  @param quality 质量
 *
 *  @return UIImage
 */

- (UIImage *)wxl_imageWithResize:(CGSize)size quality:(CGInterpolationQuality)quality;

/**
 *  将UIColor转为UIImage
 *
 *  @param color UIColor
 *
 *  @return UIImage
 */
+ (UIImage *)wxl_imageWithColor:(UIColor *)color;

/**
 *  将UIColor转为UIImage
 *
 *  @param color UIColor
 *  @param frame CGRect
 *
 *  @return UIImage
 */
+ (UIImage *)wxl_imageWithColor:(UIColor *)color withFrame:(CGRect)frame;

/**
 *  根据设备加载图片名
 *
 *  @param name 图片名
 *
 *  @return UIImage
 */
+ (UIImage *)wxl_imageWithName:(NSString *)name;

/**
 *  保存到相簿
 *
 *  @param success 成功回调
 *  @param error   失败回调
 */
- (void)wxl_writeToSavedPhotosAlbumWithSuccess:(wxl_WriteToSavedPhotosSuccess)success error:(wxl_WriteToSavedPhotosError)error;

/**
 *  截屏
 *
 *  @return UIImage
 */
+ (UIImage *)wxl_screenshot;

/**
 *  获取launchImage
 *
 *  @return UIImage
 */
+ (UIImage *)wxl_launchImage;

/**
 *  创建二维码
 *
 *  @param QRCode 二维码内容
 *
 *  @return UIImage
 */
+ (UIImage *)wxl_imageWithQRCode:(NSString *)QRCode;

/**
 *  创建条形码
 *
 *  @param BarcodeCode 条形码内容
 *
 *  @return UIImage
 */
+ (UIImage *)wxl_imageWithBarcodeCode:(NSString *)BarcodeCode;

/**
 *  旋转
 *
 *  @param orientation 90,180,270
 *
 *  @return UIImage
 */
- (UIImage *)wxl_rotation:(UIImageOrientation)orientation;

@end
