//
//  DJFSQLString.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/2.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFSQLString.h"

//创建运动数据记录
NSString* createSportRecordTable = @"CREATE TABLE IF NOT EXISTS sportRecord(mid INTEGER NOT NULL,startTime text,endTime text,totalDistance text,timeSpend text,avgSpeed text,stepCount text,maxSpeed text,sportType text,PRIMARY KEY(mid))";
NSString* createSportPolyLineRecordTable = @"CREATE TABLE IF NOT EXISTS sportPolyLineRecord(mid INTEGER NOT NULL,startLatitude text,startlongitude text,endLatitude text,endlongitude text,lineColor text, recordId INTEGER,PRIMARY KEY(mid))";
