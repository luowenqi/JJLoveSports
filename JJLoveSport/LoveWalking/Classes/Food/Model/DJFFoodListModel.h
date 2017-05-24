//
//  DJFFoodListModel.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/11.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJFFoodListModel : NSObject
@property(nonatomic,copy)NSString* lId;
@property(nonatomic,copy)NSString* foodId;
//食材名称
@property(nonatomic,copy)NSString* name;
//重量
@property(nonatomic,copy)NSString* weight;
//添加时间
@property(nonatomic,copy)NSString* addDate;

@end
