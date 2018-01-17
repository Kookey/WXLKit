//
//  main.m
//  WXLKitDemo
//
//  Created by lemo-wu on 2017/9/29.
//  Copyright © 2017年 Lemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DateKit.h"

int main(int argc, char * argv[]) {
     {
      
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
      NSString *result = [DateKit dateDisplayResult:1501553410];
      NSLog(@"%@", result);
      return 0;
    }
}
