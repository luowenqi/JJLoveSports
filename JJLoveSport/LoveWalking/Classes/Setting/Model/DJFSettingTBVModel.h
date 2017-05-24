//
//  DJFSettingTBVModel.h
//  LoveWalking
//
//  Created by 陈逸麒 on 2017/5/13.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJFSettingTBVModel : NSObject

/**
 TBcell的图标
 */
@property(nonatomic,copy)NSString *icon;

/**
 TBcell的图片名字
 */
@property(nonatomic,copy)NSString *name;

/**
 模型类自己获取模型数组

 @return 返回模型数组
 */
-(NSArray *)getSettingModelArr;

@end
