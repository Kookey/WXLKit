//
//  CaptchaAlertView.h
//  zuzu
//
//  Created by lemo-wu on 2017/9/18.
//  Copyright © 2017年 ycj. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 弹出框取消,同意按钮
 **/
typedef NS_ENUM(NSInteger, ButtonType)
{
    OK = 0,
    CANCLE = 1
};


@class CaptchaAlertView;
@protocol CaptchaAlertViewDelegate <NSObject>

-(void) onClick:(CaptchaAlertView*) alertView clickedAtIndex:(NSInteger) index;

@end

@interface CaptchaAlertView : UIView

@property(nonatomic, strong) UIImageView *captchaImageView;
@property(nonatomic, strong) UITextField *captchaTextField;
@property(nonatomic, weak) id<CaptchaAlertViewDelegate> delegate;
@property(nonatomic,weak) UIButton* sendBtn;
@property(nonatomic,copy) NSString* phone;


/**
图形验证码弹出框初始化函数

 @param message 标题
 @param delegate 点击事件委托
 @param cancleName 取消按钮的title
 @param okName 确定按钮的title
 @return CaptchaAlertView
 */
- (instancetype)initWithTitle:(NSString *)message delegate:(id)delegate cancle:(NSString *)cancleName ok:(NSString *)okName url:(NSString *) url;
-(void) loadCaptcha:(NSString *) phone;

/** show出这个弹窗 */
- (void)show;

@end
