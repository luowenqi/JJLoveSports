//
//  NSObject+Property2Method.m
//  交换方法实现黑魔法
//
//  Created by 陈乾 on 2017/2/6.
//  Copyright © 2017年 陈乾. All rights reserved.
//

#import "NSObject+Property2Method.h"
#import <objc/runtime.h>
@implementation NSObject (Property2Method)

-(NSArray *)getAllPropertyList{
    
    //1.创建可变字典接受属性列表
    NSMutableArray *arr  = [NSMutableArray array];
    /*
     2.获取属性列表
     class_copyIvarList() :获取类的成员变量列表
     class_copyPropertyList() :获取类的属性列表
     参数1：表示那个类需要获取
     参数2：表示属性、或者成员变量的个数
     */
    unsigned int count = 0;
    objc_property_t *propertyArr = class_copyPropertyList([self class], &count);
    //3.把属性列表一个一个的存到字典中去
    for (int i = 0; i < count; i++) {
        //获取单个属性
        objc_property_t property = propertyArr[i];
        //获取属性的c语言类型的名字字符串
        const char *property_name_c =  property_getName(property);
        //将属性的名字转换成oc字符串
        NSString *property_name_oc = [NSString stringWithUTF8String:property_name_c];
        
        [arr addObject:property_name_oc];
//        //获取属性的值
//        id property_value = [self valueForKey:property_name_oc];
//        //存到字典
//        [dictM setObject:property_value forKey:property_name_oc];
    }
    return [arr copy];
}


-(NSDictionary *)getAllIvarList{
    
    //1.创建可变字典接受属性列表
    NSMutableDictionary *dictM  = [NSMutableDictionary dictionary];
    /*
     2.获取属性列表
     class_copyIvarList() :获取类的成员变量列表
     class_copyPropertyList() :获取类的属性列表
     参数1：表示那个类需要获取
     参数2：表示属性、或者成员变量的个数
     */
    unsigned int count = 0;
    Ivar *IvarArr = class_copyIvarList([self class], &count);
    //3.把属性列表一个一个的存到字典中去
    for (int i = 0; i < count; i++) {
        //获取单个属性
        Ivar property = IvarArr[i];
        //获取属性的c语言类型的名字字符串
        const char *ivar_name_c = ivar_getName(property)
;
        //将属性的名字转换成oc字符串
        NSString *ivar_name_oc = [NSString stringWithUTF8String:ivar_name_c];
        //获取属性的值
       
        id ivar_value =  [self valueForKeyPath:ivar_name_oc];
        //存到字典
        [dictM setObject:ivar_value forKey:ivar_name_oc];
    }
    return [dictM copy];
}



-(NSArray *)getAllMethodList{
    
    //1.
    NSMutableArray *arrM = [NSMutableArray array];
    //2.
    unsigned int count = 0;
    Method *methodArr = class_copyMethodList([self class], &count);
    //3.
    for (int i=0; i<count; i++) {
        
        Method method = methodArr[i];
        SEL sel = method_getName(method);
        NSString *method_name = NSStringFromSelector(sel);
        [arrM addObject:method_name];
    }
    return [arrM copy];

}

@end
