//
//  JJSportTrackingModel.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportTrackingModel.h"
#import "JJSportPolylineModel.h"

@interface JJSportTrackingModel ()



/**
 运动单个线条集合
 */
@property(nonatomic , strong) NSMutableArray * polyLineModelArray;


/**
 运动开始位置
 */
@property(nonatomic , strong) CLLocation * startLocation;


/**
 运动中上一个位置(也可以作为最终的位置)
 */
@property(nonatomic , strong) CLLocation * lastLocation;




@end

@implementation JJSportTrackingModel

-(UIImage*)sportTpyeImage{
    UIImage* image = [[UIImage alloc]init];
    switch (self.sportType) {
        case JJSportTypeRun:
             image = [UIImage imageNamed:KGlobalSportTypeImageNames[0]];
            break;
        case JJSJJSportWalk:
            image = [UIImage imageNamed:KGlobalSportTypeImageNames[1]];
            break;
        case JJSJJSportRiding:
            image = [UIImage imageNamed:KGlobalSportTypeImageNames[2]];
            break;
  
        default:
            break;
    }
    
    return image;

}

#pragma mark - 可选初始化方法
-(instancetype)initWithSportType:(JJSportType)sportType{
    return [self initWithSportType:sportType sportState:JJSportStateContinue];
}


#pragma mark - 绘制线条
-(MAPolyline*)drawPolylineWithLocation:(CLLocation*)location{
    
    
    //GPS信号强度算法
    if ([self gpsStatewithLocation:location] == JJSportGPSSingalStateBad || [self gpsStatewithLocation:location] == JJSportGPSSingalStateClose) {
        return nil;
    }
    
    //速度优化算法,防止用户在静止的时候练习画线,消耗性能,并且出现大点
    if (location.speed <= 0) {
        return nil;
    }
    
    
    //时间优化算法  如果当前的时间和卫星发现当前设备的时间相差太久,也就是信号很不好的时候,停止画线,因为这时候画线也是不准确的
    if ([[NSDate date] timeIntervalSinceDate:location.timestamp] >= 2) {
        return nil;
    }
    

    
    
    if (self.startLocation == nil) {
        self.startLocation = location;
        self.lastLocation = location;
        return nil;
    }
    
    
    JJSportPolylineModel* polyLineModel = [[JJSportPolylineModel alloc]initWithStartLocation:self.lastLocation endLocation:location];
    [self.polyLineModelArray addObject:polyLineModel];
    self.lastLocation = location;
    self.currentColor = polyLineModel.color;

    return polyLineModel.polyLine;
}



-(CGFloat)totalTime{

    return [[self.polyLineModelArray valueForKeyPath:@"@sum.time"] floatValue];
}

-(CGFloat)totalDistance{
    return ([[self.polyLineModelArray valueForKeyPath:@"@sum.distance"] floatValue] / 1000);
}

-(CGFloat)avgSpeed{
    return [[self.polyLineModelArray valueForKeyPath:@"@avg.speed"] floatValue];
}

-(NSString*)totalTimeString{
  
    int hour = (int)self.totalTime / 3600;
    int minute = (int)self.totalTime % 3600 /60;
    int second = (int)self.totalTime % 60 ;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minute,second];
    return nil;
}

-(CGFloat)maxSpeed{
    return [[self.polyLineModelArray valueForKeyPath:@"@max.speed"] floatValue];
}

-(instancetype)initWithSportType:(JJSportType)sportType sportState:(JJSportState)sportState{

        self = [super init];
        self.sportType = sportType;
        self.sportState = sportState;
        self.polyLineModelArray = [NSMutableArray array];
    return self;
}

#pragma mark - 设置当前的运动状态
-(void)setSportState:(JJSportState)sportState{
    _sportState = sportState;
}



- (JJSportGPSSingalState )gpsStatewithLocation:(CLLocation *)location
{
    JJSportGPSSingalState state;
    
    //1.通过location的水平精度来判断gps信号
    if (location.horizontalAccuracy < 0) {
        state = JJSportGPSSingalStateClose;
    } else if (location.horizontalAccuracy > 163) {
        state = JJSportGPSSingalStateBad;
    } else if (location.horizontalAccuracy > 48) {
        state = JJSportGPSSingalStateNormal;
    } else {
        state = JJSportGPSSingalStateGood;
    }
    
    //GPS信号变更
    //实际公司开发中，当GPS信号很差的情况下，一般根据公司实力会有以下三种处理情况
    //第一种：不做任何处理（与其给用户一个错误的轨迹，倒不如给用户一个非常友善的提示，GPS信号差绘制轨迹缺失）
    //第二种方式：由算法工程师对GPS信号差的轨迹做一个算法优化，根据算法推算出正确的轨迹：对算法工程师的要求非常高
    //第三种方式：由硬件的传感器来推算真实的路线
    if(state != _gpsSingalState)
    {
        //保存当前gps信号
        _gpsSingalState = state;
        
        //使用通知发送当前GPS信号
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GPSSignalChangeNotification" object:nil userInfo:@{@"key":@(state)}];
        
    }
    
    return state;
}


@end















