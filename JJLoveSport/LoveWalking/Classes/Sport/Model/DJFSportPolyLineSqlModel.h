//
//  DJFSportPolyLineSqlModel.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/16.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJFSportPolyLineSqlModel : NSObject
@property(nonatomic,assign)CLLocationDegrees startLatitude;
@property(nonatomic,assign)CLLocationDegrees startlongitude;

@property(nonatomic,assign)CLLocationDegrees endLatitude;
@property(nonatomic,assign)CLLocationDegrees endlongitude;

@property(nonatomic,strong)NSString *lineColor;
@property(nonatomic,assign)NSInteger recordId;

- (BOOL)insertPolyLineListByTransaction:(NSMutableArray*)sql;
- (BOOL)deleteToDBWithRecordId:(NSString*)recordId;
- (NSArray<DJFSportPolyLineSqlModel*>*)getListByRecordId:(NSString*)recordId;
- (NSArray<DJFSportPolyLineSqlModel*>*)getListBySql:(NSString*)sql;

@end
