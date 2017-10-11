//
//  UIColor+HexString.h
//  https://github.com/buhikon/UIColor-HexString
//
//  Created by Buhikon on 2013. 9. 30.
//  Copyright 2013 Buhikon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WXL)

+ (UIColor *)wxl_colorWithHexString:(NSString *)hexString;

/**
 *  产生随机颜色
 *
 *  @return 随机色
 */
+ (UIColor *)lm_colorWithRamdom;

@end
