//
//  HttpManager.h
//
//  Created by Jony on 2017/9/22.
//  Copyright © 2017年 Lemo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIImage;

//宏定义成功block 回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义失败block 回调失败信息
typedef void (^HttpFailure)(NSError *error);

// 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
typedef void (^HttpProgress)(NSProgress *progress);

typedef NS_ENUM(NSUInteger, WXLNetworkStatusType) {
    /// 未知网络
    WXLNetworkStatusUnknown,
    /// 无网络
    WXLNetworkStatusNotReachable,
    /// 手机网络
    WXLNetworkStatusReachableViaWWAN,
    /// WIFI网络
    WXLNetworkStatusReachableViaWiFi
};

/// 网络状态的Block
typedef void(^WXLNetworkStatus)(WXLNetworkStatusType status);

@interface WXLHttpManager : NSObject


+ (void)wxl_networkStatusWithBlock:(WXLNetworkStatus)networkStatus;

+ (BOOL)wxl_isNetwork;

+ (BOOL)wxl_isWWANNetwork;

+ (BOOL)wxl_isWiFiNetwork;

+(void)wxl_startMonitoring;

//提交json格式的数据 Content-Type: application/json
/**
 提交json格式数据
 
 @param url 请求地址
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+(void) postJSON:(NSString *) url params:(NSDictionary *) params success:(HttpSuccess) success failure:(HttpFailure)failure;

/**
 http post 请求
 
 @param url 请求地址
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+(void) post:(NSString *) url params:(NSDictionary *) params success:(HttpSuccess) success failure:(HttpFailure)failure;

/**
 http get 请求
 
 @param url 请求地址
 @param params 请求参数
 @param success 上传成功回调
 @param failure 上传失败回调
 */
+(void) get:(NSString *) url params:(NSDictionary *) params success:(HttpSuccess) success failure:(HttpFailure)failure;

//文件上传主入口,参数,文件,图片
/**
 Description
 
 @param url url 上传地址
 @param params 请求参数
 @param fileNames 文件名称
 @param filePaths 文件路径
 @param images 图片
 @param imageNames 图片名称
 @param imageScale 压缩比例
 @param imageType 图片类型
 @param progress 上传进度回调
 @param success 上传成功回调
 @param failure 上传失败回调
 */
+(void) upload:(NSString *)url
        params:(NSDictionary *)params
     fileNames:(NSArray *)fileNames
      filePath:(NSArray *)filePaths
        images:(NSArray<UIImage *> *) images
    imageNames:(NSArray *) imageNames
    imageScale:(CGFloat) imageScale
     imageType:(NSString *)imageType
      progress:(HttpProgress) progress
       success:(HttpSuccess) success
       failure:(HttpFailure) failure;

//单张图片上传
+(void) uploadImage:(NSString *) url params:(NSDictionary *) params
              image:(UIImage *) image
          imageName:(NSString *) imageName
         imageScale:(CGFloat) imageScale
          imageType:(NSString *) imageType
            success:(HttpSuccess) success
            failure:(HttpFailure) failure
           progress:(HttpProgress) progress;

//多张图片上传
+(void) uploadImages:(NSString *) url
              params:(NSDictionary *) params
              images:(NSArray<UIImage *> *) images
          imageNames:(NSArray *) imageNames
          imageScale:(CGFloat) imageScale
           imageType:(NSString *) imageType
             success:(HttpSuccess) success
             failure:(HttpFailure) failure
            progress:(HttpProgress) progress;

//单文件上传
+(void) uploadFile:(NSString *) url
            params:(NSDictionary *)params
          fileName:(NSString *) fileName
          filePath:(NSString *) filePath
           success:(HttpSuccess) success
           failure:(HttpFailure)failure
          progress:(HttpProgress) progress;

//多文件上传
+(void) uploadFiles:(NSString *)url
             params:(NSDictionary *)params
          fileNames:(NSArray *)fileNames
           filePath:(NSArray *)filePaths
           progress:(HttpProgress) progress
            success:(HttpSuccess) success
            failure:(HttpFailure) failure;

@end

@interface HttpManagerConfig : NSObject

@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *headerToken;

+(instancetype) sharedConfig;

+(NSString *) token;

+(void) refresh:(NSString *) token;

@end
