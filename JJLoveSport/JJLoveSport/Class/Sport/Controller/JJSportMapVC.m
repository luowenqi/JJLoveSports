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

@interface JJSportMapVC ()<MAMapViewDelegate>

@end

@implementation JJSportMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    //设置跟踪迷失
    _mapView.userTrackingMode =  MAUserTrackingModeFollowWithHeading;
    
    _mapView.showsCompass = YES;
    
    _mapView.showsScale = YES;
    
    _mapView.showTraffic = YES;
    
    _mapView.delegate = self;
    
    //关闭后台自动暂停开关
    _mapView.pausesLocationUpdatesAutomatically = NO;
    
    /**
     * 是否允许后台定位。默认为NO。只在iOS 9.0之后起作用。
     * 设置为YES的时候必须保证 Background Modes 中的 Location updates处于选中状态，否则会抛出异常。
     */
    _mapView.allowsBackgroundLocationUpdates = YES;

}


-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{

    NSLog(@"%.f-----%.f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    

}




@end
