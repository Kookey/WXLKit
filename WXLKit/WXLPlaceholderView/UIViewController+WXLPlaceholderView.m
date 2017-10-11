//
//  UIViewController+WXLPlaceholderView.m
//  WXLPlaceholderView
//
//  Created by 李蒙 on 15/6/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIViewController+WXLPlaceholderView.h"
#import "WXLKit.h"
#import <objc/runtime.h>

@interface UIViewController ()

@property (copy, nonatomic) dispatch_block_t refreshBlock;

@end

static char const WXLPlaceholderViewKey, WXLRefreshKey;

@implementation UIViewController (WXLPlaceholderView)

- (void)setWxl_placeholderView:(WXLPlaceholderView *)wxl_placeholderView {
    
    objc_setAssociatedObject(self, &WXLPlaceholderViewKey, wxl_placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WXLPlaceholderView *)wxl_placeholderView {
    
    return objc_getAssociatedObject(self, &WXLPlaceholderViewKey);
}

- (void)setRefreshBlock:(dispatch_block_t)refreshBlock {
    
    objc_setAssociatedObject(self, &WXLRefreshKey, refreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (dispatch_block_t)refreshBlock {
    
    return objc_getAssociatedObject(self, &WXLRefreshKey);
}

- (void)wxl_showPlaceholderInitWithBackgroundColor:(UIColor *)color imageName:(NSString *)imageName andTitle:(NSString *)title andFrame:(CGRect)frame andRefresBlock:(dispatch_block_t)block
{
    [self wxl_showPlaceholderInitWithImageName:imageName andTitle:title andFrame:frame andRefresBlock:block];
    
    self.wxl_placeholderView.backgroundColor = color;
}

- (void)wxl_showPlaceholderInitWithBackgroundColor:(UIColor *)color imageName:(NSString *)imageName andTitle:(NSString *)title andRefresBlock:(dispatch_block_t)block
{
    [self wxl_showPlaceholderInitWithImageName:imageName andTitle:title andRefresBlock:block];
    
    self.wxl_placeholderView.backgroundColor = color;
}

- (void)wxl_showPlaceholderInitWithImageName:(NSString *)imageName andTitle:(NSString *)title andRefresBlock:(dispatch_block_t)block
{
    [self wxl_showPlaceholderInitWithImageName:imageName andTitle:title andFrame:CGRectMake(0, 0, WXLScreenWidth, WXLScreenHeight) andRefresBlock:block];
}

- (void)wxl_showPlaceholderInitWithImageName:(NSString *)imageName andTitle:(NSString *)title andFrame:(CGRect)frame andRefresBlock:(dispatch_block_t)block
{
    self.refreshBlock = block;
    
    if (!self.wxl_placeholderView) {
        
        self.wxl_placeholderView = [[WXLPlaceholderView alloc] initWithFrame:frame];
        
        if ([self respondsToSelector:@selector(setTableView:)]) {
            
            if ([((UITableViewController *)self).tableView respondsToSelector:@selector(setScrollEnabled:)]) {
                
                self.wxl_placeholderView.wxl_top = self.wxl_placeholderView.wxl_top - 30;
            }
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshAction)];
        [self.wxl_placeholderView addGestureRecognizer:tap];
        
        [self.view addSubview:self.wxl_placeholderView];
    }
    
    [self setScrollEnabled:NO];
    
    [self.wxl_placeholderView wxl_showViewWithImageName:imageName andTitle:title];
}

- (void)refreshAction
{
    if (self.refreshBlock) {
        
        [self wxl_hidePlaceholder];
        
        self.refreshBlock();
    }
}

- (void)wxl_hidePlaceholder
{
    [self.wxl_placeholderView wxl_hide];
    
    [self setScrollEnabled:YES];
}

- (void)setScrollEnabled:(BOOL)enabled
{
    if ([self respondsToSelector:@selector(setTableView:)]) {
        if ([((UITableViewController *)self).tableView respondsToSelector:@selector(setScrollEnabled:)]) {
            
            [((UITableViewController *)self).tableView setScrollEnabled:enabled];
        }
    }
    
    if ([self respondsToSelector:@selector(setCollectionView:)]) {
        if ([((UICollectionViewController *)self).collectionView respondsToSelector:@selector(setScrollEnabled:)]) {
            
            [((UICollectionViewController *)self).collectionView setScrollEnabled:enabled];
        }
    }
}

@end
