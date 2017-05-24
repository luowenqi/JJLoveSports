//
//  DJFProgressHUD.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/11.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJFProgressHUD : NSObject
/**
 消息弹框
 
 @param message 消息内容
 */
+(void)showMessage:(NSString *)message;

/**
 带遮罩效果成功消息弹框
 
 @param message 消息内容
 */
+(void)showMessageWithConver:(NSString *)message;

/**
 失败消息弹框
 
 @param message 消息内容
 */
+(void)showErrorMessage:(NSString *)message;

/**
 带遮罩效果失败消息弹框
 
 @param message 消息内容
 */
+(void)showErrorMessageWithConver:(NSString *)message;

/**
 成功消息弹框
 
 @param message 消息内容
 */
+(void)showSuccessMessage:(NSString *)message;

/**
 带遮罩效果成功消息弹框
 
 @param message 消息内容
 */
+(void)showSuccessMessageWithConver:(NSString *)message;



@end
