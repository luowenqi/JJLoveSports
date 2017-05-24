//
//  DJFGPSState.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/2.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFGPSState.h"
#import "DJFSportTrackingModel.h"
@implementation DJFGPSState
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gpsSignalDidChangedNotification:) name:kGPSSignalDidChangedNotification object:nil];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gpsSignalDidChangedNotification:) name:kGPSSignalDidChangedNotification object:nil];
    }
    return self;
}

- (void)gpsSignalDidChangedNotification:(NSNotification *)notification
{
    NSString *imageStr;
    
    //GPS背景图片
    if (_GPSBackGroundMode) {
        imageStr = @"ic_sport_gps_connect";
    }else{
        imageStr = @"ic_sport_gps_map_connect";
    }
    
    
    NSString *titleStr;
    //获取运动模型的gps信号状态
    DJFSPortGPSState state = [notification.userInfo[@"key"] integerValue];
    
    
    if (state == DJFSPortGPSStateDisconnect) {
        titleStr = @"GPS已断开,停止描绘运动轨迹";
    }
    else if (state == DJFSPortGPSStateBad)
    {
        titleStr = @"建议绕开高楼大厦";
    }
    else
    {
        titleStr = nil;
    }
    
    [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_%zd",imageStr,state-1]] forState:UIControlStateNormal];
    [self setTitle:titleStr forState:UIControlStateNormal];
    
    //刷新按钮的约束
    [self layoutIfNeeded];
    //刷新按钮动画
    self.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^
     {
         self.alpha = 1;
         
     }];
}

- (void)dealloc
{
    //注意移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGPSSignalDidChangedNotification object:nil];
}



@end
