//
//  DJFFoodInfoModel.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/11.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJFFoodListModel.h"
@interface DJFFoodInfoModel : NSObject
@property(nonatomic,copy)NSString* fId;
@property(nonatomic,copy)NSString* typeId;
//标题
@property(nonatomic,copy)NSString* title;
//点赞数量
@property(nonatomic,copy)NSString* praiseNum;
//简介
@property(nonatomic,copy)NSString* describe;
//图片
@property(nonatomic,copy)NSString* imgUrl;
//烹饪时间
@property(nonatomic,copy)NSString* time;
//卡路里
@property(nonatomic,copy)NSString* calorie;
//碳水
@property(nonatomic,copy)NSString* carbon;
//蛋白质
@property(nonatomic,copy)NSString* protein;
//脂肪
@property(nonatomic,copy)NSString* fat;
//添加时间
@property(nonatomic,copy)NSString* addDate;
//食材明细
@property(nonatomic,copy)NSArray<DJFFoodListModel*>* foodList;

@end
