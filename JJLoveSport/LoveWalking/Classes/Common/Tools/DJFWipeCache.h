//
//  DJFWipeCache.h
//  LoveWalking
//
//  Created by 陈逸麒 on 2017/5/13.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJFWipeCache : NSObject
+ (instancetype)shareWipeCache;
/**
 显示缓存大小

 @return 缓存大小
 */
-(float)filePath;

/**
 清理缓存
 */
- (void)alertViewWithController:(UIViewController*)viewController;

@end
