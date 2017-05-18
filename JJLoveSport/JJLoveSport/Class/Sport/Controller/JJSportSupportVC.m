//
//  JJSportSupportVC.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportSupportVC.h"
#import "JJSportMaskView.h"
#import "JJSportSpeaker.h"



@interface JJSportSupportVC ()<JJSportMaskViewDelegate,JJSportMapVCDelegate>


@property(nonatomic , strong) JJSportMapVC * mapVC;


#pragma mark - 遮罩视图
@property(nonatomic , strong) JJSportMaskView * maskView;

/**
 语音播报模型
 */
@property(nonatomic , strong) JJSportSpeaker * sportSpeaker;

@end

@implementation JJSportSupportVC


-(instancetype)init{
    if (self = [super init]) {
   JJSportSpeaker* sportSpeaker = [[JJSportSpeaker alloc]initWithSportType:self.sportType andDistanceUnit:1];
         _sportSpeaker = sportSpeaker;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_sportSpeaker speakSportStart];
   
    
    [self setupUI];
}

#pragma mark - 设置界面
-(void)setupUI{
    //添加地图视图
    [self addMapView];
    [self addMaskView];
       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chageGPSImage:) name:@"GPSSignalChangeNotification" object:nil];
}


#pragma mark - 更改gps按你的样式
-(void)chageGPSImage:(NSNotification*)notification{
    JJSportGPSSingalState state = [notification.userInfo[@"key"] integerValue];
    NSString* imageName = [NSString stringWithFormat:@"ic_sport_gps_map_connect_%zd",state];
    NSString* str;
    if (state == JJSportGPSSingalStateClose) {
        str = @"GPS信号已断开";
    }else if (state == JJSportGPSSingalStateBad){
        str = @"请绕开高楼大厦";
    }else{
        str = nil;
    }
    [self.maskView.gpsStateButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.maskView.gpsStateButton setTitle:str forState:UIControlStateNormal];
}







#pragma mark - 添加遮罩视图
-(void)addMaskView{
    JJSportMaskView* maskView = [[JJSportMaskView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:maskView];
    _maskView = maskView;
    _maskView.delegate = self;
}



#pragma mark - 展开地图
-(void)showMap{
    [self presentViewController:_mapVC animated:YES completion:nil];
}

#pragma mark - 添加地图
-(void)addMapView{
    JJSportMapVC* mapVC = [[JJSportMapVC alloc]init];
    mapVC.delegate = self;
    mapVC.trackingModel = [[JJSportTrackingModel alloc]initWithSportType:self.sportType];
    _mapVC = mapVC;
}



#pragma mark - 代理方法,改变运动状态
-(void)changeSportState:(UIButton *)sender{
    
    if (sender.tag == JJSportStateFinish) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    self.mapVC.trackingModel.sportState = sender.tag;
    [_sportSpeaker speakSportState:sender.tag];
}

#pragma mark - JJSportMapVCDelegate,更新运动数据
-(void)updateSportDate:(JJSportTrackingModel *)sportTrackingModel mapVC:(JJSportMapVC *)mapVC{
    self.maskView.totalTimeLab.text = sportTrackingModel.totalTimeString;
    self.maskView.totalDistaceLab.text = [NSString stringWithFormat:@"%.2f",sportTrackingModel.totalDistance];
    self.maskView.avgSpeedLab.text = [NSString stringWithFormat:@"%.2f",sportTrackingModel.avgSpeed];
    [_sportSpeaker speakSportCompositeDataDistance:sportTrackingModel.totalDistance time:(int)sportTrackingModel.totalTime speed:sportTrackingModel.avgSpeed];
    //NSLog(@"%.f",sportTrackingModel.totalTime);
}




@end
