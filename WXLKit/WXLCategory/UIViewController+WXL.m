//
//  UIViewController+WXL.m
//  WXLCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIViewController+WXL.h"
#import <objc/runtime.h>

@import StoreKit;

@interface UIViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, SKStoreProductViewControllerDelegate>

@property (copy, nonatomic) WXLFinishPickingMedia finishPickingMedia;

@property (copy, nonatomic) WXLCancelPickingMedia cancelPickingMedia;

@property (copy, nonatomic) WXLDidFinishAppStore didFinishAppStore;

@end

static char finishPickingMediaKey, cancelPickingMediaKey, didFinishAppStoreKey, segueDictionaryKey;

@implementation UIViewController (WXL)

#pragma mark -.-

- (void)setFinishPickingMedia:(WXLFinishPickingMedia)finishPickingMedia {
    
    objc_setAssociatedObject(self, &finishPickingMediaKey, finishPickingMedia, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (WXLFinishPickingMedia)finishPickingMedia {
    
    return objc_getAssociatedObject(self, &finishPickingMediaKey);
}

- (void)setCancelPickingMedia:(WXLCancelPickingMedia)cancelPickingMedia {
    
    objc_setAssociatedObject(self, &cancelPickingMediaKey, cancelPickingMedia, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (WXLCancelPickingMedia)cancelPickingMedia {
    
    return objc_getAssociatedObject(self, &cancelPickingMediaKey);
}

- (void)setDidFinishAppStore:(WXLDidFinishAppStore)didFinishAppStore {
    
    return objc_setAssociatedObject(self, &didFinishAppStoreKey, didFinishAppStore, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (WXLDidFinishAppStore)didFinishAppStore {
    
    return objc_getAssociatedObject(self, &didFinishAppStoreKey);
}

- (NSMutableDictionary *)segueDictionary {
    
    return objc_getAssociatedObject(self, &segueDictionaryKey);
}

- (NSMutableDictionary *)setSegueDictionary {
    
    if (!self.segueDictionary) {
        
        objc_setAssociatedObject(self, &segueDictionaryKey, [NSMutableDictionary dictionary], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return self.segueDictionary;
}

#pragma mark 触摸自动隐藏键盘

- (void)wxl_tapDismissKeyboard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wxl_tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakSelf = self;
    
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
        
        [weakSelf.view addGestureRecognizer:singleTapGR];
    }];
    
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
        
        [weakSelf.view removeGestureRecognizer:singleTapGR];
    }];
}

- (void)wxl_tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

#pragma mark 转场动画

- (void)wxl_addTransitionType:(WXLTransitionType)type direction:(WXLTransitionDirection)direction duration:(NSTimeInterval)duration completion:(WXLTransitionCompletion)completion
{
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.removedOnCompletion = YES;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    switch (type) {
        case WXLTransitionTypeFade:
            animation.type = kCATransitionFade;
            break;
        case WXLTransitionTypePush:
            animation.type = kCATransitionPush;
            break;
        case WXLTransitionTypeCube:
            animation.type = @"cube";
            break;
        case WXLTransitionTypeFlip:
            animation.type = @"oglFlip";
            break;
        case WXLTransitionTypeRipple:
            animation.type = @"rippleEffect";
            break;
        case WXLTransitionTypePageCurl:
            animation.type = @"pageCurl";
            break;
        case WXLTransitionTypePageUnCurl:
            animation.type = @"pageUnCurl";
            break;
        case WXLTransitionTypeSuckEffect:
            animation.type = @"suckEffect";
            break;
        case WXLTransitionTypePageCameraOpen:
            animation.type = @"cameraIrisHollowOpen";
            break;
        case WXLTransitionTypePageCamreaClose:
            animation.type = @"cameraIrisHollowClose";
            break;
        default:
            break;
    }
    
    switch (direction) {
        case WXLTransitionDirectionTop:
            animation.subtype = kCATransitionFromTop;
            break;
        case WXLTransitionDirectionLeft:
            animation.subtype = kCATransitionFromLeft;
            break;
        case WXLTransitionDirectionBottom:
            animation.subtype = kCATransitionFromBottom;
            break;
        case WXLTransitionDirectionRight:
            animation.subtype = kCATransitionFromRight;
            break;
        default:
            break;
    }
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:@"animation"];
    
    if (completion) {
        completion();
    }
}

#pragma mark -.-

- (UIImagePickerController *)wxl_presentImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType allowsEditing:(BOOL)allowsEditing completion:(void (^)(void))completion didFinishPickingMedia:(WXLFinishPickingMedia)finishPickingMedia didCancelPickingMediaWithInfo:(WXLCancelPickingMedia)cancelPickingMedia
{
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        if (![UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]) {
#ifdef DEBUG
            NSLog(@"没有检测到摄像头");
#endif
            return nil;
        }
    }
    
    UIImagePickerController *pickController = [[UIImagePickerController alloc] init];
    [pickController setSourceType:sourceType];
    [pickController setDelegate:self];
    [pickController setAllowsEditing:allowsEditing];
    
    [self presentViewController:pickController animated:YES completion:completion];
    
    self.finishPickingMedia = finishPickingMedia;
    self.cancelPickingMedia = cancelPickingMedia;
    
    return pickController;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        if (self.finishPickingMedia) {
            self.finishPickingMedia(info);
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        if (self.cancelPickingMedia) {
            self.cancelPickingMedia();
        }
    }];
}

#pragma mark - 跳转到SKStoreProductViewController

- (void)wxl_presentAppStoreWithITunesItemIdentifier:(NSInteger)itemIdentifier loading:(WXLLoadingAppStore)loadingAppStore loaded:(WXLLoadedAppStore)loadedAppStore didFinish:(WXLDidFinishAppStore)didFinishAppStore
{
    SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;
    
    NSDictionary *parameters = @{SKStoreProductParameterITunesItemIdentifier: @(itemIdentifier), @"at": @"ct"};
    
    if (loadingAppStore) {
        
        loadingAppStore();
    }
    
    if (didFinishAppStore) {
        
        self.didFinishAppStore = didFinishAppStore;
    }
    
    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError* error) {
        
        if (loadedAppStore) {
            
            loadedAppStore(error);
        }
        
        if (result && !error) {
            
            [self presentViewController:storeViewController animated:YES completion:nil];
        }
    }];
}

#pragma mark SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    
    if (self.didFinishAppStore) {
        
        self.didFinishAppStore();
    }
    
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - StoryboardSegue

- (void)wxl_prepareForSegueWithIdentifier:(NSString *)identifier storyboardSegue:(WXLStoryboardSegue)storyboardSegue
{
    if (!identifier) {
        
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Segue identifier can not be nil" userInfo:nil];
    }
    
    if (!storyboardSegue) {
        
        return ;
    }
    
    NSMutableDictionary *segueDictionary = self.segueDictionary ?: [self setSegueDictionary];
    
    [segueDictionary setObject:storyboardSegue forKey:identifier];
}

- (void)wxl_performSegueWithIdentifier:(NSString *)identifier sender:(id)sender storyboardSegue:(WXLStoryboardSegue)storyboardSegue
{
    if (!identifier) {
        
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Segue identifier can not be nil" userInfo:nil];
    }
    
    if (!storyboardSegue) {
        
        [self performSegueWithIdentifier:identifier sender:sender];
        
        return ;
    }
    
    [self wxl_prepareForSegueWithIdentifier:identifier storyboardSegue:storyboardSegue];
    
    [self performSegueWithIdentifier:identifier sender:sender];
}

- (void)_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (!segue.identifier.length) {
        
        return;
    }
    
    if (!self.segueDictionary || !self.segueDictionary[segue.identifier]) {
        
        return;
    }
    
    WXLStoryboardSegue segueBlock = self.segueDictionary[segue.identifier];
    segueBlock(sender, segue, segue.destinationViewController);
}

__attribute__((constructor))
void WXL(void) {
    
    Class currentClass = [UIViewController class];
    
    SEL originalSel = @selector(prepareForSegue:sender:);
    SEL swizzledSel = @selector(_prepareForSegue:sender:);
    
    Method originalMethod = class_getInstanceMethod(currentClass, originalSel);
    IMP swizzledImplementation = class_getMethodImplementation(currentClass, swizzledSel);
    
    method_setImplementation(originalMethod, swizzledImplementation);
}

@end

@interface UINavigationController () <UINavigationBarDelegate>

@end

@implementation UINavigationController (ShouldPopOnBackButton)

/**
 *  感谢https://github.com/onegray/UIViewController-BackButtonHandler
 */
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    if (self.viewControllers.count < navigationBar.items.count) {
        
        return YES;
    }
    
    BOOL shouldPop = YES;
    
    UIViewController *viewController = self.topViewController;
    
    if ([viewController respondsToSelector:@selector(wxl_navigationShouldPopOnBackButton)]) {
        
        shouldPop = [viewController wxl_navigationShouldPopOnBackButton];
    }
    
    if (shouldPop) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
        
    } else {
        
        for (UIView *subView in [navigationBar subviews]) {
            
            if (subView.alpha < 1.0) {
                
                [UIView animateWithDuration:0.25 animations:^{
                    subView.alpha = 1.0;
                }];
            }
        }
    }
    
    return NO;
}

@end
