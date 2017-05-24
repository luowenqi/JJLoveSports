//
//  DJFFMDBManager.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/2.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFDBManager.h"
#import "DJFSQLString.h"
#import <sqlite3.h>
@implementation DJFDBManager{
    //数据库的操作队列
    sqlite3 *db;
}


+ (instancetype) sharedManager {
    static DJFDBManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[DJFDBManager alloc] init];
    });
    
    return manager;
}


/**
 打开并连接数据库
 @param dbname 数据库的名字
 */
- (void)openDB:(NSString *) dbname {
    NSString *documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dbPath = [documentDir stringByAppendingPathComponent:dbname];
    NSLog(@"%@", dbPath);
    //打开并连接数据库
    //如果有数据库文件, 就直接打开并连接,没有数据库文件, 就创建一个
    if (sqlite3_open(dbPath.UTF8String, &db) == SQLITE_OK) {
        NSLog(@"打开送连接数据库成功");
        //创建表
        NSMutableArray* arrayM = [NSMutableArray arrayWithCapacity:2];
        [arrayM addObject:createSportPolyLineRecordTable];
        [arrayM addObject:createSportRecordTable];
        [self execInsertTransactionSql:arrayM];
    } else {
        NSLog(@"打开并连接数据库失败");
    }
    
}


/**
 创建表
 
 @return 是否创建表成功
 */
- (BOOL) createTableWithSql:(NSString*)sql {
    //获取创建表的sql语句的字符串
    NSString *createTableSql = createSportRecordTable;
    /*
     1. 已打开并连接的数据库的句柄
     2. sql语句的c串
     3. 回调函数指针(NULL)
     4. 回调函数的第一个参数的指针(NULL)
     5. 错误指针(NULL)
     */
    return [self excuteSql:createTableSql];
}

/**
 执行sql语句
 */
- (BOOL) excuteSql: (NSString *) sql {

    return sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL) == SQLITE_OK;
}


#pragma mark - 数据库查询操作,不需要会敲
/// 查询数据返回数组
- (NSArray *)queryRecordSet:(NSString *)sql {
    
    // 1. 预编译 SQL
    /**
     参数
     
     1. 数据库句柄
     2. sql 的 C 语言字符串
     3. sql 的字节长度，传入 -1，自动计算
     4. 编译完成的语句句柄
     - 后续查询结果的相关操作，全部基于此句柄
     - 需要释放，否则会出现内存泄漏
     5. sql 语句的尾指针，通常传入 NULL
     
     返回值
     SQLITE_OK 编译成功
     */
    sqlite3_stmt *stmt = NULL;
    
    //编译sql语句
    if (sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL) != SQLITE_OK) {
        NSLog(@"SQL 语法错误");
        return nil;
    }
    
    NSArray *result = [self recordSetWithStmt:stmt];
    
    // 释放语句
    sqlite3_finalize(stmt);
    
    return result;
}

/// 从 stmt 中获取字典数组
- (NSArray *)recordSetWithStmt:(sqlite3_stmt *)stmt {
    
    // 遍历查询结果
    NSMutableArray *arrayM = [NSMutableArray array];
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        
        // 建立可变字典
        NSMutableDictionary *objDict = [NSMutableDictionary dictionary];
        
        // 获取列数
        int colCount = sqlite3_column_count(stmt);
        
        // 遍历每一列
        for (int col = 0; col < colCount; col++) {
            // 获取列名
            const char *cName = sqlite3_column_name(stmt, col);
            NSString *name = [NSString stringWithUTF8String:cName];
            
            // 获取数据类型
            int type = sqlite3_column_type(stmt, col);
            
            switch (type) {
                case SQLITE_INTEGER:
                {
                    int value = sqlite3_column_int(stmt, col);
                    objDict[name] = @(value);
                }
                    break;
                case SQLITE_FLOAT:
                {
                    double value = sqlite3_column_double(stmt, col);
                    objDict[name] = @(value);
                }
                    break;
                case SQLITE3_TEXT:
                {
                    const char *cValue = (const char *)sqlite3_column_text(stmt, col);
                    objDict[name] = [NSString stringWithUTF8String:cValue];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        [arrayM addObject:objDict];
    }
    
    return arrayM.copy;
}


//执行插入事务语句
-(BOOL)execInsertTransactionSql:(NSMutableArray *)transactionSql
{
    BOOL isScuess = false;
    //使用事务，提交插入sql语句
    @try{
        char *errorMsg;
        if (sqlite3_exec(db, "BEGIN", NULL, NULL, &errorMsg)==SQLITE_OK)
        {
            NSLog(@"启动事务成功");
            sqlite3_free(errorMsg);
            sqlite3_stmt *statement;
            for (int i = 0; i<transactionSql.count; i++)
            {
                if (sqlite3_prepare_v2(db,[[transactionSql objectAtIndex:i] UTF8String], -1, &statement,NULL)==SQLITE_OK)
                {
                    if (sqlite3_step(statement)!=SQLITE_DONE) sqlite3_finalize(statement);
                }
            }
            if (sqlite3_exec(db, "COMMIT", NULL, NULL, &errorMsg)==SQLITE_OK)   NSLog(@"提交事务成功");
            isScuess = true;
            sqlite3_free(errorMsg);
        }
        else sqlite3_free(errorMsg);
    }
    @catch(NSException *e)
    {
        char *errorMsg;
        if (sqlite3_exec(db, "ROLLBACK", NULL, NULL, &errorMsg)==SQLITE_OK)  NSLog(@"回滚事务成功");
        sqlite3_free(errorMsg);
    }
    @finally{}
    return  isScuess;
}
@end
