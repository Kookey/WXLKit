//
//  HttpManager.m
//  CocoaPodsDemo
//
//  Created by lemo-wu on 2017/9/22.
//  Copyright © 2017年 Lemo. All rights reserved.
//

#import "WXLHttpManager.h"
#import "NSString+WXL.h"
#import "WXLMacro.h"
#import <AVFoundation/AVFoundation.h>
#import "AFNetworking.h"

@implementation WXLHttpManager


//提交json格式的数据 Content-Type: application/json


+(void) postJSON:(NSString *) url
          params:(NSDictionary *) params
         success:(HttpSuccess) success
         failure:(HttpFailure)failure
{
    AFHTTPSessionManager *manager = [self initSessionManager];
    AFJSONRequestSerializer * requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer = requestSerializer;
    //设置授权的token令牌
    [self setToken:manager];
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}



+(void) post:(NSString *) url
      params:(NSDictionary *) params
     success:(HttpSuccess) success
     failure:(HttpFailure)failure
{
    WXLLog(@"url:%@ params:%@", url,params);
    AFHTTPSessionManager *manager = [self initSessionManager];
    [[manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }] resume];
}


+(void) get:(NSString *) url
     params:(NSDictionary *) params
    success:(HttpSuccess) success
    failure:(HttpFailure)failure
{
    WXLLog(@"url:%@ params:%@", url,params);
    AFHTTPSessionManager *manager = [self initSessionManager];
    [self setToken:manager];
    [[manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }] resume];
}

//单文件上传
+(void) uploadFile:(NSString *) url
            params:(NSDictionary *)params
          fileName:(NSString *) fileName
          filePath:(NSString *) filePath
           success:(HttpSuccess) success
           failure:(HttpFailure)failure
          progress:(HttpProgress) progress
{
    NSArray *fileNames = @[fileName];
    NSArray *filePaths = @[filePath];
    [self uploadFiles:url params:params fileNames:fileNames filePath:filePaths progress:progress success:success failure:failure];
}

//多文件上传
+(void) uploadFiles:(NSString *)url
             params:(NSDictionary *)params
          fileNames:(NSArray *)fileNames
           filePath:(NSArray *)filePaths
           progress:(HttpProgress) progress
            success:(HttpSuccess) success
            failure:(HttpFailure) failure
{
    [self upload:url params:params fileNames:fileNames filePath:filePaths images:nil imageNames:nil imageScale:0 imageType:nil progress:progress success:success failure:failure];
}

//单张图片上传
+(void) uploadImage:(NSString *) url params:(NSDictionary *) params
              image:(UIImage *) image
          imageName:(NSString *) imageName
         imageScale:(CGFloat) imageScale
          imageType:(NSString *) imageType
            success:(HttpSuccess) success
            failure:(HttpFailure) failure
           progress:(HttpProgress) progress
{
    
    NSArray *imageNames = @[imageName];
    NSArray *images = @[image];
    [self uploadImages:url params:params images:images imageNames:imageNames imageScale:imageScale imageType:imageType success:success failure:failure progress:progress];
}

//多张图片上传
+(void) uploadImages:(NSString *) url
              params:(NSDictionary *) params
              images:(NSArray<UIImage *> *) images
          imageNames:(NSArray *) imageNames
         imageScale:(CGFloat) imageScale
          imageType:(NSString *) imageType
            success:(HttpSuccess) success
            failure:(HttpFailure) failure
           progress:(HttpProgress) progress
{
    [self upload:url params:params fileNames:nil filePath:nil images:images imageNames:imageNames imageScale:imageScale imageType:imageType progress:progress success:success failure:failure];
}


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
       failure:(HttpFailure) failure
{
    WXLLog(@"upload-->url:%@ params:%@", url,params);
    AFHTTPSessionManager *manager = [self initSessionManager];
    [self setToken:manager];
    [[manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //文件上传
        if (fileNames && fileNames.count>0) {
            NSInteger fileCnt = fileNames.count;
            for (NSUInteger i = 0; i < fileCnt; i++) {
                // 图片经过等比压缩后得到的二进制文件
                NSError *error = nil;
                NSString *filePath = filePaths[i];
                NSString *fileName = fileNames[i];
                [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:[NSString stringWithFormat:@"file%zd",i] fileName:fileName mimeType:@"application/octet-stream" error:&error];
                if (failure && error)
                {
                    failure(error);
                }
            }
        }
        
        //图片
        if (images&&images.count >0 ) {
            NSInteger imageCnt = images.count;
            for (NSUInteger i = 0; i < imageCnt; i++) {
                // 图片经过等比压缩后得到的二进制文件
                NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
                
                //
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *imageFileName = [NSString stringWithFormat:@"%@%zd.%@",str,i,imageType?:@"jpg"];
                
                [formData appendPartWithFileData:imageData
                                            name:[NSString stringWithFormat:@"image%zd",i]
                                        fileName:imageNames ? [NSString stringWithFormat:@"%@.%@",imageNames[i],imageType?:@"jpg"] : imageFileName
                                        mimeType:[NSString stringWithFormat:@"image/%@",imageType ?: @"jpg"]];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress?progress(uploadProgress):nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success?success(responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure?failure(error):nil;
    }] resume];
}

/**
 视频上传
 
 @param url 上传的url
 @param params 上传视频预留参数---视具体情况而定 可移除
 @param videoPath 上传视频的本地沙河路径
 @param success 成功的回调
 @param failure 失败的回调
 @param progress 上传的进度
 */

+ (void)uploadVideo:(NSString *)url
         parameters:(id)params
          videoPath:(NSString *)videoPath
            success:(HttpSuccess)success
            failure:(HttpFailure)failure
           progress:(HttpProgress)progress
{
    /*! 获得视频资源 */
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:videoPath]  options:nil];
    
    /*! 压缩 */
    
    //    NSString *const AVAssetExportPreset640x480;
    //    NSString *const AVAssetExportPreset960x540;
    //    NSString *const AVAssetExportPreset1280x720;
    //    NSString *const AVAssetExportPreset1920x1080;
    //    NSString *const AVAssetExportPreset3840x2160;
    
    /*! 创建日期格式化器 */
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *videoWritePath = [NSString stringWithFormat:@"video-%@.mp4",[formatter stringFromDate:[NSDate date]]];
    NSString *outfilePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", videoWritePath];
    
    AVAssetExportSession *avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    
    avAssetExport.outputURL = [NSURL fileURLWithPath:outfilePath];
    avAssetExport.outputFileType =  AVFileTypeMPEG4;
    
    [avAssetExport exportAsynchronouslyWithCompletionHandler:^{
        {if ([avAssetExport status] == AVAssetExportSessionStatusCompleted){
            AFHTTPSessionManager *manager = [self initSessionManager];
            [self setToken:manager];
            [[manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                NSURL *filePathURL = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", outfilePath]];
                // 获得沙盒中的视频内容
                [formData appendPartWithFileURL:filePathURL name:@"video" fileName:outfilePath mimeType:@"application/octet-stream" error:nil];
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (progress)progress(uploadProgress);
                });
            } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
                WXLLog(@"上传视频成功 = %@",responseObject);
                if (success) success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                WXLLog(@"上传视频失败 = %@", error);
                if (failure)failure(error);
            }] resume];
        }
        }
    }];
}


//文件下载
+(void) download:(NSString *)url
             dir:(NSString *) dir
         process:(HttpProgress) progress
         success:(void(^) (NSString *))success
         failure:(HttpFailure) failure
{
    WXLLog(@"download: url:%@", url);
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [self setToken:manager];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress){
        progress ? progress(downloadProgress) : nil;
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dir ? dir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString) : nil;
    }] resume];
}

+(AFHTTPSessionManager *) initSessionManager
{
    NSString *url = [HttpManagerConfig sharedConfig].url;
    if ([url isBlank]) {
        @throw [NSException exceptionWithName:@"Throwing a HttpManager exception" reason:@"please call [HttpManagerConfig sharedConfig].url=? in AppDelegate fisrt" userInfo:nil];
    }
    NSURL * URL = [[NSURL alloc] initWithString:url];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:URL];
    return manager;
}

+(void) setToken:(AFHTTPSessionManager *)manager
{
    NSString *headerToken = [HttpManagerConfig sharedConfig].headerToken;
    if ([headerToken isBlank]) {
        @throw [NSException exceptionWithName:@"Throwing a HttpManager exception" reason:@"please call [HttpManagerConfig sharedConfig].headerToken=? in AppDelegate fisrt" userInfo:nil];
    }
    if ([[HttpManagerConfig token] isNotBlank]) {
        [manager.requestSerializer setValue:[HttpManagerConfig token] forHTTPHeaderField:headerToken];
    }
}

@end

@interface HttpManagerConfig ()

@property(nonatomic, strong) NSString *token;

@end

static NSString * const kTokenKey = @"token_store";

@implementation HttpManagerConfig

+(instancetype)sharedConfig
{
    static dispatch_once_t once;
    static HttpManagerConfig *config;
    dispatch_once(&once, ^{
        config = [[HttpManagerConfig alloc] init];
    });
    return config;
}

+(NSString *)token
{
    NSString *tempToken = [[self sharedConfig] token];
    if ([tempToken isEqualToString:@""]) {
        tempToken = [[NSUserDefaults standardUserDefaults] valueForKey:kTokenKey];
        [[self sharedConfig] setToken:tempToken];
    }
    return tempToken;
}

+(void) refresh:(NSString *)token
{
    [[self sharedConfig] setToken:token];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
