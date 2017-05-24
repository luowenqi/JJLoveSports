//
//  DJFSportPolyLine.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/1.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJFSportPolyLine : MAPolyline
/**
 *  线条颜色
 */
@property(nonatomic,strong)UIColor * lineColor;

@property(nonatomic,assign)CGFloat startLatitude;
@property(nonatomic,assign)CGFloat startlongitude;
@property(nonatomic,assign)CGFloat endLatitude;
@property(nonatomic,assign)CGFloat endlongitude;

/**
 生成指定颜色的线条

 @param coords 位置数组信息
 @param count 数量
 @param lineColor 颜色
 @return 包含颜色的线条
 */
+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count andPolyLineColor:(UIColor*)lineColor;
@end
