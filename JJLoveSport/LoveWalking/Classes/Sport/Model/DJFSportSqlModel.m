//
//  DJFSportSqlModel.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/2.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFSportSqlModel.h"
#import "DJFDBManager.h"
@implementation DJFSportSqlModel

/*
 @property (nonatomic, copy) NSString *recordDate;
 @property (nonatomic, copy) NSString *startTime;
 @property (nonatomic, copy) NSString *endTime;
 @property (nonatomic, copy) NSString *totalDistance;
 @property (nonatomic, copy) NSString *timeSpend;
 @property (nonatomic, copy) NSString *avgSpeed;
 @property (nonatomic, copy) NSString *stepCount;
 @property (nonatomic, copy) NSString *maxSpeed;
 @property (nonatomic, copy) NSString *sportType;
 */
/**
 插入数据
 */
- (BOOL) insertToDB {
    //id作为主键,如果不手动设, 数据库自动添加
    NSString *sql = [NSString stringWithFormat:@"insert into sportRecord (startTime,endTime,totalDistance,timeSpend,avgSpeed,stepCount,maxSpeed,sportType) values ( \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", _startTime,_endTime,_totalDistance,_timeSpend,_avgSpeed,_stepCount,_maxSpeed,_sportType];
    if ([[DJFDBManager sharedManager] excuteSql:sql]) {
        return YES;
    }
    return NO;
}


- (DJFSportSqlModel*)getLastSportSqlModel{
    NSString* sql = @"SELECT * FROM sportRecord WHERE mid =(select max(mid)  FROM sportRecord) order by mid desc";
    NSArray* array = [[DJFDBManager sharedManager]queryRecordSet:sql];
    
    return  [NSArray yy_modelArrayWithClass:[self class] json:array][0];
}
/**
 删除数据
 */
- (BOOL) deleteToDB {
    NSString *sql = [NSString stringWithFormat:@"delete from sportRecord where id=\"%zd\"", _mid];
    NSLog(@"%@", sql);
    if ([[DJFDBManager sharedManager] excuteSql:sql]) {
        return YES;
    }
    return NO;
}
- (NSArray<DJFSportSqlModel*>*)getALLList{
    NSString* sql = [NSString stringWithFormat:@"select* from sportRecord where mid is not null order by mid desc"];
    NSArray* array = [[DJFDBManager sharedManager]queryRecordSet:sql];
    return  [NSArray yy_modelArrayWithClass:[self class] json:array];
}
- (NSArray<DJFSportSqlModel*>*)getListBySql:(NSString*)sql{
    
    NSArray* array = [[DJFDBManager sharedManager]queryRecordSet:sql];
    return  [NSArray yy_modelArrayWithClass:[self class] json:array];
}
@end
