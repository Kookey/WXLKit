//
//  AppDelegate+Service.m
//  WXLKitDemo
//
//  Created by lemo-wu on 2017/9/30.
//  Copyright © 2017年 Lemo. All rights reserved.
//

#import "AppDelegate+Service.h"
#import "WXLHttpManager.h"

@implementation AppDelegate (Service)

-(void) initHttp
{
    //初始化接口地址
    [[HttpManagerConfig sharedConfig] setUrl:@"http://localhost:8080"];
}

@end
