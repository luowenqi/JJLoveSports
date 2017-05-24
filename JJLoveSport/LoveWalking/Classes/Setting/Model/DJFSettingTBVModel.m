//
//  DJFSettingTBVModel.m
//  LoveWalking
//
//  Created by 陈逸麒 on 2017/5/13.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFSettingTBVModel.h"

@implementation DJFSettingTBVModel

-(NSArray *)getSettingModelArr{
    
    
    //URL
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"DJFSettingTBVCellList" withExtension:@"plist"];
    
    //加载到数组
    NSArray *arr = [NSArray arrayWithContentsOfURL:url];
    
    //定义模型数组接受对象
    NSMutableArray *arrM = [NSMutableArray array];
    
    //遍历注入数据
    for (NSDictionary *dict in arr) {
        
        DJFSettingTBVModel *model = [[DJFSettingTBVModel alloc]init];
        
        [model setValuesForKeysWithDictionary:dict];
        
        //添加到数组
        [arrM addObject:model];
    }
    return arrM;
}

@end
