//
//  DJFProgressHUD.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/11.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFProgressHUD.h"
#import <SVProgressHUD.h>
@implementation DJFProgressHUD
/**
 消息弹框
 
 @param message 消息内容
 */
+(void)showMessage:(NSString *)message{
    [SVProgressHUD showInfoWithStatus:message];
    [SVProgressHUD setBackgroundColor:THEME_COLOR];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kMessageBoxTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

/**
 带遮罩效果成功消息弹框
 
 @param message 消息内容
 */
+(void)showMessageWithConver:(NSString *)message{
    [SVProgressHUD showInfoWithStatus:message];
    [SVProgressHUD setBackgroundColor:THEME_COLOR];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kMessageBoxTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


/**
 失败消息弹框
 
 @param message 消息内容
 */
+(void)showErrorMessage:(NSString *)message{
    [SVProgressHUD showErrorWithStatus:message];
    [SVProgressHUD setBackgroundColor:THEME_COLOR];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kMessageBoxTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

/**
 带遮罩效果失败消息弹框
 
 @param message 消息内容
 */
+(void)showErrorMessageWithConver:(NSString *)message{
    
    [SVProgressHUD showErrorWithStatus:message];
    [SVProgressHUD setBackgroundColor:THEME_COLOR];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kMessageBoxTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

/**
 成功消息弹框
 
 @param message 消息内容
 */
+(void)showSuccessMessage:(NSString *)message{
    [SVProgressHUD showSuccessWithStatus:message];
    [SVProgressHUD setBackgroundColor:THEME_COLOR];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kMessageBoxTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
    
}
/**
 带遮罩效果成功消息弹框
 
 @param message 消息内容
 */
+(void)showSuccessMessageWithConver:(NSString *)message{
    
    [SVProgressHUD showSuccessWithStatus:message];
    [SVProgressHUD setBackgroundColor:THEME_COLOR];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kMessageBoxTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

@end
