//
//  UIViewController+WXLPlaceholderView.h
//  WXLPlaceholderView
//
//  Created by 李蒙 on 15/6/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXLPlaceholderView.h"

@interface UIViewController (WXLPlaceholderView)

@property (strong, nonatomic) WXLPlaceholderView *wxl_placeholderView;

- (void)wxl_showPlaceholderInitWithBackgroundColor:(UIColor *)color imageName:(NSString *)imageName andTitle:(NSString *)title andRefresBlock:(dispatch_block_t)block;

- (void)wxl_showPlaceholderInitWithBackgroundColor:(UIColor *)color imageName:(NSString *)imageName andTitle:(NSString *)title andFrame:(CGRect)frame andRefresBlock:(dispatch_block_t)block;

- (void)wxl_showPlaceholderInitWithImageName:(NSString *)imageName andTitle:(NSString *)title andRefresBlock:(dispatch_block_t)block;

- (void)wxl_showPlaceholderInitWithImageName:(NSString *)imageName andTitle:(NSString *)title andFrame:(CGRect)frame andRefresBlock:(dispatch_block_t)block;

- (void)wxl_hidePlaceholder;

@end
