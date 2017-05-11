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


/**
 起点位置
 */
@property(nonatomic , strong) CLLocation * startLocation;


/**
 地图
 */
@property(nonatomic , strong) MAMapView *mapView;
@end

@implementation JJSportMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
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

   // NSLog(@"%.f-----%.f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
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




@end
