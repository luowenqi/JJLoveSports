//
//  JJSportMapVC.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportMapVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "JJCircleTransition.h"
#import "JJMapTypeChooseVC.h"

#define Margin 15
#define BASETAGE 66



@interface JJSportMapVC ()<MAMapViewDelegate,UIPopoverPresentationControllerDelegate,JJMapTypeChooseVCDelegate>



/**
 选择地图类型
 */
@property(nonatomic , strong) UIButton * choiceMapTypeButton;

/**
 圆形转场
 */
@property(nonatomic , strong) JJCircleTransition *  circleTransition;

/**
 起点位置
 */
@property(nonatomic , strong) CLLocation * startLocation;


/**
 地图
 */
@property(nonatomic , strong) MAMapView *mapView;


/**
 运动总时间
 */
@property(nonatomic , strong) UILabel * totalTimeLab;


/**
 运动总距离
 */
@property(nonatomic , strong) UILabel * distaceLab;





/**
 运动数据View
 */
@property(nonatomic , strong) UIView * sportDataView;

/**
 当前地图显示模式
 */
@property(nonatomic , assign) MAMapType currentMapType;

@property(nonatomic , strong) UIButton * gpsStateButton;

@end

@implementation JJSportMapVC


-(instancetype)init{

    if (self = [super init]) {
        //设置转场的样式为自定义
        self.modalPresentationStyle = UIModalPresentationCustom;
        ///维护一个圆形转场的属性,并且进行初始化(参数1:圆心位置 参数2:初始圆半径);
        //这里的36是高德地图中compassSize半径,是一个只读属性
        _circleTransition = [[JJCircleTransition alloc]initWithArcCenter:CGPointMake([UIScreen mainScreen].bounds.size.width - Margin - 15, 1.5*Margin + 15 ) cornerRadius:15];
        self.transitioningDelegate = _circleTransition;
        [self addMapView];
    }
    return self;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

    [self addSportDataView];
    
    [self addFunctionButton];
    
    [self addGPSRSSIButton];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chageGPSImage:) name:@"GPSSignalChangeNotification" object:nil];
    
    
}


-(void)chageGPSImage:(NSNotification*)notification{

    JJSportGPSSingalState state = [notification.userInfo[@"key"] integerValue];
    NSString* imageName = [NSString stringWithFormat:@"ic_sport_gps_map_connect_%zd",state];
    NSString* str;
    if (state == JJSportGPSSingalStateClose) {
        str = @"  GPS信号已断开  ";
    }else if (state == JJSportGPSSingalStateBad){
    str = @"  请绕开高楼大厦  ";
    }else{
        str = nil;
    }
    
    [self.gpsStateButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.gpsStateButton setTitle:str forState:UIControlStateNormal];
}







#pragma mark - 添加GPS信号强度View
-(void)addGPSRSSIButton{

    UIButton* GPSRSSIButton = [[UIButton alloc]initWithTitle:@"  建议绕开高楼大厦  " titleColor:[UIColor whiteColor] image:@"ic_sport_gps_connect_1" HightImageName:@"ic_sport_gps_connect_1" addTarget:self action:@selector(closeMapClicked:) forControlEvents:UIControlEventTouchUpInside];
    GPSRSSIButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.view addSubview:GPSRSSIButton];
    GPSRSSIButton.backgroundColor = [UIColor lightGrayColor];
    GPSRSSIButton.alpha = 0.9;
    [GPSRSSIButton sizeToFit];
    [GPSRSSIButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(Margin);
        make.top.equalTo(self.view).offset(1.5 * Margin);
    }];
    //切圆角
    [GPSRSSIButton setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    GPSRSSIButton.layer.masksToBounds = YES;
    GPSRSSIButton.layer.cornerRadius = (GPSRSSIButton.bounds.size.height + 10) / 2 ;
    self.gpsStateButton = GPSRSSIButton;
    
    
}



#pragma mark - 添加功能Button
-(void)addFunctionButton{

    //选择地图显示模型
    UIButton* choiceMapTypeButton = [[UIButton alloc]initWithTitle:nil titleColor:nil image:@"ic_sport_gps_map_mode" HightImageName:@"ic_sport_gps_map_mode" addTarget:self action:@selector(choiceMapType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choiceMapTypeButton];
    [choiceMapTypeButton sizeToFit];
    [choiceMapTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(Margin);
        make.bottom.equalTo(self.sportDataView.mas_top).offset(-Margin);
    }];
    self.choiceMapTypeButton = choiceMapTypeButton;
    //关闭地图按钮
    UIButton* closeMapButton = [[UIButton alloc]initWithTitle:nil titleColor:nil image:@"ic_sport_gps_map_close" HightImageName:@"ic_sport_gps_map_close" addTarget:self action:@selector(closeMapClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeMapButton];
    [closeMapButton sizeToFit];
    [closeMapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sportDataView.mas_top).offset(-Margin);
        make.right.equalTo(self.view).offset(-Margin);
    }];   

}




#pragma mark - 关闭地图
-(void)closeMapClicked:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 选择地图显示类型
-(void)choiceMapType:(UIButton*)sender{

    JJMapTypeChooseVC* mapTypeChooseVC = [[JJMapTypeChooseVC alloc]init];

    mapTypeChooseVC.deleagte = self;  //这个是其他的代理,和popover没有关系
    //设置模态的样式
    mapTypeChooseVC.modalPresentationStyle = UIModalPresentationPopover;
    //创建popover控制器
    UIPopoverPresentationController* popover = mapTypeChooseVC.popoverPresentationController;
    //设置popover的来源视图,从谁那里弹出来
    popover.sourceView = self.choiceMapTypeButton;
    //设置尖尖的起始位置
     //popover有一个来源视图soucreView：popover从哪一个地方弹出
    //默认情况下箭头的中心点在来源视图的原点位置（左上角），如果想让popover的箭头显示在来源视图的中线点，则只需要设置popover的目标参考矩形souceRect为来源视图的bounds属性即可
    popover.sourceRect = popover.sourceView.bounds;
    //设置尖尖的朝向
    popover.permittedArrowDirections = UIPopoverArrowDirectionDown;
    //设置popover的大小,如果设置为0那么就是自适应大小,注意这里不是popover进行设置
    mapTypeChooseVC.preferredContentSize = CGSizeMake(0, 110);
    //设置代理
    mapTypeChooseVC.popoverPresentationController.delegate = self;
    //弹出控制器
    [self presentViewController:mapTypeChooseVC animated:YES completion:nil];
//    NSLog(@"选择地图类型");
}

//代理方法,设置不是全屏弹出
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection{
    return UIModalPresentationNone;
}

#pragma mark - 添加地图
-(void)addMapView{

    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view insertSubview:_mapView atIndex:0];
    //设置跟踪模式
    _mapView.userTrackingMode =  MAUserTrackingModeFollowWithHeading;
    
    _mapView.showsScale = NO;
    
    _mapView.showTraffic = YES;
    
    _mapView.delegate = self;
    
//    NSLog(@"%f--%f",_mapView.compassOrigin.x ,_mapView.compassOrigin.y);

    
    //设置指南针的位置
//    _mapView.compassOrigin = CGPointMake(<#CGFloat x#>, <#CGFloat y#>)
    
   _mapView.compassOrigin=  CGPointMake([UIScreen mainScreen].bounds.size.width - Margin - 15 - _mapView.compassSize.width / 2, 1.5*Margin + 15 - _mapView.compassSize.width / 2 );
//    NSLog(@"%f--%f",_mapView.compassOrigin.x ,_mapView.compassOrigin.y);
    //关闭后台自动暂停开关
    _mapView.pausesLocationUpdatesAutomatically = NO;
    
    /**
     * 是否允许后台定位。默认为NO。只在iOS 9.0之后起作用。
     * 设置为YES的时候必须保证 Background Modes 中的 Location updates处于选中状态，否则会抛出异常。
     */
    _mapView.allowsBackgroundLocationUpdates = YES;

}

#pragma mark - 地图更新位置
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{

   // NSLog(@"%.f-----%.f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    //三滤波算法
    static NSInteger flage = 1;
    if (flage <= 3) {
        flage++;
        return;
    }
    
   
    
    //判断是不是正在更新位置
    if (updatingLocation) {
        
        if (!self.startLocation && _mapView.showsUserLocation == YES) {  //如果起始位置不存在,并且已经定位成功

            //记录起始位置
            self.startLocation = userLocation.location;
            //添加大头针
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate = userLocation.location.coordinate;
            pointAnnotation.title = userLocation.title;
            pointAnnotation.subtitle = userLocation.subtitle;
            [mapView addAnnotation:pointAnnotation];
        }
    }

   //在地图上添加折线对象
    [_mapView addOverlay:[_trackingModel drawPolylineWithLocation:userLocation.location]];
    //设置用户位置为地图中心位置
    [_mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
    
    _totalTimeLab.text = _trackingModel.totalTimeString;
    _distaceLab.text = [NSString stringWithFormat:@"%.2f",_trackingModel.totalDistance];
    
    

    if (self.delegate && [self.delegate respondsToSelector:@selector(updateSportDate:mapVC:)]) {
        [self.delegate updateSportDate:self.trackingModel mapVC:self];
        
    }
}




#pragma mark - 设置折线的样式
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        
//        if (self.trackingModel.sportState != JJSportStateContinue) {
//           
//            NSLog(@"现在的运动状态%lu",self.trackingModel.sportState);
//            
//            return nil;
//        }

        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = _trackingModel.currentColor;
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        return polylineRenderer;
    }
    return nil;
}




/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
  
        UIImage *image= self.trackingModel.sportTpyeImage;
        annotationView.image = image;
        
        //改变大头针位置偏移量,大头针往上移动图片一半的高度，让大头针下方的尖角处于默认大头针的中心点
        /**
         *  默认情况下, annotation view的中心位于annotation的坐标位置，可以设置centerOffset改变view的位置，正的偏移使view朝右下方移动，负的朝左上方，单位是像素
         */
        annotationView.centerOffset = CGPointMake(0, -image.size.height/2);
        return annotationView;
    }
    return nil;
}


#pragma mark - 添加支持视图
-(void)addSportDataView{
    
    UIBlurEffect *blureffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blureffect];
    self.sportDataView = effectView;
    effectView.frame = self.view.bounds;
    [self.view addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_offset(88);
    }];
    
    UILabel* distaceLab = [[UILabel alloc]initWithText:@"0.00" andFont:[UIFont boldSystemFontOfSize:24] textColor:[UIColor redColor]];
    distaceLab.textAlignment = NSTextAlignmentCenter;
    distaceLab.backgroundColor = [UIColor clearColor];
    UILabel* distaceText = [[UILabel alloc]initWithText:@"距离(公里)" andFont:[UIFont systemFontOfSize:20] textColor:[UIColor blackColor]];
    distaceText.textAlignment = NSTextAlignmentCenter;
    distaceText.backgroundColor = [UIColor clearColor];
    
    UILabel* totalTimeLab = [[UILabel alloc]initWithText:@"00:00:00" andFont:[UIFont boldSystemFontOfSize:24] textColor:[UIColor blackColor]];
    totalTimeLab.textAlignment = NSTextAlignmentCenter;
    totalTimeLab.backgroundColor = [UIColor clearColor];
    UILabel* timeText = [[UILabel alloc]initWithText:@"时长" andFont:[UIFont systemFontOfSize:20] textColor:[UIColor blackColor]];
    timeText.textAlignment = NSTextAlignmentCenter;
    timeText.backgroundColor = [UIColor clearColor];
    
    _distaceLab = distaceLab;
    _totalTimeLab = totalTimeLab;
    
    
    [effectView addSubview:distaceLab];
    [effectView addSubview:distaceText];
    [effectView addSubview:totalTimeLab];
    [effectView addSubview:timeText];
    
    [@[distaceLab,totalTimeLab] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [@[distaceLab,totalTimeLab] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(effectView).offset(20);
    }];
    
    
    [@[distaceText,timeText] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [@[distaceText,timeText]  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(effectView).offset(-20);
    }];
    
}
//    /*
//     MAMapTypeStandard = 0,  // 普通地图
//     MAMapTypeSatellite,  // 卫星地图
//     MAMapTypeStandardNight // 夜间视图
//     */


-(void)changeMapeType:(UIButton *)sender{

    _mapView.mapType = sender.tag;
}




@end
