//
//  JJSportTrackingModel.h
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>



@interface JJSportTrackingModel : NSObject

typedef enum : NSUInteger {
    JJSportTypeRun,
    JJSJJSportWalk,
    JJSJJSportRiding,
} JJSportType;



@property(nonatomic , strong)  UIColor * currentColor;

/**
 运动类型
 */
@property(nonatomic , assign) JJSportType sportType;


/**
 运动类型图片
 */
@property(nonatomic , strong) UIImage * sportTpyeImage;



/**
指定初始化方法
 */
-(instancetype)initWithSportType:(JJSportType)sportType;


/**
进行线条的描绘
 */
-(MAPolyline*)drawPolylineWithLocation:(CLLocation*)location;


/**
 单次运动的总时间
 */
@property(nonatomic , assign)  CGFloat totalTime;

/**
 单词运动总距离
 */
@property(nonatomic , assign) CGFloat  totalDistance;


/**
 单次运动的平均速度
 */
@property(nonatomic , assign) CGFloat  avgSpeed;


/**
 单次运动的总时间
 */
@property(nonatomic , strong) NSString * totalTimeString;


/**
 单次运动最大瞬时速度
 */
@property(nonatomic , assign) CGFloat  maxSpeed;

@end
































