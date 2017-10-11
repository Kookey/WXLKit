//
//  UIViewController+WXL.h
//  WXLCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WXLTransitionTypeFade,
    WXLTransitionTypePush,
    WXLTransitionTypeCube,
    WXLTransitionTypeFlip,
    WXLTransitionTypeRipple,
    WXLTransitionTypePageCurl,
    WXLTransitionTypePageUnCurl,
    WXLTransitionTypeSuckEffect,
    WXLTransitionTypePageCameraOpen,
    WXLTransitionTypePageCamreaClose
} WXLTransitionType;

typedef enum : NSUInteger {
    WXLTransitionDirectionTop,
    WXLTransitionDirectionLeft,
    WXLTransitionDirectionBottom,
    WXLTransitionDirectionRight
} WXLTransitionDirection;

typedef void(^WXLTransitionCompletion)();
typedef void(^WXLFinishPickingMedia)(NSDictionary *info);
typedef void(^WXLCancelPickingMedia)();

typedef void(^WXLLoadingAppStore)();
typedef void(^WXLLoadedAppStore)(NSError *error);
typedef void(^WXLDidFinishAppStore)();

typedef void (^WXLStoryboardSegue) (id sender, UIStoryboardSegue *segue, id destinationViewController);

@protocol WXLBackButtonHandlderProtocol <NSObject>

@optional

/**
 *  重写此方法处理返回按钮
 *
 *  @return YES:返回,NO:不返回
 */
- (BOOL)wxl_navigationShouldPopOnBackButton;

@end

@interface UIViewController (WXL) <WXLBackButtonHandlderProtocol>

/**
 *  触摸自动隐藏键盘
 */
- (void)wxl_tapDismissKeyboard;

/**
 *  转场动画
 *
 *  @param type       WXLTransitionType
 *  @param direction  WXLTransitionDirection
 *  @param duration   duration
 *  @param completion WXLTransitionCompletion
 */
- (void)wxl_addTransitionType:(WXLTransitionType)type direction:(WXLTransitionDirection)direction duration:(NSTimeInterval)duration completion:(WXLTransitionCompletion)completion;

/**
 *  快速跳转到UIImagePickerController
 *
 *  @param sourceType    [UIImagePickerControllerSourceTypePhotoLibrary, UIImagePickerControllerSourceTypeCamera, UIImagePickerControllerSourceTypeSavedPhotosAlbum]
 *  @param allowsEditing 是否裁剪
 *  @param completion    跳转完成回调
 *  @param finish        [UIImagePickerControllerMediaType,UIImagePickerControllerOriginalImage,UIImagePickerControllerCropRect,UIImagePickerControllerMediaURL,UIImagePickerControllerReferenceURL,UIImagePickerControllerMediaMetadata]
 *  @param cancel        取消回调
 *
 *  @return UIImagePickerController
 */
- (UIImagePickerController *)wxl_presentImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType allowsEditing:(BOOL)allowsEditing completion:(void (^)(void))completion didFinishPickingMedia:(WXLFinishPickingMedia)finish didCancelPickingMediaWithInfo:(WXLCancelPickingMedia)cancel;

/**
 *  跳转到AppStore
 *
 *  @param itemIdentifier       应用Identifier
 *  @param loadingAppStore      加载中回调
 *  @param loadedAppStore       跳转回调
 *  @param didFinishAppStore    点击取消回调
 */
- (void)wxl_presentAppStoreWithITunesItemIdentifier:(NSInteger)itemIdentifier loading:(WXLLoadingAppStore)loadingAppStore loaded:(WXLLoadedAppStore)loadedAppStore didFinish:(WXLDidFinishAppStore)didFinishAppStore;

/**
 *  storyboardSegue连线跳转
 *
 *  @param identifier      identifier
 *  @param storyboardSegue 回调
 */
- (void)wxl_prepareForSegueWithIdentifier:(NSString *)identifier storyboardSegue:(WXLStoryboardSegue)storyboardSegue;

/**
 *  storyboardSegue代码跳转
 *
 *  @param identifier      identifier
 *  @param sender          sender
 *  @param storyboardSegue 回调
 */
- (void)wxl_performSegueWithIdentifier:(NSString *)identifier sender:(id)sender storyboardSegue:(WXLStoryboardSegue)storyboardSegue;

@end
