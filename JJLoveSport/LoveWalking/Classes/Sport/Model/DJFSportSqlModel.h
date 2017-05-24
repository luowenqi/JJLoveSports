//
//  DJFSportSqlModel.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/2.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJFSportPolyLine.h"
@interface DJFSportSqlModel : NSObject

@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *totalDistance;
@property (nonatomic, copy) NSString *timeSpend;
@property (nonatomic, copy) NSString *avgSpeed;
@property (nonatomic, copy) NSString *stepCount;
@property (nonatomic, copy) NSString *maxSpeed;
@property (nonatomic, copy) NSString *sportType;
@property (nonatomic, assign) NSInteger mid;



- (BOOL) insertToDB;
//- (void) updateToDB;
- (BOOL) deleteToDB;
- (NSArray<DJFSportSqlModel*>*)getALLList;
- (NSArray<DJFSportSqlModel*>*)getListBySql:(NSString*)sql;
- (DJFSportSqlModel*)getLastSportSqlModel;
@end
