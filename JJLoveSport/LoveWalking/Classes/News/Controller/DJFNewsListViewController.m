//
//  DJFNewsListViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/4.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFNewsListViewController.h"
#import "DJFNewsTableViewCell.h"
#import "DJFNewsInfoModel.h"
#import "DJFNewsInfoViewController.h"
#import "DJFRefreshGifHeader.h"

@interface DJFNewsListViewController ()
/**
 *  <#名称#>
 */
@property(nonatomic,copy)NSArray<DJFNewsInfoModel*>* dataList;
@end
static NSString* resId = @"resId";
@implementation DJFNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 115;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.tableView registerClass:[DJFNewsTableViewCell class] forCellReuseIdentifier:resId];
    _dataList = [NSArray array];
    //设置上下拉发刷新样式
    DJFRefreshGifHeader* refreshHeader = [DJFRefreshGifHeader headerWithRefreshingBlock:^{
        [self getDataListWithStyle:YES];
    }];
    
    //开始刷新
    [refreshHeader beginRefreshing];
    
    // 隐藏时间
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    
    
    // 隐藏状态
    refreshHeader.stateLabel.hidden = YES;
    self.tableView.mj_header = refreshHeader;
    
    MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getDataListWithStyle:NO];
    }];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    self.tableView.mj_footer = footer;
}

#pragma mark - 代理协议
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DJFNewsInfoViewController* infoVC = [DJFNewsInfoViewController new];
    infoVC.nId = _dataList[indexPath.row].nId;
    infoVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:infoVC animated:YES];
}
#pragma mark - 数据源协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJFNewsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:resId forIndexPath:indexPath];
    cell.infoModel = _dataList[indexPath.row];
    return cell;
    
}
- (instancetype)initWithPageIndex:(NSInteger)pageIndex{
    self = [super init];
    if (self) {
        _pageIndex = pageIndex;
    }
    return self;
}

- (void)getDataListWithStyle:(BOOL)pullOrDown{
    NSInteger pageNum = 0;
    if (!pullOrDown) {
        pageNum = _dataList.count %15 == 0 ? _dataList.count%15 :1;
    }
    [[DJFNetWorkManager sharedManager]reqeustWith:@"http://food.fanqiedy.com/News.aspx" method:@"GET" parameters:@{@"ntid":@"1",@"page":@(pageNum)}  callBack:^(id response) {
        
        if (response != nil) {
            NSArray* newList = [NSArray yy_modelArrayWithClass:[DJFNewsInfoModel class] json:response];
            if (pullOrDown) {
                _dataList = newList;
            }else{
                NSMutableArray* arrM = [NSMutableArray arrayWithCapacity:_dataList.count];
                [arrM addObjectsFromArray:_dataList];
                [arrM addObjectsFromArray:newList];
                _dataList = arrM.copy;
            }
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        
    }];
}

@end
