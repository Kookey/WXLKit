//
//  NSString+WXL.m
//  WXLKitDemo
//
//  Created by lemo-wu on 2017/9/29.
//  Copyright © 2017年 Lemo. All rights reserved.
//

#import "NSString+WXL.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (WXL)

- (NSString *)wxl_md5
{
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *md5 = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [md5 appendFormat:@"%02x", result[i]];
    }
    
    return md5;
}

- (NSString *)wxl_sha1
{
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *sha1 = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        
        [sha1 appendFormat:@"%02x", digest[i]];
    }
    
    return sha1;
}
#pragma mark

-(BOOL)isBlank
{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

-(BOOL)isNotBlank
{
    return ![self isBlank];
}

#pragma mark -

-(BOOL)isMobile
{
    return [self validWithRegex:@"^(1)[0-9]{10}$"];
}

-(BOOL) validWithRegex:(NSString *) regex
{
    if ([self isBlank]) {
        return NO;
    }
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

- (BOOL)isURL
{
    return [self validWithRegex:@"^((http)|(https))+:[^\\s]+\\.[^\\s]*$"];
}

- (BOOL)isEmail
{
    return [self validWithRegex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

-(BOOL)isPassword
{
    return [self validWithRegex:@"^([a-zA-Z]|[0-9]){6,12}$"];
}

-(BOOL)isIDCard
{
    return [self validWithRegex:@"^(^[1-9]\\d{5}[1|2]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$"];
}

-(BOOL) isRar
{
    return [self validWithRegex:@"(.*)\\.(rar|zip|7zip|tgz)$"];
}

-(BOOL)isNegativeInteger
{
    return [self validWithRegex:@"^-[1-9]\\d*$"];
}

-(BOOL)isNumber
{
    return [self validWithRegex:@"^([+-]?)\\d*\\.?\\d+$"];
}

-(BOOL)isPicture
{
    return [self validWithRegex:@"(.*)\\.(jpg|bmp|gif|ico|pcx|jpeg|tif|png|raw|tga)$"];
}

-(BOOL)isChinese
{
    return [self validWithRegex:@"^[\\u4E00-\\u9FA5\\uF900-\\uFA2D]+$"];
}

-(BOOL)isIllegality
{
    return [self validWithRegex:@"^[a-zA-Z0-9\u4e00-\u9fa5]+$"];
}

-(BOOL)isPositive
{
    return [self validWithRegex:@"^[1-9]\\d*$"];
}

-(BOOL)isPayPwd
{
    return [self validWithRegex:@"^\\d{6}$"];
}

#pragma mark -
#pragma mark 写入系统偏好

- (BOOL)wxl_saveUserDefaultsWithKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 获取系统偏好值

- (NSString *)wxl_getUserDefaults
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:self];
}

#pragma mark 去掉字符串两端的空白

- (NSString *)wxl_trimWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark 去掉字符串两端的空白和回车字符

- (NSString *)wxl_trimWhitespaceAndNewline
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 去掉字符串所有的空白字符

- (NSString *)wxl_trimWhitespaceAll
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

#pragma mark 字符串反转

- (NSString *)wxl_reverse
{
    NSMutableString *reverseString = [[NSMutableString alloc] init];
    
    NSInteger charIndex = [self length];
    
    while (charIndex > 0) {
        
        charIndex--;
        NSRange subStringRange = NSMakeRange(charIndex, 1);
        [reverseString appendString:[self substringWithRange:subStringRange]];
    }
    
    return reverseString;
}

#pragma mark 是否包含字符串

- (BOOL)wxl_containsString:(NSString *)aString
{
    NSRange rang = [self rangeOfString:aString];
    
    if (rang.location == NSNotFound) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

#pragma mark -

#pragma mark URLEncode

- (NSURL *)wxl_urlEncode
{
    return [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

#pragma mark - 请求参数

- (NSDictionary *)wxl_requestParams
{
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    for (NSString *pair in pairs) {
        
        NSArray *object = [pair componentsSeparatedByString:@"="];
        NSString *key = [[object objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [params setObject:key forKey:[object objectAtIndex:0]];
    }
    
    return params;
}

#pragma mark - Encode

- (NSString *)wxl_encode
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    
    return encodedString;
}

#pragma mark - Decode

- (NSString *)wxl_decode
{
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

#pragma mark - pinyin

- (NSString *)wxl_pinyinWithPhoneticSymbol
{
    NSMutableString *pinyin = [NSMutableString stringWithString:self];
    
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    
    return pinyin;
}

- (NSString *)wxl_pinyin
{
    NSMutableString *pinyin = [NSMutableString stringWithString:[self wxl_pinyinWithPhoneticSymbol]];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformStripCombiningMarks, NO);
    
    return pinyin;
}

- (NSArray *)wxl_pinyinArray
{
    NSArray *array = [[self wxl_pinyin] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return array;
}

- (NSString *)wxl_pinyinWithoutBlank
{
    NSMutableString *string = [NSMutableString stringWithString:@""];
    
    for (NSString *str in [self wxl_pinyinArray]) {
        
        [string appendString:str];
    }
    
    return string;
}

- (NSArray *)wxl_pinyinInitialsArray
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *str in [self wxl_pinyinArray]) {
        
        if ([str length] > 0) {
            
            [array addObject:[str substringToIndex:1]];
        }
    }
    
    return array;
}

- (NSString *)wxl_pinyinInitialsString
{
    NSMutableString *pinyin = [NSMutableString stringWithString:@""];
    
    for (NSString *str in [self wxl_pinyinArray]) {
        
        if ([str length] > 0) {
            
            [pinyin appendString:[str substringToIndex:1]];
        }
    }
    
    return pinyin;
}

@end
