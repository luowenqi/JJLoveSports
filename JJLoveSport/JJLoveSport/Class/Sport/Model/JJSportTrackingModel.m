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


@end















