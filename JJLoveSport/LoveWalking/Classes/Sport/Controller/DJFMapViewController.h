//
//  DJFMapViewController.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFBaseViewController.h"
#import "DJFSportTrackingModel.h"
@interface DJFMapViewController : DJFBaseViewController

/**
 *  运动模型
 */
@property(nonatomic,weak)DJFSportTrackingModel * sportTrackingModel;

/**
 高德地图
 */
@property(nonatomic,strong)MAMapView *mapView;
@end
