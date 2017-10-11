//
//  CaptchaAlertView.m
//  zuzu
//
//  Created by lemo-wu on 2017/9/18.
//  Copyright © 2017年 ycj. All rights reserved.
//

#import "CaptchaAlertView.h"
#import "UIView+WXL.h"
#import "UIColor+WXL.h"
#import "NSString+WXL.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "WXLMacro.h"

@interface CaptchaAlertView ()

@property(nonatomic,strong) UIView *contentView;
/** 左边按钮title */
@property (nonatomic,copy)   NSString *cancle;
/** 右边按钮title */
@property (nonatomic,copy)   NSString *ok;

@property (nonatomic,copy) NSString *message;

@property (nonatomic,copy) NSString *url;

@end

const NSInteger kMaxByteOfAlarmName = 4;

@implementation CaptchaAlertView

-(instancetype)initWithTitle:(NSString *)message delegate:(id)d cancle:(NSString *)cancleTitle ok:(NSString *) okTitle url:(NSString *) url
{
    if (self=[super init]) {
        self.cancle = cancleTitle;
        self.ok = okTitle;
        self.delegate = d;
        self.message = message;
        self.url = url;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardDidHideNotification object:nil];
        // UI搭建
        [self setUpUI];
    }
    return self;
}

-(void) setUpUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.frame = CGRectMake((WXLScreenWidth-300)/2, (WXLScreenHeight-210)/2, 300, 220);
    self.contentView.center = self.center;
    [self addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 5;
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.contentView.wxl_width, 22)];
    [self.contentView addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.message;
    
    
    self.captchaImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.contentView.wxl_width-108)/2, titleLabel.wxl_bottom+14, 108, 40)];
    self.captchaImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeCaptcha:)];
    [self.captchaImageView addGestureRecognizer:recognizer];
    
    [self.contentView addSubview:self.captchaImageView];
    //验证码输入框
    self.captchaTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, self.captchaImageView.wxl_bottom+13, self.contentView.wxl_width-40, 40)];
    [self.captchaTextField setBackgroundColor:[UIColor wxl_colorWithHexString:@"f5f5f5"]];
    self.captchaTextField.layer.cornerRadius = 5;
    UIColor *color = [UIColor wxl_colorWithHexString:@"909090"];
    NSDictionary *attrs = @{NSForegroundColorAttributeName:color};
    NSAttributedString *placeholder = [[NSAttributedString alloc]initWithString:@"请输入4位验证码" attributes:attrs];
    [self.captchaTextField setAttributedPlaceholder:placeholder];
    [self.captchaTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.captchaTextField addTarget:self action:@selector(onTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:self.captchaTextField];
    
    //设置水平分割线
    UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.captchaTextField.wxl_bottom+15, self.contentView.wxl_width, 0.5)];
    [horizontalLine setBackgroundColor:[UIColor wxl_colorWithHexString:@"dcdcdc"]];
    [self.contentView addSubview:horizontalLine];
    
    
    //取消
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, horizontalLine.wxl_bottom, 149.75, 60)];
    [self.contentView addSubview:cancleBtn];
    [cancleBtn setTitle:self.cancle forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor wxl_colorWithHexString:@"646464"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    
    //设置垂直分割线
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(149.75+0.5, self.captchaTextField.wxl_bottom+15, 0.5, 60)];
    [verticalLine setBackgroundColor:[UIColor wxl_colorWithHexString:@"dcdcdc"]];
    [self.contentView addSubview:verticalLine];
    
    //确定按钮
    UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(150.25, horizontalLine.wxl_bottom, 150, 60)];
    [self.contentView addSubview:okBtn];
    [okBtn setTitle:self.ok forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor wxl_colorWithHexString:@"7ecef4"] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)loadCaptcha:(NSString *)phone
{
    _phone = phone;
    [self refreshCaptcha];

}

-(void)refreshCaptcha
{
    if([self.phone isNotBlank])
    {
        NSString *captchaUrl = [NSString stringWithFormat:@"%@?phone=%@",self.url,self.phone];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [NSURL URLWithString:captchaUrl];
        NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSData *data = [NSData dataWithContentsOfURL:location];
                UIImage *img = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.captchaImageView setImage:img];
                });
            }else
            {
                WXLLog(@"captcha load error :%@", error);
            }
        }];
        [task resume];
    }
}

-(void) cancelBtnClicked
{
    if ([self.delegate respondsToSelector:@selector(onClick:clickedAtIndex:)]) {
        [self.delegate onClick:self clickedAtIndex:CANCLE];
    }
    [self dismiss];
}

-(void)okBtnClicked
{
    if ([self.delegate respondsToSelector:@selector(onClick:clickedAtIndex:)]) {
        self.sendBtn.userInteractionEnabled = false;
        [self.delegate onClick:self clickedAtIndex:OK];
    }
    [self dismiss];
}

-(void)changeCaptcha:(UIGestureRecognizer *) tap
{
    [self refreshCaptcha];
}

-(void) keyboardWillShow:(NSNotification *) notification
{
    // 获取到了键盘frame
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = frame.size.height;
    
    self.contentView.wxl_bottom = (WXLScreenHeight - keyboardHeight)-15;
}

-(void)keyboardWillHidden:(NSNotification *)notification
{
     self.contentView.wxl_bottom = WXLScreenHeight / 2 + self.contentView.wxl_size.height/2;
}

-(void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

- (void)dismiss{
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.captchaTextField resignFirstResponder];
}

-(void) onTextFieldChanged:(UITextField *)textField
{
    NSString * temp = textField.text;
    if (textField.markedTextRange ==nil)
    {
        while(1)
        {
            if ([temp lengthOfBytesUsingEncoding:NSUTF8StringEncoding] <= kMaxByteOfAlarmName) {
                break;
            }
            else
            {
                temp = [temp substringToIndex:temp.length-1];
            }
        }
        textField.text=temp;
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
