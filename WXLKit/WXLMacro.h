

#ifndef WXWXLacro_h
#define WXWXLacro_h

@import UIKit;

#pragma mark - -.-

#ifndef __OPTIMIZE__

#define WXLLog(format, ...) NSLog(@"[file:%s] \n%s(%d): %@",__FILE__, __FUNCTION__, __LINE__, [NSString stringWithFormat:(format), ##__VA_ARGS__])

#else

#define WXLLog(...)

#endif

#define WXLScreenWidth [UIScreen mainScreen].bounds.size.width
#define WXLScreenHeight [UIScreen mainScreen].bounds.size.height
#define WXLScreenSize [UIScreen mainScreen].bounds.size
#define WXLScreenBounds [UIScreen mainScreen].bounds

//  当前视图 —— 宽度
#define WXLViewWidth self.bounds.size.width
//  当前视图 —— 高度
#define WXLViewHeight self.bounds.size.height

#define WXLiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define WXLiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define WXLScreenMax (MAX(WXLScreenWidth, WXLScreenHeight))
#define WXLScreenMin (MIN(WXLScreenWidth, WXLScreenHeight))

#pragma mark - 设备判断

#define WXLiPhone4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define WXLiPhone5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define WXLiPhone6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define WXLiPhone6Plus ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

#define WXLiOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#pragma mark - 字体设置

// 设置字体
#define WXLFont(font) [UIFont systemFontOfSize:font]
// 适配字体
#define WXLFitFont(a) [UIFont systemFontOfSize:((IS_IPHONE_6PLUS) ? (a + 2) : a)]
// 适配字体字号
#define WXLFitFontSize(a) ((IS_IPHONE_6PLUS) ? (a + 2) : a)
//一些常用字体
#define WXLFONT10  [UIFont systemFontOfSize:10.0f]
#define WXLFONT11  [UIFont systemFontOfSize:11.0f]
#define WXLFONT12  [UIFont systemFontOfSize:12.0f]
#define WXLFONT14  [UIFont systemFontOfSize:14.0f]
#define WXLFONT16  [UIFont systemFontOfSize:16.0f]
#define WXLFONT18  [UIFont systemFontOfSize:18.0f]
#define WXLFONT20  [UIFont systemFontOfSize:20.0f]

//字体的
#define  isBlank(string) string == nil || string == NULL ||[string isKindOfClass:[NSNull class]]|| [string isEqualToString:@""] ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? YES : NO
#define isNotBlank(string) string == nil || string == NULL ||[string isKindOfClass:[NSNull class]]|| [string isEqualToString:@""] ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? NO : YES

//weak and strong
#define WXLWeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define WXLStrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#define WXLBlock_Safe_Run(block, ...) block ? block(__VA_ARGS__) : nil

#pragma mark - -.-

#define WXLSingletonInterface(className) + (instancetype)shared##className;

#if __has_feature(objc_arc)
#define WXLSingletonImplementation(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
}
#else
#define WXLSingletonImplementation(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
} \
- (oneway void)release {} \
- (instancetype)retain {return instance;} \
- (instancetype)autorelease {return instance;} \
- (NSUInteger)retainCount {return ULONG_MAX;}

#endif

#endif
