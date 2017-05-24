//
//  NSObject+Property2Method.h
//  交换方法实现黑魔法
//
//  Created by 陈乾 on 2017/2/6.
//  Copyright © 2017年 陈乾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property2Method)

-(NSArray *)getAllPropertyList;

-(NSArray *)getAllMethodList;

-(NSDictionary *)getAllIvarList;

@end
