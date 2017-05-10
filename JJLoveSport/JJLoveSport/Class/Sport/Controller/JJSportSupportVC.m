//
//  JJSportSupportVC.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportSupportVC.h"

@interface JJSportSupportVC ()

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
    
    //添加支持视图
    [self addSupportView];
   
    

  
}

#pragma mark - 添加支持视图
-(void)addSupportView{

    UIView* supportView = [[UIView alloc]init];
    [self.view addSubview:supportView];
    [supportView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_offset(64);
    }];
    supportView.backgroundColor = [UIColor yellowColor];
}



#pragma mark - 添加抽屉视图
-(void)addMapView{
    //使用父子控制器的方式把另外一个控制器加进来
    JJSportMapVC* mapVC = [[JJSportMapVC alloc]init];
    [self addChildViewController:mapVC];
    [self.view addSubview:mapVC.view];
    [mapVC didMoveToParentViewController:self];
    //设置mapVC.view的大小
    mapVC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHight - 64);

}

@end
