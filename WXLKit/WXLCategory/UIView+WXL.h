//
//  UIView+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/21.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^wxl_TapGestureBlock)(UITapGestureRecognizer *gestureRecognizer);
typedef void(^wxl_LongPressGestureBlock)(UILongPressGestureRecognizer *gestureRecognizer);
typedef void(^wxl_PanGestureBlock)(UIPanGestureRecognizer *gestureRecognizer);

@interface UIView (WXL)

#pragma mark - frame

@property (nonatomic, assign) CGPoint wxl_origin;
@property (nonatomic, assign) CGSize wxl_size;

@property (nonatomic) CGFloat wxl_width;
@property (nonatomic) CGFloat wxl_height;

@property (nonatomic) CGFloat wxl_centerX;
@property (nonatomic) CGFloat wxl_centerY;

@property (nonatomic) CGFloat wxl_top;
@property (nonatomic) CGFloat wxl_bottom;
@property (nonatomic) CGFloat wxl_left;
@property (nonatomic) CGFloat wxl_right;

#pragma mark - TapGesture

/**
 *  TapGesture回调
 *
 *  @param tapAction wxl_TapGestureBlock
 *
 *  @return UITapGestureRecognizer
 */
- (UITapGestureRecognizer *)wxl_addTapGesture:(wxl_TapGestureBlock)tapAction;

/**
 *  LongPressGesture回调
 *
 *  @param longPressAction wxl_LongPressGestureBlock
 *
 *  @return UILongPressGestureRecognizer
 */
- (UILongPressGestureRecognizer *)wxl_addLongPressGesture:(wxl_LongPressGestureBlock)longPressAction;

/**
 *  PanGesture回调
 *
 *  @param panAction lm_GestureBlock
 *
 *  @return UIPanGestureRecognizer
 */
- (UIPanGestureRecognizer *)wxl_addPanGesture:(wxl_PanGestureBlock)panAction;

#pragma mark - animation

/**
 *  shakeView
 */
- (void)wxl_shakeAnimation;

/**
 *  popAnimation
 */
- (void)wxl_popAnimation;

@end
