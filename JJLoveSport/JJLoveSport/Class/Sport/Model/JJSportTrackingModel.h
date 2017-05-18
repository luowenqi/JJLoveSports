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

//运动类型
typedef enum : NSUInteger {
    JJSportTypeRun,
    JJSportWalk,
    JJSportRiding,
} JJSportType;

//运动状态
typedef enum : NSUInteger {
    JJSportStatePause,
    JJSportStateContinue,
    JJSportStateFinish,
} JJSportState;

typedef enum : NSUInteger {
    JJSportGPSSingalStateClose,
    JJSportGPSSingalStateBad,
    JJSportGPSSingalStateNormal,
    JJSportGPSSingalStateGood,
} JJSportGPSSingalState;



/**
 指定初始化方法
 */
-(instancetype)initWithSportType:(JJSportType)sportType sportState:(JJSportState)sportState;


/**
 可用初始化方法
 */
-(instancetype)initWithSportType:(JJSportType)sportType;


@property(nonatomic , assign) JJSportGPSSingalState  gpsSingalState;

/**
 当前颜色
 */
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


/**
 运动状态
 */
@property(nonatomic , assign) JJSportState  sportState;

@end
































