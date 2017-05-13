//
//  JJSportMaskView.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/12.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportMaskView.h"
#define Margin 15
#define BASETAGE 150


@interface JJSportMaskView ()

/**
 运动数据View
 */
@property(nonatomic , strong) UIView * sportDataView;

/**
 运动总时间
 */
@property(nonatomic , strong) UILabel * totalTimeLab;


/**
 运动总距离
 */
@property(nonatomic , strong) UILabel * avgSpeedLab;


/**
 暂停按钮
 */
@property(nonatomic , strong) UIButton * pauseButton;

@end

@implementation JJSportMaskView





-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    self.backgroundColor = [UIColor colorWithHex:0x406479];
    
    [self addGPSRSSIButton];
    [self addDistanceLable];
    
    [self addSportDataView];
    
    //     [self addPauseButton];
    
    [self addBottomView];
    
    [self addShowMapButton];
    
     [self addSportStateButton];

}


#pragma mark - 添加运动状态按钮
-(void)addSportStateButton{
    
    UIButton* button = [[UIButton alloc]init];
    
    NSArray* sportStateString = @[@"暂停",@"继续",@"结束"];
    
    for (NSInteger i = 0; i< sportStateString.count; i++) {
        button = [[UIButton alloc]initWithTitle:sportStateString[i] titleColor:[UIColor blackColor] image:nil HightImageName:nil addTarget:self action:@selector(chageSportStateClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.tag = BASETAGE + i;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(450);
            make.left.equalTo(self).offset(50* (i+1));
        }];
    }
}


#pragma mark - 改变运动状态
-(void)chageSportStateClicked:(UIButton*)sender{
    sender.tag = sender.tag - BASETAGE;
    [self.delegate changeSportState:sender];  
}




#pragma mark - 展示地图按钮
-(void)addShowMapButton{
    
    UIButton * showMapButton = [[UIButton alloc]initWithTitle:nil titleColor:nil image:@"ic_sport_map" HightImageName:@"ic_sport_map" addTarget:self action:@selector(showMapButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:showMapButton];
    [showMapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(1.5 * Margin);
        make.right.equalTo(self).offset(-Margin);
    }];
}

#pragma mark - 展开地图
-(void)showMapButtonClicked{
    
    [self.delegate showMap];
  
}


#pragma mark - 添加底部View
-(void)addBottomView{
    
    // NSArray* buttonImages = @[@"ic_sport_camera",@"ic_sport_lock_1",@"ic_sport_settings"];
    
    
    UIButton* cameraButton = [[UIButton alloc]initWithTitle:nil titleColor:nil image:@"ic_sport_camera" HightImageName:@"ic_sport_camera" addTarget:self action:@selector(takeAPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cameraButton];
    [cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12*KScreenScale);
        make.bottom.equalTo(self.mas_bottom).offset(- 12* KScreenScale);
    }];
    
    
    UIButton* lockButton = [[UIButton alloc]initWithTitle:nil titleColor:nil image:@"ic_sport_lock_1" HightImageName:@"ic_sport_lock_1" addTarget:self action:@selector(takeAPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lockButton];
    [lockButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make centerX];
        make.bottom.equalTo(self.mas_bottom).offset(- 12* KScreenScale);
    }];
    
    UIButton* settingButton = [[UIButton alloc]initWithTitle:nil titleColor:nil image:@"ic_sport_settings" HightImageName:@"ic_sport_settings" addTarget:self action:@selector(takeAPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingButton];
    [settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12 * KScreenScale);
        make.bottom.equalTo(self.mas_bottom).offset(- 12* KScreenScale);
    }];
}

#pragma mark - 拍摄照片
-(void)takeAPhoto{
    
}


#pragma mark - 添加支持视图
-(void)addSportDataView{
    
    CGFloat boldFontSize = 15 * KScreenScale;
    CGFloat SystemFontSize = 10 * KScreenScale;
    
    UILabel* totalTimeLab = [[UILabel alloc]initWithText:@"00:00:00" andFont:[UIFont boldSystemFontOfSize:boldFontSize] textColor:[UIColor blackColor]];
    totalTimeLab.textAlignment = NSTextAlignmentCenter;
    totalTimeLab.backgroundColor = [UIColor clearColor];
    UILabel* timeText = [[UILabel alloc]initWithText:@"时长" andFont:[UIFont systemFontOfSize:SystemFontSize ] textColor:[UIColor blackColor]];
    timeText.textAlignment = NSTextAlignmentCenter;
    timeText.backgroundColor = [UIColor clearColor];
    
    UILabel* avgSpeedLable = [[UILabel alloc]initWithText:@"0" andFont:[UIFont boldSystemFontOfSize:boldFontSize] textColor:[UIColor colorWithHex:0xffffff]];
    avgSpeedLable.textAlignment = NSTextAlignmentCenter;
    avgSpeedLable.backgroundColor = [UIColor clearColor];
    UILabel* speedText = [[UILabel alloc]initWithText:@"平均速度(公里/时)" andFont:[UIFont systemFontOfSize:SystemFontSize] textColor:[UIColor colorWithHex:0xffffff]];
    speedText.textAlignment = NSTextAlignmentCenter;
    speedText.backgroundColor = [UIColor clearColor];
    
    
    
    _avgSpeedLab = avgSpeedLable;
    _totalTimeLab = totalTimeLab;
    
    
    [self addSubview:avgSpeedLable];
    [self addSubview:speedText];
    [self addSubview:totalTimeLab];
    [self addSubview:timeText];
    
    [@[totalTimeLab,avgSpeedLable] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [@[totalTimeLab,avgSpeedLable] mas_makeConstraints:^(MASConstraintMaker *make) {
        [make centerY];
    }];
    
    
    [@[timeText,speedText] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [@[timeText,speedText]  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalTimeLab.mas_bottom);
    }];
    
}



#pragma mark - 添加距离lable
-(void)addDistanceLable{
    
    UILabel*  distanceLable = [[UILabel alloc]initWithText:@"0.00" andFont:[UIFont boldSystemFontOfSize: 180 / [UIScreen mainScreen].scale] textColor:[UIColor whiteColor]];
    distanceLable.backgroundColor = [UIColor clearColor];
    [self addSubview:distanceLable];
    [distanceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        [make centerX];
        make.bottom.equalTo(self.mas_top).offset( 409 / [UIScreen mainScreen].scale);
    }];
    
    
    UILabel*  distanceStringLable = [[UILabel alloc]initWithText:@"距离(公里)" andFont:[UIFont systemFontOfSize:18] textColor:[UIColor colorWithHex:0x8b9eaa]];
    distanceStringLable.backgroundColor = [UIColor clearColor];
    [self addSubview:distanceStringLable];
    [distanceStringLable mas_makeConstraints:^(MASConstraintMaker *make) {
        [make centerX];
        make.top.equalTo(distanceLable.mas_bottom).offset( 8/ [UIScreen mainScreen].scale);
    }];
    
}


#pragma mark - 添加GPS信号强度View
-(void)addGPSRSSIButton{
    
    UIButton* GPSRSSIButton = [[UIButton alloc]initWithTitle:@"建议绕开高楼大厦" titleColor:[UIColor whiteColor] image:@"ic_sport_gps_connect_1" HightImageName:@"ic_sport_gps_connect_1" addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    GPSRSSIButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self addSubview:GPSRSSIButton];
    GPSRSSIButton.backgroundColor = [UIColor darkTextColor];
    GPSRSSIButton.alpha = 0.9;
    [GPSRSSIButton sizeToFit];
    [GPSRSSIButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Margin);
        make.top.equalTo(self).offset(1.5 * Margin);
        make.size.mas_offset(CGSizeMake(GPSRSSIButton.bounds.size.width + 10, GPSRSSIButton.bounds.size.height + 10));
    }];
    //切圆角
    GPSRSSIButton.layer.masksToBounds = YES;
    GPSRSSIButton.layer.cornerRadius = (GPSRSSIButton.bounds.size.height + 10) / 2 ;
}



@end
