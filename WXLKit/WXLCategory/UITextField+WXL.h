//
//  UITextField+LM.h
//  WXLCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (WXL)

/**
 *  限制输入长度
 *
 *  @param length 限制长度值
 */
- (void)wxl_limitLength:(NSUInteger)length;

@end
