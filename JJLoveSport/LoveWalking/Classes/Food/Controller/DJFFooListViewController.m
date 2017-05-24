//
//  DJFFooListViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/5.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFFooListViewController.h"
#import "DJFCategoryTableViewCell.h"
#import "DJFFoodInfoViewController.h"
#import "DJFRefreshGifHeader.h"
@interface DJFFooListViewController ()
/**
 *  <#名称#>
 */
@property(nonatomic,strong)NSArray<DJFFoodInfoModel*> * infoModelList;
@end
static NSString* resId = @"resId";
@implementation DJFFooListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _infoModelList = [NSArray array];
    [self getDataListWithStyle:YES];
    self.tableView.rowHeight = SCREEN_BOUNDS.size.width * 0.5;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[DJFCategoryTableViewCell class] forCellReuseIdentifier:resId];
    
    
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
    self.tableView.mj_footer = footer;
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    self.tableView.mj_footer = footer;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _infoModelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJFCategoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:resId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.infoModel = _infoModelList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DJFFoodInfoViewController* foodInfoVC = [[DJFFoodInfoViewController alloc]init];
    foodInfoVC.infoModel = _infoModelList[indexPath.row];
    foodInfoVC.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:foodInfoVC animated:YES];
}

- (void)getDataListWithStyle:(BOOL)pullOrDown{
    NSInteger pageNum = 0;
    if (!pullOrDown) {
      pageNum = _infoModelList.count %15 == 0 ? _infoModelList.count%15 :1;
    }
    [[DJFNetWorkManager sharedManager]reqeustWith:foodListUrl method:@"GET" parameters:@{@"typeId":_typeId,@"page":@(pageNum)} callBack:^(NSArray* response) {
        if (response != nil) {
            NSArray* newList = [NSArray yy_modelArrayWithClass:[DJFFoodInfoModel class] json:response];
            if (pullOrDown) {
                _infoModelList = newList;
            }else{
                NSMutableArray* arrM = [NSMutableArray arrayWithCapacity:_infoModelList.count];
                [arrM addObjectsFromArray:_infoModelList];
                [arrM addObjectsFromArray:newList];
                _infoModelList = arrM.copy;
            }
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
