//
//  DJFSportPolyLineSqlModel.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/16.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFSportPolyLineSqlModel.h"
#import "DJFDBManager.h"
@implementation DJFSportPolyLineSqlModel
/**
 删除数据
 */
- (BOOL)insertPolyLineListByTransaction:(NSMutableArray *)sql{
    if ([[DJFDBManager sharedManager]execInsertTransactionSql:sql]) {
        return YES;
    }
    return NO;
}
- (BOOL)deleteToDBWithRecordId:(NSString*)recordId {
    NSString *sql = [NSString stringWithFormat:@"delete from sportPolyLineRecord where recordId=\"%@\"",recordId];
    
    if ([[DJFDBManager sharedManager] excuteSql:sql]) {
        return YES;
    }
    return NO;
}

- (NSArray<DJFSportPolyLineSqlModel*>*)getListByRecordId:(NSString*)recordId{

    NSString* sql = [NSString stringWithFormat:@"select* from sportPolyLineRecord where recordId=\"%@\" order by mid asc",recordId];


    NSArray* array = [[DJFDBManager sharedManager]queryRecordSet:sql];
    return  [NSArray yy_modelArrayWithClass:[self class] json:array];
}
- (NSArray<DJFSportPolyLineSqlModel*>*)getListBySql:(NSString*)sql{
    
    NSArray* array = [[DJFDBManager sharedManager]queryRecordSet:sql];
    return  [NSArray yy_modelArrayWithClass:[self class] json:array];
}

@end
