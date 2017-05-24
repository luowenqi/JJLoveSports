//
//  DJFFMDBManager.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/2.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DJFDBManager : NSObject
/**
 单例: 一般数据库操作都创建成一个单例
 
 @return 单例
 */
+ (instancetype) sharedManager;

/**
 打开并连接数据库:1. 一般情况下, 在程序启动的时候就打开一次即可; 2. 如果有数据库, 直接打开, 如果没有, 会创建一个3.数据打开之后,一般会把表创建好, 创建表的时候添加 "IF NOT EXISTS"
 
 @param dbname 数据库的文件的名字
 */
- (void) openDB:(NSString *) dbname;

/**
 执行sql语句
 
 @param sql sql语句
 @return 是否执行成功
 */
- (BOOL) excuteSql: (NSString *) sql;
/// 查询数据返回数组
- (NSArray *)queryRecordSet:(NSString *)sql;
-(BOOL)execInsertTransactionSql:(NSMutableArray *)transactionSql;
@end
