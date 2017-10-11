//
//  UIImageView+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIImageView+WXL.h"

@implementation UIImageView (WXL)

#pragma mark 圆角

- (void)wxl_circle
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width * .5;
}

- (void)lm_circleWithRadius:(CGFloat)radius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

#pragma mark 非圆角

- (void)wxl_circleNot
{
    self.layer.cornerRadius = 0.0;
    self.layer.borderWidth = 0.0;
}

@end
