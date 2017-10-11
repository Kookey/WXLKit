//
//  UIView+wxl.m
//  wxlCategory
//
//  Created by 李蒙 on 15/7/21.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIView+WXL.h"
#import <objc/runtime.h>

@interface UIView ()

@property (copy, nonatomic) wxl_TapGestureBlock tapGestureAction;

@property (copy, nonatomic) wxl_LongPressGestureBlock longPressGestureAction;

@property (copy, nonatomic) wxl_PanGestureBlock panGestureAction;

@end

static char tapGestureBlockKey, longPressGestureBlockKey, panGestureBlockKey;

@implementation UIView (WXL)

#pragma mark - frame

- (CGPoint)wxl_origin {
    
    return self.frame.origin;
}

- (void)setWxl_origin:(CGPoint)wxl_origin {
    
    CGRect frame = self.frame;
    frame.origin = wxl_origin;
    
    self.frame = frame;
}

- (CGSize)wxl_size {
    
    return self.frame.size;
}

- (void)setWxl_size:(CGSize)wxl_size {
    
    CGRect frame = self.frame;
    frame.size = wxl_size;
    
    self.frame = frame;
}

- (CGFloat)wxl_width {
    
    return self.frame.size.width;
}

- (void)setWxl_width:(CGFloat)wxl_width {
    
    CGRect frame = self.frame;
    frame.size.width = wxl_width;

    self.frame = frame;
}

- (CGFloat)wxl_height {
    
    return self.frame.size.height;
}

- (void)setWxl_height:(CGFloat)wxl_height {
    
    CGRect frame = self.frame;
    frame.size.height = wxl_height;
    
    self.frame = frame;
}

- (CGFloat)wxl_centerX {
    
    return self.center.x;
}

- (void)setWxl_centerX:(CGFloat)wxl_centerX {
    
    self.center = CGPointMake(wxl_centerX, self.center.y);
}

- (CGFloat)wxl_centerY {
    
    return self.center.y;
}

- (void)setWxl_centerY:(CGFloat)wxl_centerY {
    
    self.center = CGPointMake(self.center.x, wxl_centerY);
}

- (CGFloat)wxl_top {
    
    return self.frame.origin.y;
}

- (void)setWxl_top:(CGFloat)wxl_top {
    
    CGRect frame = self.frame;
    frame.origin.y = wxl_top;
    
    self.frame = frame;
}

- (CGFloat)wxl_bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setWxl_bottom:(CGFloat)wxl_bottom {
    
    CGRect frame = self.frame;
    frame.origin.y = wxl_bottom - self.frame.size.height;
    
    self.frame = frame;
}

- (CGFloat)wxl_left {
    
    return self.frame.origin.x;
}

- (void)setWxl_left:(CGFloat)wxl_left {
    
    CGRect frame = self.frame;
    frame.origin.x = wxl_left;
    
    self.frame = frame;
}

- (CGFloat)wxl_right {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setWxl_right:(CGFloat)wxl_right {
    
    CGRect frame = self.frame;
    frame.origin.x = wxl_right - self.frame.size.width;
    
    self.frame = frame;
}

#pragma mark -.-

- (void)setTapAction:(wxl_TapGestureBlock)tapAction {
    
    objc_setAssociatedObject(self, &tapGestureBlockKey, tapAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (wxl_TapGestureBlock)tapGestureAction {
    
    return objc_getAssociatedObject(self, &tapGestureBlockKey);
}

- (void)setLongPressGestureAction:(wxl_LongPressGestureBlock)longPressGestureAction {
    
    objc_setAssociatedObject(self, &longPressGestureBlockKey, longPressGestureAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (wxl_LongPressGestureBlock)longPressGestureAction {
    
    return objc_getAssociatedObject(self, &longPressGestureBlockKey);
}

- (void)setPanGestureAction:(wxl_PanGestureBlock)panGestureAction {
    
    objc_setAssociatedObject(self, &panGestureBlockKey, panGestureAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (wxl_PanGestureBlock)panGestureAction {
    
    return objc_getAssociatedObject(self, &panGestureBlockKey);
}

#pragma mark TapGesture回调

- (UITapGestureRecognizer *)wxl_addTapGesture:(wxl_TapGestureBlock)tapAction
{
    self.tapAction = tapAction;
    
    if (![self gestureRecognizers]) {
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wxl_tapGesture:)];
        [self addGestureRecognizer:tapGesture];
        
        return tapGesture;
    }
    
    return nil;
}

#pragma mark LongPressGesture回调

- (UILongPressGestureRecognizer *)wxl_addLongPressGesture:(wxl_LongPressGestureBlock)longPressAction
{
    self.longPressGestureAction = longPressAction;
    
    if (![self gestureRecognizers]) {
        
        self.userInteractionEnabled = YES;
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(wxl_longGesture:)];
        [self addGestureRecognizer:longPressGesture];
        
        return longPressGesture;
    }
    
    return nil;
}

#pragma mark PanGesture回调

- (UIPanGestureRecognizer *)wxl_addPanGesture:(wxl_PanGestureBlock)panAction
{
    self.panGestureAction = panAction;
    
    if (![self gestureRecognizers]) {
        
        self.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(wxl_panGesture:)];
        [self addGestureRecognizer:panGesture];
        
        return panGesture;
    }
    
    return nil;
}

- (void)wxl_tapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    if (self.tapGestureAction) {
        
        self.tapGestureAction(gestureRecognizer);
    }
}

- (void)wxl_longGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (self.longPressGestureAction) {
        
        self.longPressGestureAction(gestureRecognizer);
    }
}

- (void)wxl_panGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (self.panGestureAction) {
        
        self.panGestureAction(gestureRecognizer);
    }
}

#pragma mark -.-

- (void)wxl_shakeAnimation
{
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    shake.autoreverses = YES;
    shake.repeatCount = 2.0f;
    shake.duration = 0.07f;
    
    [self.layer addAnimation:shake forKey:nil];
}

- (void)wxl_popAnimation
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    popAnimation.duration = 0.4;
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    
    [self.layer addAnimation:popAnimation forKey:nil];
}

@end
