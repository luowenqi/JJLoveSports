//
//  DJFMapRecordViewController.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/16.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFBaseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "DJFSportSqlModel.h"


@interface DJFMapRecordViewController : DJFBaseViewController
/**
 *
 */
@property(nonatomic,assign)NSInteger mid;


/**
 本次运动数据模型
 */

@property(nonatomic , strong) DJFSportSqlModel * sportSqlModel;

@end
