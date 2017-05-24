//
//  DJFSportTrackingLineModel.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/1.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DJFSportPolyLine;
@interface DJFSportTrackingLineModel : NSObject

/**
 *  折线
 */
@property(nonatomic,strong)DJFSportPolyLine * polyLine;



/**
 轨迹线条速度  单位 m/s
 */
@property(nonatomic,assign,readonly)double speed;


/**
 轨迹线条距离  单位 m
 */
@property(nonatomic,assign,readonly)double distance;

/**
 轨迹线条时间  单位 s
 */
@property(nonatomic,assign,readonly)double time;

/**
 *  起点
 */
@property(nonatomic,strong)CLLocation * startLocation;
/**
 *  终点
 */
@property(nonatomic,strong)CLLocation * endLocation;

/**
 *  <#名称#>
 */
@property(nonatomic,strong)UIColor *lineColor;

/**
 *  <#名称#>
 */
@property(nonatomic,strong)CLLocation *lastLocaion;
- (instancetype)initWithStartLocation:(CLLocation*)startLocation andEndLocation:(CLLocation*)endLocation;

@end
