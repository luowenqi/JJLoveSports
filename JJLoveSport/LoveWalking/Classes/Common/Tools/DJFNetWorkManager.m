//
//  DJFNetWorkManager.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/11.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFNetWorkManager.h"
#import "DJFProgressHUD.h"
@implementation DJFNetWorkManager
/**
 自定义网络单例
 
 @return DNSHttpTools
 */
+ (instancetype) sharedManager {
    static DJFNetWorkManager *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[DJFNetWorkManager alloc] initWithBaseURL:nil];
        tool.requestSerializer.timeoutInterval = 15;
        
        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
        //tool.requestSerializer=[AFJSONRequestSerializer]
    });
    
    return tool;
}
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
            callBack: (void(^)(id response)) callBack {
 
    
    //调用AFN发起GET请求
    if ([method isEqualToString:@"GET"]) {
        [self GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            callBack(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [DJFProgressHUD showErrorMessage:@"获取数据失败或超时"];
            callBack(nil);
        }];
    }
    
    //调用AFN发起post请求
    if ([method isEqualToString:@"POST"]) {
        [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            callBack(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [DJFProgressHUD showErrorMessage:@"获取数据失败或超时"];
            callBack(nil);
        }];
    }
}

/**
 网络中间层,POST请求
 @param url url字符串
 @param method 请求方式
 @param parameters 请求参数的字典
 @param callBack 完成回调
 */
- (void) reqeustJosnWith: (NSString *)url
                  method: (NSString *)method
              parameters: (NSDictionary *) parameters
                callBack: (void(^)(id response)) callBack {
  
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    //调用AFN发起GET请求
    if ([method isEqualToString:@"GET"]) {
        [self GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            callBack(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [DJFProgressHUD showErrorMessage:@"获取数据失败或超时"];
            callBack(nil);
        }];
    }
    
    //调用AFN发起post请求
    if ([method isEqualToString:@"POST"]) {
        [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            callBack(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [DJFProgressHUD showErrorMessage:@"获取数据失败或超时"];
            callBack(nil);
        }];
    }
}


/**
 监听网络状态
 
 @param compeletiom 正常网络下的操作
 */
-(void)checkNewWorkCompeletion:(void(^)())compeletiom{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        
        if(status ==AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            compeletiom();
        }else
        {
            
            [DJFProgressHUD showErrorMessage:@"失去网络连接！"];
            
        }
    }];
}

@end
