//
//  JJSportSupportVC.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportSupportVC.h"
#import "JJSportMaskView.h"



@interface JJSportSupportVC ()<JJSportMaskViewDelegate,JJSportMapVCDeleagte>


@property(nonatomic , strong) JJSportMapVC * mapVC;


#pragma mark - 遮罩视图
@property(nonatomic , strong) JJSportMaskView * maskView;

@end

@implementation JJSportSupportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 设置界面
-(void)setupUI{
    //添加地图视图
    [self addMapView];
    [self addMaskView];
   
    
}








#pragma mark - 添加遮罩视图
-(void)addMaskView{

    JJSportMaskView* maskView = [[JJSportMaskView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:maskView];
    _maskView = maskView;
    _maskView.delegate = self;
}



#pragma mark - 代理方法  展开地图
-(void)showMap{
    self.maskView.hidden = YES;
}

#pragma mark - 添加地图
-(void)addMapView{
    //使用父子控制器的方式把另外一个控制器加进来
    JJSportMapVC* mapVC = [[JJSportMapVC alloc]init];
    [self addChildViewController:mapVC];
    [self.view addSubview:mapVC.view];
    [mapVC didMoveToParentViewController:self];
    //设置mapVC.view的大小
    mapVC.view.frame = self.view.bounds;
    mapVC.trackingModel = [[JJSportTrackingModel alloc]initWithSportType:self.sportType];
    mapVC.delegate = self;
    _mapVC = mapVC;
}

#pragma mark - 关闭地图
-(void)closeMap{
    self.maskView.hidden = NO;
}

#pragma mark - 代理方法,改变运动状态
-(void)changeSportState:(UIButton *)sender{
    self.mapVC.trackingModel.sportState = sender.tag;
}






@end
