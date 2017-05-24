//
//  DJFNewsSearchViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/3.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFNewsSearchViewController.h"
#import "DJFNewsInfoModel.h"
#import "DJFNewsInfoViewController.h"
@interface DJFNewsSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>


/**
 *  搜索结果列表
 */
@property(nonatomic,strong)UITableView *resultList;

/**
 搜索结果
 */
@property(nonatomic,copy)NSArray<DJFNewsInfoModel*> *resultModelArray;
@end

static NSString* resID = @"cell";
@implementation DJFNewsSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _resultModelArray = [NSArray array];
}
#pragma mark - 搭建UI
- (void)setupUI{
    

    //搜索框
    [self searchBar];
    //搜索记录
    [self searchList];
}


/**
 搜索框
 */
- (void)searchBar{
    _searchNewsBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_BOUNDS.size.width, 40)];
    _searchNewsBar.placeholder = @"请输入相关资讯内容";
    _searchNewsBar.delegate = self;
    _searchNewsBar.backgroundColor = THEME_COLOR;
    [_searchNewsBar becomeFirstResponder];
    self.navigationItem.titleView = _searchNewsBar;
}

- (void)searchList{
    _resultList = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _resultList.dataSource = self;
    _resultList.tableFooterView = [UIView new];
    _resultList.delegate = self;
    [_resultList registerClass:[UITableViewCell class] forCellReuseIdentifier:resID];
    [self.view addSubview:_resultList];
}

#pragma mark - 搜索记录 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _resultModelArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DJFNewsInfoViewController* infoVC = [DJFNewsInfoViewController new];
    infoVC.nId = _resultModelArray[indexPath.row].nId;
    infoVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:infoVC animated:YES];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:resID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _resultModelArray[indexPath.row].title;
    return cell;
}
#pragma mark - 搜索框代理 UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
 
    [self getResultListWithText:searchText];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [_searchNewsBar resignFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated{
   [_searchNewsBar resignFirstResponder];
    [super viewWillDisappear:animated];
    
}

- (void)getResultListWithText:(NSString*)text{
    DJFNetWorkManager* manager = [DJFNetWorkManager sharedManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSData* textData = [text dataUsingEncoding:NSUTF8StringEncoding ];
    text = [textData base64EncodedStringWithOptions:0];
    [manager reqeustWith:@"http://food.fanqiedy.com/NewsSearch.aspx" method:@"GET" parameters:@{@"searchTitle":text}callBack:^(id response) {
        if (response == nil) {
            _resultModelArray = [NSArray array];
        }else{
            _resultModelArray = [NSArray yy_modelArrayWithClass:[DJFNewsInfoModel class] json:response];
        }
        [_resultList reloadData];
    }];
}
@end
