#import <Foundation/Foundation.h>

@interface DESECB : NSObject
/**
 *  DES 原始方法
 *  DES加密算法： ECB模式
 */
//加密
+(NSString *)encrypt:(NSString *)content key:(NSString *)key;
//解密
+(NSString*)decrypt:(NSString*)content key:(NSString*)key;
@end
