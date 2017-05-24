//
//  DJFSportPolyLine.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/1.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFSportPolyLine.h"

@implementation DJFSportPolyLine
+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count andPolyLineColor:(UIColor*)lineColor{
    DJFSportPolyLine* polyLine = [DJFSportPolyLine polylineWithCoordinates:coords count:count];

    polyLine.startLatitude = coords[0].latitude;
    polyLine.startlongitude = coords[0].longitude;
    polyLine.endLatitude = coords[1].latitude;
    polyLine.endlongitude = coords[1].longitude;
    polyLine.lineColor = lineColor;
    return polyLine;
}
@end
