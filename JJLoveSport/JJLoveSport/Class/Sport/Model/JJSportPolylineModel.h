//
//  JJSportPolylineModel.h
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/11.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJSportPolylineModel : NSObject


/**
 单词运动线条
 */
@property(nonatomic , strong) MAPolyline * polyLine;



/**
 单次画线的速度
 */
@property(nonatomic , assign) CGFloat  speed;


/**
单次画线消耗的时间
 */
@property(nonatomic , assign) CGFloat  time;


/**
 单次画线距离
 */
@property(nonatomic , assign) CGFloat  distance;


/**
 单次画线的颜色
 */
@property(nonatomic , strong) UIColor * color;

/**
指定初始化方法
 */
-(instancetype)initWithStartLocation:(CLLocation*)startLocation endLocation:(CLLocation*)endLocation;



@end
