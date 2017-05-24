//
//  DJFNewsListViewController.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/4.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFBaseTableViewController.h"

@interface DJFNewsListViewController : DJFBaseTableViewController
/**
 *  页面索引
 */
@property(nonatomic,assign)NSInteger pageIndex;

- (instancetype)initWithPageIndex:(NSInteger)pageIndex;
@end
