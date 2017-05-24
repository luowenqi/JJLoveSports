//
//  DJFFoodTypeModel.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/11.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJFFoodInfoModel.h"
@interface DJFFoodTypeModel : NSObject


@property(nonatomic,copy)NSString* tid;
@property(nonatomic,copy)NSArray<DJFFoodInfoModel*>* typeInfo;
@property(nonatomic,copy)NSString* type;
@property(nonatomic,copy)NSString* subTitle;
@property(nonatomic,copy)NSString* title;

@end
