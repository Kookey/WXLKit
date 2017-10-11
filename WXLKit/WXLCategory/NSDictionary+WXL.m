//
//  NSDictionary+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/17.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "NSDictionary+WXL.h"

@implementation NSDictionary (WXL)

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [strM appendFormat:@"\n\t%@ = %@\n", key, obj];
        } else {
            [strM appendFormat:@"\t%@ = %@;\n", key, obj];
        }
        
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}

#pragma 转为字符串

- (NSString *)wxl_JSONString
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!jsonData) {
#ifdef DEBUG
        NSLog(@"fail to lm_JSONString from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

@end
