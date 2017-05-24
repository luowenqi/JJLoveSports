//
//  DJFSportTrackingModel.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/1.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DJFSportPolyLine;
#import "DJFSportTrackingLineModel.h"

typedef NS_ENUM(NSInteger,SportState) {
    SportStateContinue = 1,//继续/运动中
    SportStatePause ,//暂停
    SportStateFinish,//结束
};
//运动类型
typedef enum : NSUInteger {
    DJFSportTypeWalk = 1,
    DJFSportTypeRun,
    DJFSportTypeBike,
} DJFSportType;
//GPS信号强度

typedef enum : NSUInteger {
    DJFSPortGPSStateDisconnect = 1, //无信号
    DJFSPortGPSStateBad, //差
    DJFSPortGPSStateNormal, //正常
    DJFSPortGPSStateGood //好
} DJFSPortGPSState;
@interface DJFSportTrackingModel : NSObject
/**
 *  运动类型图片
 */
@property(nonatomic,strong)UIImage * sportIcon;

/**
 *  起始位置
 */
@property(nonatomic,strong,readonly)CLLocation * sportStartLocation;

/**
 *  上次起始坐标
 */
@property(nonatomic,strong)CLLocation * LastStartLocation;

- (instancetype)initWithType:(DJFSportType)sportType;

/**
 *  运动类型
 */
@property(nonatomic,assign)DJFSportType sportType;
/**
 运动总距离 单位:km
 */
@property(nonatomic,assign,readonly)double totalDistance;


/**
 运动总时间 单位:s
 */
@property(nonatomic,assign,readonly)double totalTime;


/**
 运动时间字符串 格式:xx时xx分xx秒
 */
@property(nonatomic,strong,readonly)NSString *totalTimeStr;


/**
 平均速度
 */
@property(nonatomic,assign,readonly)double avgSpeed;

/**
 最大速度
 */
@property(nonatomic,assign,readonly)double maxSpeed;

/**
 最大速度
 */
@property(nonatomic,assign,readonly)NSInteger stepCount;

//GPS信号强度
@property(nonatomic,assign,readonly)DJFSPortGPSState gpsSignalState;
//运动轨迹的绘制
- (DJFSportPolyLine *)drawPolylineWithLocation:(CLLocation *)location;

/**
 *  定时器
 */
@property(nonatomic,strong)CADisplayLink * sportTimeDisplayLink;


/**
 *  最终运动结果
 */
@property(nonatomic,copy)void(^sportResult)(DJFSportTrackingModel* model);

/**
 *  是否暂时
 */
@property(nonatomic,assign,getter=isPause)BOOL Pause;

/**
 运动状态
 */
@property(nonatomic,assign)SportState sportstate;
/**
 *  线条数组
 */

@property(nonatomic,copy)NSMutableArray<DJFSportTrackingLineModel *> *polyLineList;

@end
