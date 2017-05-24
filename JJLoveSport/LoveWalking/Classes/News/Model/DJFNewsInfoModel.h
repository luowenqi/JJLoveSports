//
//  DJFNewsInfoModel.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/12.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJFNewsInfoModel : NSObject
//编号
@property(nonatomic,copy)NSString* nId;
//标题
@property(nonatomic,copy)NSString* title;
//图片
@property(nonatomic,copy)NSString* picUrl;
//简介
@property(nonatomic,copy)NSString* descrube;
//数量
@property(nonatomic,copy)NSString* num;
@end
