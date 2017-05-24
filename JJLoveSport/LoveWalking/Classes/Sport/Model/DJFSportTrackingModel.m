//
//  DJFSportTrackingModel.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/1.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFSportTrackingModel.h"
#import "DJFSportPolyLine.h"
#import "DJFSportTrackingLineModel.h"
#import "DJFStepManager.h"


@interface DJFSportTrackingModel()


//运动起点位置
@property(nonatomic,strong)CLLocation *startLocation;



/**
 *  计步器
 */
@property(nonatomic,strong)DJFStepManager * stepManager;

@end
@implementation DJFSportTrackingModel{
    
    CGFloat GPSDistance;
    CGFloat stepDistence;
    NSInteger lastStepCount;
}

/**
 运动模型
 
 @param sportType 运动类型
 @return 运动模型
 */
-(instancetype)initWithType:(DJFSportType)sportType{
    self = [super init];
    
    //运动类型
    _sportType = sportType;
    
    //计步器
    _stepManager = [DJFStepManager sharedManager];
    [_stepManager startWithStep];
    _polyLineList = [NSMutableArray arrayWithCapacity:100];
    
    //定时器
    __weak typeof(self) weakSelf = self;
    _sportTimeDisplayLink = [CADisplayLink displayLinkWithTarget:weakSelf selector:@selector(sportTimeCount)];
    _sportTimeDisplayLink.frameInterval = 60;
    [_sportTimeDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    //初始化线条记录数组
    _polyLineList = [NSMutableArray arrayWithCapacity:100];
    
    return self;
}

- (void)sportTimeCount{
    if (self.isPause) {
        return;
    }
    _totalTime ++;
    //运动总时间
    NSInteger time = _totalTime;
    _totalTimeStr = [NSString stringWithFormat:@"%02zd:%02zd:%02zd",time/3600,(time%3600)/60,time%60];
    
    //计算每秒步数
    //根据距离修正步数
    _stepCount = _stepCount >(_totalDistance * 1.3)?_stepCount:(_totalDistance* 1.3);
    NSInteger secondStepCount =  [_stepManager step] - lastStepCount;
    lastStepCount =  [_stepManager step];
    
    _stepCount += secondStepCount;
    //NSLog(@"----%zd",secondStepCount);
    //在GPS无法正常运行下，根据步数计算距离和最大速度
    if (_startLocation == nil) {
        _totalDistance += secondStepCount * 0.75;
        _maxSpeed = _maxSpeed > (secondStepCount * 0.75)? _maxSpeed:(secondStepCount * 0.75);
    }
    
    //运动平均速度
    _avgSpeed = _totalDistance / time;
    
    if (self.sportResult) {
        self.sportResult(self);
    }
}
//运动轨迹的绘制
- (DJFSportPolyLine *)drawPolylineWithLocation:(CLLocation *)location{
    
    //若GPS信号差返回
    if ([self getGPSStateByLocation:location ] < DJFSPortGPSStateDisconnect) {
        return  nil;
    }
    if (self.isPause) {
        _startLocation = nil;
        return nil;
    }
    //若速度小于0，返回,防止不移动绘制轨迹
    if (location.speed <= 0) {
        
        return nil;
    }
    //若无起始位置返回
    if (_startLocation == nil) {
        _startLocation = location;
        return nil;
    }
    //创建轨迹线条模型
    DJFSportTrackingLineModel *trackline = [[DJFSportTrackingLineModel alloc]initWithStartLocation:_startLocation andEndLocation:location];
    
    
    
    _startLocation = location;
    
    //判断上次起点和本次起点是否一致，以避免信号差时，出现多张线条
    if (_LastStartLocation!= nil && _LastStartLocation == _startLocation) {
        return nil;
    }
    _LastStartLocation = _startLocation;
    
    //或者GPS正常，取消步数计算
    [_stepManager restStep];
    lastStepCount = 0;

    //根据location计算距离和最大速度
    [self calculateDistanceAndMaxPeedByPolyLineModel:trackline];

    //（BUG）初步判断为线程阻塞，暂时开一个子线程解决无法绘制好好轨迹。
//    dispatch_async(dispatch_get_main_queue(), ^{
//         [self.polyLineList addObject:trackline.polyLine];
//    });
    
    [self.polyLineList addObject:trackline];
   

    //返回
    return trackline.polyLine;
}
//根据步数计算属
- (void)calculateionVariableBySetp{
    [_stepManager getStepDistance];
}
//根据location计算距离和最大速度
- (void)calculateDistanceAndMaxPeedByPolyLineModel:(DJFSportTrackingLineModel*)ployLine{
    
    //运动总距离
    _totalDistance += ployLine.distance;
    //运动最大速度
    _maxSpeed = _maxSpeed > ployLine.speed? _maxSpeed:ployLine.speed;
}

/**
 根据水平精度判断gps信号
 
 @param location 位置
 @return 信号强度
 */
- (DJFSPortGPSState)getGPSStateByLocation:(CLLocation*)location{
    //三个步骤的顺序不能更改
    DJFSPortGPSState gpsState;
    //1.通过location的水平精度来判断gps信号
    if (location.horizontalAccuracy < 0) {
        gpsState = DJFSPortGPSStateDisconnect;
    } else if (location.horizontalAccuracy > 163) {
        gpsState = DJFSPortGPSStateBad;
    } else if (location.horizontalAccuracy > 48) {
        gpsState = DJFSPortGPSStateNormal;
    } else {
        gpsState = DJFSPortGPSStateGood;
    }
    if (_gpsSignalState == gpsState) {
        return gpsState;
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kGPSSignalDidChangedNotification object:nil userInfo:@{@"key":@(gpsState)}];
    _gpsSignalState = gpsState;
    return gpsState;
}
#pragma mark - 属性
-(CLLocation *)sportStartLocation{
    return  self.startLocation;
}

/**
 运动图标
 
 @return 运动图标
 */
- (UIImage *)sportIcon{
    
    switch (_sportType) {
        case DJFSportTypeWalk:
            _sportIcon = [UIImage imageNamed:@"map_annotation_walk"];
            break;
        case DJFSportTypeRun:
            _sportIcon = [UIImage imageNamed:@"map_annotation_run"];
            break;
        case DJFSportTypeBike:
            _sportIcon = [UIImage imageNamed:@"map_annotation_bike"];
            break;
            
        default:
            break;
    }
    
    return _sportIcon;
}
-(void)setPause:(BOOL)Pause{
    _Pause = Pause;
    if (_sportType == DJFSportTypeBike) {
        _stepManager.pause = YES;
    }else{
         _stepManager.pause = Pause;
    }
   
}
-(void)dealloc{
    
    [ _stepManager  tearDown];
   // NSLog(@"模型释放了");
    
}
@end
