//
//  UITextField+LM.m
//  WXLCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UITextField+WXL.h"

@implementation UITextField (WXL)

#pragma mark 限制输入长度

- (void)wxl_limitLength:(NSUInteger)length
{
    NSOperationQueue *mainQuene = [NSOperationQueue mainQueue];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
        
        if (self.text.length > length && !self.markedTextRange) {
            
            self.text = [self.text substringWithRange: NSMakeRange(0, length)];
            [self resignFirstResponder];
        }
    }];
}

@end
