//
//  DJFSportTrackingLineModel.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/1.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFSportTrackingLineModel.h"
#import "DJFSportPolyLine.h"
@interface DJFSportTrackingLineModel()

@end
@implementation DJFSportTrackingLineModel

- (instancetype)initWithStartLocation:(CLLocation *)startLocation andEndLocation:(CLLocation *)endLocation{
    self = [super init];
    _startLocation = startLocation;
    _endLocation = endLocation;
    return self;
}
- (DJFSportPolyLine *)polyLine{
    //多边形位置数组
    CLLocationCoordinate2D coord[2];
    coord[0].latitude = _startLocation.coordinate.latitude;
    coord[0].longitude = _startLocation.coordinate.longitude;
    
    coord[1].latitude = _endLocation.coordinate.latitude;
    coord[1].longitude = _endLocation.coordinate.longitude;
    _lastLocaion = _startLocation;
    _startLocation = _endLocation;
    
   
    //根据速度颜色
    CGFloat red = self.speed * 8 > 255? 255: self.speed * 8;
    CGFloat green = (255 - self.speed* 8)<0 ? 0 :(255 - self.speed* 8);
    UIColor* colorBySpeed = KRGBA(red, green, 0, 1);
    _lineColor = colorBySpeed;
    //颜色
    DJFSportPolyLine* polyLine = [DJFSportPolyLine polylineWithCoordinates:coord count:2 andPolyLineColor:colorBySpeed];
    
    return polyLine;

}

- (double)speed
{
    //返回起始点和结束点的平均速度  速度m/s
    return (self.startLocation.speed + self.endLocation.speed) * 0.5;
}

- (double)distance
{
    //系统返回的是m
    return [self.endLocation distanceFromLocation:self.startLocation];
}

- (double)time
{
    return [self.endLocation.timestamp timeIntervalSinceDate:self.startLocation.timestamp];
}

@end
