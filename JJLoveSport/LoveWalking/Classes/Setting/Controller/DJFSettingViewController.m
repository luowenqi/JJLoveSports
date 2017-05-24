//
//  DJFSettingViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFSettingViewController.h"
#import "DJFSettingTBVModel.h"
#import "DJFSettingTBVCellTableViewCell.h"
#import "DJFWipeCache.h"
#import "DJFProgressHUD.h"
#import "DJFSettingFeedbackViewController.h"
#import "DJFMoreSettingViewController.h"
#import "DJFAboutUsViewController.h"
static NSString *SettingCellID = @"SettingCellID";


/**
 设置界面枚举
 
 - SettingTypeFeedback: 意见反馈
 - SettingTypeWipeCache: 清楚缓存
 - SettingTypeMoreSetting: 更多设置
 - SettingTypeAboutUs: 关于我们
 */
typedef NS_ENUM(NSInteger,SettingType){
    SettingTypeFeedback,
    SettingTypeWipeCache,
    SettingTypeMoreSetting,
    SettingTypeAboutUs,
    
};
@interface DJFSettingViewController ()<UITableViewDataSource>

/**
 数据源
 */
@property(nonatomic,strong)NSArray *arrList;

/**
 意见反馈控制器
 */
@property(nonatomic,strong)DJFSettingFeedbackViewController *feedbackVC;

/**
 更多设置控制器
 */
@property(nonatomic,strong)DJFMoreSettingViewController *moreSettingVC;

/**
 关于我们控制器
 */
@property(nonatomic,strong)DJFAboutUsViewController *aboutUsVC;

@end

@implementation DJFSettingViewController{
    NSArray *familyNames;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //获取数据源
    _arrList = [[DJFSettingTBVModel alloc]getSettingModelArr];
    
    [self loadViewController];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 加载控制器
-(void)loadViewController{
    
    _feedbackVC = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"DJFSettingFeedbackViewController"];
    
    _moreSettingVC = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"DJFMoreSettingViewController"];
    
    _aboutUsVC = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"DJFAboutUsViewController"];
}


#pragma mark - 设置UI
-(void)setupUI{
    
    //注册cell
    [self.tableView registerClass:[DJFSettingTBVCellTableViewCell class] forCellReuseIdentifier:SettingCellID];
    
}

#pragma mark -代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSLog(@"%lu",indexPath.row);
    
    switch (indexPath.row) {
        case SettingTypeFeedback:
            [self.navigationController pushViewController:_feedbackVC animated:YES];
            break;
        case SettingTypeWipeCache:
            [[DJFWipeCache shareWipeCache]alertViewWithController:self];
            break;
        case SettingTypeMoreSetting:
            [self.navigationController pushViewController:_moreSettingVC animated:YES];
            break;
        case SettingTypeAboutUs:
            //            [self.tabBarController.tabBar setHidden:YES];
            _aboutUsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:_aboutUsVC animated:YES];
            // [self.navigationController presentViewController:_aboutUsVC animated:YES completion:nil];
            
        default:
            break;
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DJFSettingTBVCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCellID forIndexPath:indexPath];
    
    DJFSettingTBVModel *model = _arrList[indexPath.row];
    
    cell.arrList = model;
    
    return cell;
}

@end
