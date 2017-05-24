//
//  DJFAnalyseViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFAnalyseViewController.h"
#import "DJFSportSqlModel.h"
#import "DJFDBManager.h"
#import "UITableView+DJFWave.h"
#import "DJFAnalyseListCell.h"
#import "DJFMapRecordViewController.h"
@interface DJFAnalyseViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DJFAnalyseViewController{
    UITableView* tb;
    NSArray<DJFSportSqlModel*> *dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataList = [[DJFSportSqlModel new] getALLList];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dataList = [[DJFSportSqlModel new] getALLList];
    tb.backgroundColor = [UIColor blackColor];
    [tb reloadData];
    [tb reloadDataAnimateWithWave:RightToLeftWaveAnimation];
}


-(void)setupUI{
    //临时测试使用
    
    tb = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tb.dataSource = self;
    tb.delegate = self;
    tb.rowHeight = UITableViewAutomaticDimension;
    tb.estimatedRowHeight = 200;
    tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [tb registerClass:[DJFAnalyseListCell class] forCellReuseIdentifier:@"ceshi"];
    
    [self.view addSubview:tb];
    
    [tb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.offset(0);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

#pragma mark - 当选中某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DJFMapRecordViewController* mapRecordVC = [DJFMapRecordViewController new];
    mapRecordVC.mid = dataList[indexPath.row].mid;
    mapRecordVC.view.backgroundColor = [UIColor blackColor];
    
    mapRecordVC.sportSqlModel = dataList[indexPath.row];
    //push时候隐藏tabBar
    mapRecordVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapRecordVC animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJFAnalyseListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ceshi" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.sportSqlModel = dataList[indexPath.row];
    return  cell;
}
@end
