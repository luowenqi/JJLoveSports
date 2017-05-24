//
//  DJFWipeCache.m
//  LoveWalking
//
//  Created by 陈逸麒 on 2017/5/13.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFWipeCache.h"
#import "DJFProgressHUD.h"
#import "NSObject+Property2Method.h"
@interface  DJFWipeCache()

//要清除的的数据大小
@property(nonatomic,assign)float fileSize;

@end

@implementation DJFWipeCache
#pragma mark - 清理缓存

+ (instancetype)shareWipeCache{
    static DJFWipeCache* wipeCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wipeCache = [DJFWipeCache new];
    });
    return wipeCache;
}

// 显示缓存大小
-(float)filePath{
    
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    return [self folderSizeAtPath:cachPath];
    
}
//计算单个文件的大小
-(long long)fileSizeAtPath:(NSString *)filePath{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil]fileSize];
    }
    
    return 0;
    
}
//遍历文件夹获得文件夹大小

-(float)folderSizeAtPath:(NSString *)folderPath{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath :folderPath]) {
        return 0;
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString *fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    self.fileSize = folderSize/(1024.0 * 1024.0);
    
    return folderSize/(1024.0 * 1024.0);
    
}

// 清理缓存

- (void)clearFile{
    
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    
    //    NSLog ( @"cachpath = %@" , cachPath);
    
    for (NSString *p in files) {
        
        NSError *error =nil;
        
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            
        }
        
    }
    
    [self performSelectorOnMainThread:@selector(clearCachSuccess) withObject:nil waitUntilDone:YES];
    //    NSLog(@"%@",[NSThread currentThread]);
}
-(void)clearCachSuccess
{
    
}

- (void)alertViewWithController:(UIViewController*)viewController
{
   
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要清理缓存？" message:[NSString stringWithFormat:@"缓存大小为%0.2fMB",_fileSize] preferredStyle:UIAlertControllerStyleAlert];

    NSLog(@"%@", [alert getAllMethodList]);
    
    [alert addAction:[UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [DJFProgressHUD showSuccessMessage:@"清理成功"];
        
        //调用清理缓存
        [self clearFile];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [viewController presentViewController:alert animated:YES completion:nil];
}

@end
