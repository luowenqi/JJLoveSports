//
//  JJSportPolylineModel.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/11.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportPolylineModel.h"

@interface JJSportPolylineModel ()

@property(nonatomic , strong) CLLocation * startLocation;

@property(nonatomic , strong) CLLocation * endLocation;


@end

@implementation JJSportPolylineModel


-(instancetype)initWithStartLocation:(CLLocation *)startLocation endLocation:(CLLocation *)endLocation{

    
    if   (self = [super init]) {
          self.startLocation = startLocation;
            self.endLocation = endLocation;
    }
    
    return self;

}

#pragma mark - 单次画线
-(MAPolyline*)polyLine{

        CLLocationCoordinate2D commonPolylineCoords[2];
        commonPolylineCoords[0].latitude = _startLocation.coordinate.latitude;
        commonPolylineCoords[0].longitude = _startLocation.coordinate.longitude;
    
        commonPolylineCoords[1].latitude = _endLocation.coordinate.latitude;
        commonPolylineCoords[1].longitude = _endLocation.coordinate.longitude;
    
        //构造折线对象
        MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:2];
        
        return commonPolyline;
}


-(CGFloat)time{
    //单位 秒
    return [self.endLocation.timestamp timeIntervalSinceDate:self.startLocation.timestamp];
    
}

-(CGFloat)distance{
    //单位  米
    return [self.endLocation distanceFromLocation:self.startLocation];
}

-(CGFloat)speed{

    //单位 千米/h
    //return (self.distance / self.time) * 3.6;
   
    
    return (self.startLocation.speed + self.endLocation.speed)/2 * 3.6;
    
}

-(UIColor*)color{
    
    return [UIColor colorWithRed:(self.speed * 8)/ 255.0 green:1 blue:0 alpha:1];
    
}

@end
