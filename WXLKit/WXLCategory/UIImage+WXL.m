//
//  UIImage+wxl.m
//  wxlCategory
//
//  Created by 李蒙 on 15/7/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIImage+WXL.h"
#import "WXLKit.h"
#import <objc/runtime.h>

@import CoreImage;

@interface UIImage ()

@property(copy, nonatomic) wxl_WriteToSavedPhotosSuccess writeToSavedPhotosSuccess;

@property(copy, nonatomic) wxl_WriteToSavedPhotosError writeToSavedPhotosError;

@end

static char writeToSavedPhotosSuccessKey, writeToSavedPhotosErrorKey;

@implementation UIImage (WXL)

#pragma mark -.-

- (void)setWriteToSavedPhotosSuccess:(wxl_WriteToSavedPhotosSuccess)writeToSavedPhotosSuccess {
    
    objc_setAssociatedObject(self, &writeToSavedPhotosSuccessKey, writeToSavedPhotosSuccess, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (wxl_WriteToSavedPhotosSuccess)writeToSavedPhotosSuccess {
    
    return objc_getAssociatedObject(self, &writeToSavedPhotosSuccessKey);
}

- (void)setWriteToSavedPhotosError:(wxl_WriteToSavedPhotosError)writeToSavedPhotosError {
    
    objc_setAssociatedObject(self, &writeToSavedPhotosErrorKey, writeToSavedPhotosError, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (wxl_WriteToSavedPhotosError)writeToSavedPhotosError {
    
    return objc_getAssociatedObject(self, &writeToSavedPhotosErrorKey);
}

#pragma mark 调整图片大小、质量

- (UIImage *)wxl_imageWithResize:(CGSize)size quality:(CGInterpolationQuality)quality
{
    UIImage *resized = nil;
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}

#pragma mark 将UIColor转为UIImage

+ (UIImage *)wxl_imageWithColor:(UIColor *)color
{
    return [UIImage wxl_imageWithColor:color withFrame:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)wxl_imageWithColor:(UIColor *)color withFrame:(CGRect)frame
{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

#pragma mark 根据设备加载图片名

+ (UIImage *)wxl_imageWithName:(NSString *)name
{
    NSString *origin = name;
    
    NSString *suffix;
    
    if (WXLiPhone4) {
        suffix = @"_480h";
    } else if (WXLiPhone5) {
        suffix = @"_568h";
    } else if (WXLiPhone6) {
        suffix = @"_667h";
    } else if (WXLiPhone6Plus) {
        suffix = @"_736h";
    } else {
        suffix = @"";
    }
    
    NSString *fileName = [name stringByDeletingPathExtension];
    NSString *extenesion = [name pathExtension];
    
    if (extenesion.length) {
        name = [[fileName stringByAppendingString:suffix] stringByAppendingPathExtension:extenesion];
    } else {
        name = [fileName stringByAppendingString:suffix];
    }
    
    return [UIImage imageNamed:name] ? [UIImage imageNamed:name] : [UIImage imageNamed:origin];
}

#pragma mark 保存到相簿

- (void)wxl_writeToSavedPhotosAlbumWithSuccess:(wxl_WriteToSavedPhotosSuccess)success error:(wxl_WriteToSavedPhotosError)error
{
    self.writeToSavedPhotosSuccess = success;
    self.writeToSavedPhotosError = error;
    
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        
        if (self.writeToSavedPhotosError) {
            self.writeToSavedPhotosError(error);
        }
        
    } else {
        
        if (self.writeToSavedPhotosSuccess) {
            self.writeToSavedPhotosSuccess();
        }
    }
}

#pragma mark 截屏

+ (UIImage *)wxl_screenshot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            
            CGContextSaveGState(context);
            
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            
            CGContextConcatCTM(context, [window transform]);
            
            CGContextTranslateCTM(context, -[window bounds].size.width * [[window layer] anchorPoint].x, -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark 获取launchImage

+ (UIImage *)wxl_launchImage
{
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary *dict in imagesDict) {
        
        if (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeFromString(dict[@"UILaunchImageSize"]))) {
            
            return [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    
    NSString *launchImageName = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImageFile"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
            
            return [UIImage imageNamed:[launchImageName stringByAppendingString:@"-Portrait"]];
        }
        
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            
            return [UIImage imageNamed:[launchImageName stringByAppendingString:@"-Landscape"]];
        }
    }
    
    return [UIImage imageNamed:launchImageName];
}

#pragma mark 创建二维码

+ (UIImage *)wxl_imageWithQRCode:(NSString *)QRCode
{
    return [UIImage wxl_imageWithfilterName:@"CIQRCodeGenerator" code:QRCode];
}

#pragma mark 创建条形码

+ (UIImage *)wxl_imageWithBarcodeCode:(NSString *)BarcodeCode
{
    return [UIImage wxl_imageWithfilterName:@"CICode128BarcodeGenerator" code:BarcodeCode];
}

+ (UIImage *)wxl_imageWithfilterName:(NSString *)name code:(NSString *)code
{
    CIFilter *filter = [CIFilter filterWithName:name];
    
    [filter setDefaults];
    
    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage scale:1.0 orientation:UIImageOrientationUp];
    
    CGImageRelease(cgImage);
    
    return image;
}

#pragma mark 旋转

- (UIImage *)wxl_rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    
    CGRect rect;
    
    float translateX = 0;
    
    float translateY = 0;
    
    float scaleX = 1.0;
    
    float scaleY = 1.0;
    
    switch (orientation) {
            
        case UIImageOrientationLeft:
            
            rotate = M_PI_2;
            
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            
            translateX = 0;
            
            translateY = -rect.size.width;
            
            scaleY = rect.size.width / rect.size.height;
            
            scaleX = rect.size.height / rect.size.width;
            
            break;
            
        case UIImageOrientationRight:
            
            rotate = 3 * M_PI_2;
            
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            
            translateX = -rect.size.height;
            
            translateY = 0;
            
            scaleY = rect.size.width / rect.size.height;
            
            scaleX = rect.size.height / rect.size.width;
            
            break;
            
        case UIImageOrientationDown:
            
            rotate = M_PI;
            
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            
            translateX = -rect.size.width;
            
            translateY = -rect.size.height;
            
            break;
            
        default:
            
            rotate = 0.0;
            
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            
            translateX = 0;
            
            translateY = 0;
            
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextRotateCTM(context, rotate);
    
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}

@end
