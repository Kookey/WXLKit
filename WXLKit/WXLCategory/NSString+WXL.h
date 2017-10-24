//
//  NSString+WXL.h
//  WXLKitDemo
//
//  Created by lemo-wu on 2017/9/29.
//  Copyright © 2017年 Lemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define WXLMD5(string) [string wxl_md5]
#define WXLSHA1(string) [string wxl_sha1]

#define WXLValidNumber(string) [string wxl_validNumber]
#define WXLValidMobile(string) [string wxl_validMobile]
#define WXLValidIdentityCard(string) [string wxl_validIdentityCard]
#define WXLValidURL(string) [string wxl_validURL]
#define WXLValidEMail(string) [string wxl_validEMail]

#define WXLDocumentsFile(name) [name wxl_documentsFile]
#define WXLRemoveDocumentsFile(file) [file wxl_removeDocumentsFile]
#define WXLSaveUserDefaults(string,key) [string wxl_saveUserDefaultsWithKey:key]
#define WXLGetUserDefaults(key) [key wxl_getUserDefaults]

#define WXLTrimWhitespaceAndNewline(string) [string wxl_trimWhitespaceAndNewline]
#define WXLTrimWhitespaceAll(string) [string wxl_trimWhitespaceAll]

#define WXLEncode(string) [string wxl_encode]
#define WXLDecode(string) [string wxl_decode]

@interface NSString (WXL)

/**
 *  MD5
 *
 *  @return NSString
 */
- (NSString *)wxl_md5;

/**
 *  SHA1
 *
 *  @return NSString
 */
- (NSString *)wxl_sha1;

-(BOOL) isMobile;

-(BOOL) validWithRegex:(NSString *) regex;

#pragma mark 是否是身份证号
-(BOOL) isIDCard;

#pragma mark 判断是否是正整数
-(BOOL) isPositive;

#pragma mark 只能包含中文、英文、数字字符
-(BOOL) isIllegality;

#pragma mark 验证是不是负整数
-(BOOL) isNegativeInteger;

#pragma mark 验证是不是数字
-(BOOL) isNumber;

-(BOOL) isChinese;

-(BOOL) isEmail;

-(BOOL) isPicture;

#pragma mark 判断是否是压缩文件
-(BOOL) isRar;

#pragma mark 判断是否是URL
-(BOOL) isURL;

#pragma mark 判断是否是支付密码
-(BOOL) isPayPwd;

#pragma mark 判断是否是登录密码
-(BOOL) isPassword;

- (BOOL)wxl_saveUserDefaultsWithKey:(NSString *)key;

- (NSString *)wxl_getUserDefaults;

- (NSString *)wxl_trimWhitespace;

- (NSString *)wxl_trimWhitespaceAndNewline;

- (NSString *)wxl_trimWhitespaceAll;

- (NSString *)wxl_reverse;

- (BOOL)wxl_containsString:(NSString *)aString;

/**
 *  URLEncode
 *
 *  @return NSString
 */
- (NSURL *)wxl_urlEncode;

/**
 *  请求参数
 *
 *  @return NSDictionary
 */
- (NSDictionary *)wxl_requestParams;

/**
 *  Encode
 *
 *  @return NSString
 */
- (NSString *)wxl_encode;

/**
 *  Decode
 *
 *  @return NSString
 */
- (NSString *)wxl_decode;

#pragma mark - pinyin

/**
 *  中文->zhōng wén
 *
 *  @return e.g.@"zhōng wén"
 */
- (NSString *)wxl_pinyinWithPhoneticSymbol;

/**
 *  中文->zhong wen
 *
 *  @return e.g.@"zhong wen"
 */
- (NSString *)wxl_pinyin;

/**
 *  中文->[@"zhong", @"wen"]
 *
 *  @return e.g.@[@"zhong", @"wen"]
 */
- (NSArray *)wxl_pinyinArray;

/**
 *  中文->zhongwen
 *
 *  @return e.g.@"zhongwen"
 */
- (NSString *)wxl_pinyinWithoutBlank;

/**
 *  中文->[@"z", @"w"]
 *
 *  @return e.g.@[@"z", @"w"]
 */
- (NSArray *)wxl_pinyinInitialsArray;

/**
 *  中文->zw
 *
 *  @return e.g.@"zw"
 */
- (NSString *)wxl_pinyinInitialsString;

@end
