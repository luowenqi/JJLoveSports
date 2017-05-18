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


@property(nonatomic , strong) UIButton * pauseButton;

@property(nonatomic , strong) UIButton * continueButton;

@property(nonatomic , strong) UIButton * finishButton;


@end

@implementation JJSportMaskView





-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    
    [self configBackGroudColor];
    //    self.backgroundColor = [UIColor colorWithHex:0x406479];
    
    [self addGPSRSSIButton];
    
    [self addDistanceLable];
    
    [self addSportDataView];
    
    
    [self addBottomView];
    
    [self addShowMapButton];
    
    [self addSportStateButton];
    
}




#pragma mark - 渐变填充背景图层
-(void)configBackGroudColor{
    
    //属于梯形图层  CAGradientLayer
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    //设置layer的位置和大小
    gradientLayer.position = self.center;
    gradientLayer.bounds = self.bounds;
    
    //插入layer
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    //设置和渐变图层相关的内容
    //渐变的位置,数值在0-1之间,本例中一共有三个渐变改变点,分别是最上面,六分点,最下面
    gradientLayer.locations = @[@0,@0.6,@1];
    
    //设置每一个渐变点的颜色,需要的是CGColor
    CGColorRef color1 = [UIColor colorWithHex:0x0e1428].CGColor;
    CGColorRef color2 = [UIColor colorWithHex:0x406479].CGColor;
    CGColorRef color3 = [UIColor colorWithHex:0x406578].CGColor;
    gradientLayer.colors = @[(__bridge UIColor*)color1,(__bridge UIColor*)color2,(__bridge UIColor*)color3];
}



#pragma mark - 添加运动状态按钮
-(void)addSportStateButton{
    
    //暂停 150
    UIButton* pauseButton = [[UIButton alloc]initWithTitle:nil titleColor:nil image:@"ic_sport_pause" HightImageName:nil addTarget:self action:@selector(chageSportStateClicked:) forControlEvents:UIControlEventTouchUpInside];
    pauseButton.backgroundColor = [UIColor colorWithHex:0x33d54e];
    pauseButton.tag = BASETAGE;
    
    //继续 151
    UIButton* continueButton = [[UIButton alloc]initWithTitle:nil titleColor:nil image:@"ic_sport_continue" HightImageName:nil addTarget:self action:@selector(chageSportStateClicked:) forControlEvents:UIControlEventTouchUpInside];
    continueButton.backgroundColor = [UIColor colorWithHex:0x33d54e];
    continueButton.tag = BASETAGE + 1;
    
    //结束 152
    UIButton* finishButton = [[UIButton alloc]initWithTitle:nil titleColor:nil image:@"ic_sport_finish" HightImageName:nil addTarget:self action:@selector(chageSportStateClicked:) forControlEvents:UIControlEventTouchUpInside];
    finishButton.backgroundColor = [UIColor colorWithHex:0xC26C53];
    finishButton.tag = BASETAGE + 2;
    
    [self addSubview:finishButton];
    [self addSubview:continueButton];
    [self addSubview:pauseButton];
    
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make centerX];
        make.bottom.equalTo(self.mas_bottom).offset(-99);
    }];
    [continueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make centerX];
        make.bottom.equalTo(self.mas_bottom).offset(-99);
    }];
    [pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make centerX];
        make.bottom.equalTo(self.mas_bottom).offset(-99);
    }];
    [pauseButton sizeToFit];
    pauseButton.layer.cornerRadius = pauseButton.bounds.size.width / 2;
    continueButton.layer.cornerRadius = pauseButton.bounds.size.width / 2;
    finishButton.layer.cornerRadius = pauseButton.bounds.size.width / 2;
    pauseButton.layer.masksToBounds = YES;
    continueButton.layer.masksToBounds = YES;
    finishButton.layer.masksToBounds = YES;
    _finishButton = finishButton;
    _continueButton = continueButton;
    _pauseButton = pauseButton;
}


#pragma mark - 改变运动状态
-(void)chageSportStateClicked:(UIButton*)sender{
    
    
    if (sender.tag == BASETAGE) {  //如果点击的是暂停
        [self foldAnimation:NO];
    }else if(sender.tag == BASETAGE +1){    //如果点击的是继续
        [self foldAnimation:YES];
    }
    
    
    UIButton* button = [UIButton new];
    button.tag = sender.tag - BASETAGE;
    [self.delegate changeSportState:button];
    
    
}


- (void)foldAnimation:(BOOL)isFold{
    
    self.pauseButton.hidden = YES;
    
    [UIView animateWithDuration:0.4 animations:^{
        if (!isFold) {  //展开
            [self.continueButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX).offset( - self.pauseButton.bounds.size.width - 5);
            }];
            
            [self.finishButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX).offset( self.pauseButton.bounds.size.width +5 );
            }];
            
        }else{
            [self.continueButton mas_updateConstraints:^(MASConstraintMaker *make) {
                [make centerX];
            }];
            
            [self.finishButton mas_updateConstraints:^(MASConstraintMaker *make) {
                [make centerX];
            }];
            
        }
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        //如果是展开，动画一开始就隐藏暂停按钮。如果是收缩，则在动画完成后再隐藏暂停按钮
        if (isFold == YES) {
            self.pauseButton.hidden = NO;
        }
    }];
    
    
    
}



#pragma mark - 展示地图按钮
-(void)addShowMapButton{
    UIButton * showMapButton = [[UIButton alloc]initWithTitle:nil titleColor:nil image:@"ic_sport_map" HightImageName:@"ic_sport_map" addTarget:self action:@selector(showMapButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:showMapButton];
    [showMapButton sizeToFit];
    
    [showMapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(1.5*Margin);
        make.right.equalTo(self).offset(-Margin);
    }];
    
}

#pragma mark - 展开地图
-(void)showMapButtonClicked{
    
    [self.delegate showMap];
    
}


#pragma mark - 添加底部View
-(void)addBottomView{
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
    
    //总时常
    UILabel* totalTimeLab = [[UILabel alloc]initWithText:@"00:00:00" andFont:[UIFont fontWithName:@"DINCond-Bold" size:30] textColor:[UIColor blackColor]];
    _totalTimeLab = totalTimeLab;
    totalTimeLab.textAlignment = NSTextAlignmentCenter;
    totalTimeLab.backgroundColor = [UIColor clearColor];
    UILabel* timeText = [[UILabel alloc]initWithText:@"时长" andFont:[UIFont fontWithName:@"DINCond-Bold" size:15]  textColor:[UIColor blackColor]];
    timeText.textAlignment = NSTextAlignmentCenter;
    timeText.backgroundColor = [UIColor clearColor];
    
    UILabel* avgSpeedLable = [[UILabel alloc]initWithText:@"0.00" andFont:[UIFont fontWithName:@"DINCond-Bold" size:30]  textColor:[UIColor colorWithHex:0xffffff]];
    avgSpeedLable.textAlignment = NSTextAlignmentCenter;
    avgSpeedLable.backgroundColor = [UIColor clearColor];
    UILabel* speedText = [[UILabel alloc]initWithText:@"平均速度(公里/时)" andFont:[UIFont fontWithName:@"DINCond-Bold" size:15]  textColor:[UIColor colorWithHex:0xffffff]];
    speedText.textAlignment = NSTextAlignmentCenter;
    speedText.backgroundColor = [UIColor clearColor];
    _avgSpeedLab = avgSpeedLable;
    
    
    
    
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
    
    UILabel*  totalDistanceLab = [[UILabel alloc]initWithText:@"0.00" andFont:[UIFont fontWithName:@"DINCond-Bold" size:90] textColor:[UIColor whiteColor]];
    _totalDistaceLab = totalDistanceLab;
    totalDistanceLab.backgroundColor = [UIColor clearColor];
    [self addSubview:totalDistanceLab];
    totalDistanceLab.font = [UIFont fontWithName:@"DINCond-Bold" size:90] ;
    [totalDistanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        [make centerX];
        make.bottom.equalTo(self.mas_top).offset( 409 / [UIScreen mainScreen].scale);
    }];
    
    
    UILabel*  distanceStringLable = [[UILabel alloc]initWithText:@"距离(公里)" andFont:[UIFont fontWithName:@"DINCond-Bold" size:18] textColor:[UIColor colorWithHex:0x8b9eaa]];
    distanceStringLable.backgroundColor = [UIColor clearColor];
    [self addSubview:distanceStringLable];
    [distanceStringLable mas_makeConstraints:^(MASConstraintMaker *make) {
        [make centerX];
        make.top.equalTo(totalDistanceLab.mas_bottom).offset( 8/ [UIScreen mainScreen].scale);
    }];
    
}


#pragma mark - 添加GPS信号强度View
-(void)addGPSRSSIButton{
    UIButton* GPSRSSIButton = [[UIButton alloc]initWithTitle:@"  建议绕开高楼大厦  " titleColor:[UIColor whiteColor] image:@"ic_sport_gps_connect_1" HightImageName:@"ic_sport_gps_connect_1" addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    GPSRSSIButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self addSubview:GPSRSSIButton];
    GPSRSSIButton.backgroundColor = [UIColor darkTextColor];
    GPSRSSIButton.alpha = 0.9;
    [GPSRSSIButton sizeToFit];
    
    [GPSRSSIButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Margin);
        make.top.equalTo(self).offset(1.5 * Margin);
    }];
    [GPSRSSIButton setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    //切圆角
    GPSRSSIButton.layer.masksToBounds = YES;
    GPSRSSIButton.layer.cornerRadius = (GPSRSSIButton.bounds.size.height + 10) / 2 ;
    self.gpsStateButton = GPSRSSIButton;
}



@end
