//
//  WXLWebViewControllerVC.m
//  WXLKitDemo
//
//  Created by lemo-wu on 2017/10/9.
//  Copyright © 2017年 Lemo. All rights reserved.
//

#import "WXLWebViewControllerVC.h"
#import "WXLKit.h"

@interface WXLWebViewControllerVC ()

@end

@implementation WXLWebViewControllerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WXLWebViewController *webVC = [WXLWebViewController webViewControllerLoadRequestsURL:@"http://www.baidu.com"];
    webVC.wxl_showHtmlTitle = YES;
    webVC.wxl_showGoBack = YES;
    webVC.wxl_progressBarTintColor = self.navigationController.navigationBar.tintColor;
    
    [self.navigationController pushViewController:webVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
