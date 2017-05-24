//
//  DJFSportingViewController.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/2.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFBaseViewController.h"
#import "DJFSportTrackingModel.h"
@interface DJFSportingViewController : DJFBaseViewController
/**
 *  运动类型
 */
@property(nonatomic,assign)DJFSportType sportType;

@property(nonatomic,assign)float compassOriginX;

@property(nonatomic,assign)float compassOriginY;

@end
