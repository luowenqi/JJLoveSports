//
//  DJFFoodViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFFoodViewController.h"
#import "DJFCategoryTableViewCell.h"
#import "DJFCategoryHeaderView.h"
#import "DJFFoodInfoViewController.h"
#import "DJFFooListViewController.h"
#import "DJFFoodTypeModel.h"
#import "DJFRefreshGifHeader.h"
@interface DJFFoodViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  数据
 */
@property(nonatomic,strong)NSArray<DJFFoodTypeModel*> *dataList;
/**
 *  <#名称#>
 */
@property(nonatomic,strong)UITableView *foodTbView;
@end
static NSString* resId = @"resId";
@implementation DJFFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setupUI{
  
    //创建
    _foodTbView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _foodTbView.delegate = self;
    _foodTbView.dataSource = self;
    [self.view addSubview:_foodTbView];
    _foodTbView.rowHeight = SCREEN_BOUNDS.size.width * 0.6;
    _foodTbView.sectionHeaderHeight = 50;
    _foodTbView.backgroundColor = [UIColor blackColor];
    _foodTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_foodTbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(0);
    }];
    //注册cell
    [_foodTbView registerClass:[DJFCategoryTableViewCell class] forCellReuseIdentifier:resId];
    
    //设置上下拉发刷新样式
    DJFRefreshGifHeader* refreshHeader = [DJFRefreshGifHeader headerWithRefreshingBlock:^{
         [self getFoodList];
    }];
    
    //开始刷新
    [refreshHeader beginRefreshing];
    
    // 隐藏时间
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    refreshHeader.stateLabel.hidden = YES;
    _foodTbView.mj_header = refreshHeader;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList[section].typeInfo.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJFCategoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:resId];
    cell.infoModel = _dataList[indexPath.section].typeInfo[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DJFCategoryHeaderView* headerView = [[DJFCategoryHeaderView alloc]init];
    headerView.typeModel = _dataList[section];
    headerView.contentView.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewTap:)];
    [headerView addGestureRecognizer:tap];
    return headerView;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DJFFoodInfoViewController* infoVC = [DJFFoodInfoViewController new];
    infoVC.infoModel = _dataList[indexPath.section].typeInfo[indexPath.row];
    infoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infoVC animated:YES];
}

#pragma mark - 手势
-(void)headerViewTap:(UITapGestureRecognizer*)headerViewTap{
    DJFFooListViewController* foodList = [DJFFooListViewController new];
    DJFCategoryHeaderView* headerView = (DJFCategoryHeaderView*)headerViewTap.view;
    foodList.typeId = headerView.typeModel.tid;
    foodList.view.backgroundColor = [UIColor blackColor];
    foodList.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:foodList animated:YES];
}

- (void)getFoodList{
    [[DJFNetWorkManager sharedManager]reqeustWith:@"http://food.fanqiedy.com/FoodType.aspx" method:@"GET" parameters:nil callBack:^(NSArray* response) {
        if (response != nil) {
            _dataList = [NSArray yy_modelArrayWithClass:[DJFFoodTypeModel class] json:response];
            [_foodTbView reloadData];
        }
        //停止刷新
        [self.foodTbView.mj_header endRefreshing];
        
    }];
}
@end
