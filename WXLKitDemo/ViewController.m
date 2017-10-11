//
//  ViewController.m
//  WXLKitDemo
//
//  Created by lemo-wu on 2017/9/29.
//  Copyright © 2017年 Lemo. All rights reserved.
//

#import "ViewController.h"
#import "WXLKit.h"

@interface ViewController () <CaptchaAlertViewDelegate>
- (IBAction)logAction:(id)sender;
- (IBAction)httpGetAction:(id)sender;
- (IBAction)showCaptcha:(id)sender;
- (IBAction)loadRemoteHTMLAction:(id)sender;
- (IBAction)loadLocalHTML:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *limitLengthField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.limitLengthField wxl_limitLength:4];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)logAction:(id)sender {
    WXLLog(@"HELLO LOG");
}

- (IBAction)httpGetAction:(id)sender {
    WXLLog(@"http get 请求");
    [WXLHttpManager get:@"/index/get" params:nil success:^(id data) {
        WXLLog(@"data:%@", data);
    } failure:^(NSError *error) {
        WXLLog(@"data:%@", error);
    }];
}

- (IBAction)showCaptcha:(id)sender {
    CaptchaAlertView *captchaView = [[CaptchaAlertView alloc] initWithTitle:@"图片验证码" delegate:self cancle:@"取消" ok:@"确定" url:@"http://172.16.1.220:8080/captcha"];
    [captchaView loadCaptcha:@"18502107032"];
    [captchaView show];
   
}


/**
 加载远程 html
 */
- (IBAction)loadRemoteHTMLAction:(id)sender {
    WXLWebViewController *webVC = [WXLWebViewController webViewControllerLoadRequestsURL:@"http://www.baidu.com"];
    webVC.wxl_showHtmlTitle = YES;
    webVC.wxl_showGoBack = YES;
    webVC.wxl_progressBarTintColor = self.navigationController.navigationBar.tintColor;
    
    [self.navigationController pushViewController:webVC animated:YES];
}


/**
 加载本地html文件
 */
- (IBAction)loadLocalHTML:(id)sender {
    WXLWebViewController *webVC = [WXLWebViewController webViewControllerLoadLocalHtml:@"bac"];
    webVC.wxl_showHtmlTitle = YES;
    webVC.wxl_showGoBack = YES;
    webVC.wxl_progressBarTintColor = self.navigationController.navigationBar.tintColor;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

-(void)onClick:(CaptchaAlertView *)alertView clickedAtIndex:(NSInteger)index
{
    WXLLog(@"index = %lu", index);
}
@end
