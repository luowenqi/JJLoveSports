//
//  DJFMapTypeViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/2.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFMapTypeViewController.h"

@interface DJFMapTypeViewController ()
/**
 *  把选择的地图
 */
@property(nonatomic,strong)UIButton * selMapBtn;
@end

@implementation DJFMapTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)setupUI{
    //平面地图
    UIButton* flatMap = [[UIButton alloc]initWithFrame:CGRectMake(20, 16, 80, 89)];
    [self.view addSubview:flatMap];
    flatMap.selected = YES;
    _selMapBtn = flatMap;
    flatMap.tag = DJFMapTypeFlat;
    [flatMap setImage:[UIImage imageNamed:@"ic_sport_gps_map_flatmode"] forState:UIControlStateNormal];
    [flatMap setImage:[UIImage imageNamed:@"ic_sport_gps_map_flatmode_selected"] forState:UIControlStateSelected];
    
    //卫星地图
    UIButton* realMap = [[UIButton alloc]initWithFrame:CGRectMake(120, 16, 80, 89)];
    [self.view addSubview:realMap];
    realMap.tag = DJFMapTypeReal;
    [realMap setImage:[UIImage imageNamed:@"ic_sport_gps_map_realmode"] forState:UIControlStateNormal];
    
    [realMap setImage:[UIImage imageNamed:@"ic_sport_gps_map_realmode_selected"] forState:UIControlStateSelected];
    
    //混合地图
    UIButton* mixMap = [[UIButton alloc]initWithFrame:CGRectMake(220, 16, 80, 89)];
    [self.view addSubview:mixMap];
    mixMap.tag = DJFMapTypeMix;
    [mixMap setImage:[UIImage imageNamed:@"ic_sport_gps_map_mixmode"] forState:UIControlStateNormal];
    [mixMap setImage:[UIImage imageNamed:@"ic_sport_gps_map_mixmode_selected"] forState:UIControlStateSelected];
    
    //点击事件
    [flatMap addTarget:self action:@selector(choseMap:) forControlEvents:UIControlEventTouchUpInside];
    [realMap addTarget:self action:@selector(choseMap:) forControlEvents:UIControlEventTouchUpInside];
    [mixMap addTarget:self action:@selector(choseMap:) forControlEvents:UIControlEventTouchUpInside];
    
}

//选择地图
-(void)choseMap:(UIButton*)btn{
    //切换地图状态
    btn.selected = YES;
    _selMapBtn.selected = NO;
    _selMapBtn = btn;

    //回调把选择的地图类型
    if (self.mapType) {
        self.mapType(btn.tag);
    }
    
}


@end
