//
//  DJFFoodInfoModel.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/11.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFFoodInfoModel.h"

@implementation DJFFoodInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"foodList":[DJFFoodListModel class]};
}
- (NSString *)description{
    return   [self yy_modelDescription];
}
@end
