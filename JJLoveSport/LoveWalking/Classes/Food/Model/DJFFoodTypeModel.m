//
//  DJFFoodTypeModel.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/11.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFFoodTypeModel.h"

@implementation DJFFoodTypeModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"typeInfo":[DJFFoodInfoModel class]};
}
-(NSString *)description{
  return   [self yy_modelDescription];
}
@end
