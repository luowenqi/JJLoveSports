//
//  DJFNetWorkManager.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/11.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface DJFNetWorkManager : AFHTTPSessionManager
/**
 工厂方法
 
 @return DNSHttpTools
 */
+ (instancetype) sharedManager;


/**
 网络中间层,普通请求
 @param url url字符串
 @param method 请求方式
 @param parameters 请求参数的字典
 @param callBack 完成回调
 */
- (void) reqeustWith: (NSString *)url
              method: (NSString *)method
          parameters: (NSDictionary *) parameters
            callBack: (void(^)(id response)) callBack;
/**
 网络中间层，带POST请求
 @param url url字符串
 @param method 请求方式
 @param parameters 请求参数的字典
 @param callBack 完成回调
 */
- (void) reqeustJosnWith: (NSString *)url
                  method: (NSString *)method
              parameters: (NSDictionary *) parameters
                callBack: (void(^)(id response)) callBack;

/**
 监听网络状态
 
 @param compeletiom 正常网络下的操作
 */
-(void)checkNewWorkCompeletion:(void(^)())compeletiom;

@end
