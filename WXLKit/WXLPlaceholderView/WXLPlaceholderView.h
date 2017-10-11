//
//  WXLPlaceholderView.h
//  WXLPlaceholderView
//
//  Created by 李蒙 on 15/6/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXLPlaceholderView : UIView

@property (strong, nonatomic) UIImageView *imageView;

- (void)wxl_showViewWithImageName:(NSString *)imageName andTitle:(NSString *)title;

- (void)wxl_hide;

@end
