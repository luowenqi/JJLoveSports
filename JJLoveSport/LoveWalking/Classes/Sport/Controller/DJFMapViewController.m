//
//  DJFMapViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFMapViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "DJFSportTrackingLineModel.h"
#import "DJFSportPolyLine.h"
#import "DJFStepManager.h"
#import "DJFMapTypeViewController.h"
#import "DJFGPSState.h"
#import "DJFCustomAnimation.h"
#import "DJFSportingViewController.h"
@interface DJFMapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,UIPopoverPresentationControllerDelegate>

/**
 运动时长
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/**
 运动距离
 */
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

/**
 *  地图
 */
//@property(nonatomic,strong)MAMapView * mapView;

/**
 *  地图管理对象
 */
@property(nonatomic,strong)AMapLocationManager * locatonManager;

@property (weak, nonatomic) IBOutlet UILabel *distanceUnitLbl;

/**
 *  自定义转场动画
 */
@property(nonatomic,strong)DJFCustomAnimation * customAnimation;;
@end

@implementation DJFMapViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma mark - 搭建UI
- (void)setupUI{

    
    //设置跳转样式
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.customAnimation = [[DJFCustomAnimation alloc]init];
    self.transitioningDelegate = self.customAnimation;
    

    //加载地图
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupMap];
     
    });
    
}
- (IBAction)choseButtonClick:(id)sender {
    
    [self choseMapType:sender];
    
}




-(void)choseMapType:(UIButton*)btn{
    
    //创建选择地图类型控制器
    DJFMapTypeViewController* mapTypeVC = [DJFMapTypeViewController new];
    mapTypeVC.view.backgroundColor = [UIColor whiteColor];
    //设置跳转样式
    mapTypeVC.modalPresentationStyle = UIModalPresentationPopover;
    
    //获取popover对象
    UIPopoverPresentationController* popoverVC = mapTypeVC.popoverPresentationController;
    //从哪个控制器视图弹出来
    popoverVC.sourceView = self.view;
    //弹出位置
    popoverVC.sourceRect = btn.frame;
    //设置箭头方法
    popoverVC.permittedArrowDirections = UIPopoverArrowDirectionDown;
    //设置弹出控制器视图的大小
    mapTypeVC.preferredContentSize = CGSizeMake(320, 120);
    
    popoverVC.delegate = self;
    [self presentViewController:mapTypeVC animated:YES completion:nil];
    
    /*
     MAMapTypeStandard = 0,  ///< 普通地图
     MAMapTypeSatellite,     ///< 卫星地图
     MAMapTypeStandardNight, ///< 夜间视图
     MAMapTypeNavi,          ///< 导航视图
     MAMapTypeBus            ///< 公交视图
     */
    mapTypeVC.mapType = ^(DJFMapType mapType) {
        switch (mapType) {
            case DJFMapTypeFlat:
                [_mapView setMapType:MAMapTypeStandard];
                break;
            case DJFMapTypeReal:
                [_mapView setMapType:MAMapTypeSatellite];
                break;
            case DJFMapTypeMix:
                [_mapView setMapType:MAMapTypeStandardNight];
                break;
            default:
                break;
        }
        
    };
    
}


- (void)stopLocation{
    [_locatonManager stopUpdatingLocation];
}

/**
 创建及设置地图
 */
- (void)setupMap{
    
    
    //MARK: 地图
    //创建地图
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0,0, SCREEN_BOUNDS.size.width, SCREEN_BOUNDS.size.height)];
    [self.view insertSubview:_mapView atIndex:0];
    
    //设置用户追踪模式
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
    //设置其它
    _mapView.showTraffic = YES;
    _mapView.showsScale = NO;
    
    //关闭相机旋转（省电）
    _mapView.rotateEnabled = NO;
    
    //设置代理
    _mapView.delegate = self;
    
    //设置罗盘位置
    
    
    
    //MARK: 地图管理对象
    //创建地图管理对象
    _locatonManager = [[AMapLocationManager alloc]init];
    //关闭自动暂停定位
    //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
    _locatonManager.pausesLocationUpdatesAutomatically = NO;
    //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9){
        _locatonManager.allowsBackgroundLocationUpdates = YES;
    }
    
    //设置最小更新距离
    _locatonManager.distanceFilter = 15;
    //开启持续定位
    [_locatonManager startUpdatingLocation];
    
    _locatonManager.delegate = self;
    
    
}

-(void)setupDataUI{
    //设置距离
    if (_sportTrackingModel.totalDistance < 1000) {
        _distanceLabel.text = [NSString stringWithFormat:@"%0.1f",_sportTrackingModel.totalDistance];
        _distanceUnitLbl.text = @"距离（米）";
    }else{
        _distanceLabel.text = [NSString stringWithFormat:@"%0.2f",_sportTrackingModel.totalDistance * 0.001];
        _distanceUnitLbl.text = @"距离（公里）";
    }
    
    _timeLabel.text = [NSString stringWithFormat:@"%@",_sportTrackingModel.totalTimeStr];
}

#pragma mark - 地图管理代理 AMapLocationManagerDelegate
/**
 *  @brief 连续定位回调函数.注意：如果实现了本方法，则定位信息不会通过amapLocationManager:didUpdateLocation:方法回调。
 *  @param manager 定位 AMapLocationManager 类。
 *  @param location 定位结果。
 *  @param reGeocode 逆地理信息。
 */
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    
    if (_sportTrackingModel.sportStartLocation == nil) {
        return;
    }
    
    DJFSportPolyLine* polyLine = [_sportTrackingModel drawPolylineWithLocation:location];
    [_mapView addOverlay:polyLine];
    
    
    
}

#pragma mark - 地图代理 MAMapViewDelegate

/**
 * @brief 根据overlay生成对应的Renderer
 * @param mapView 地图View
 * @param overlay 指定的overlay
 * @return 生成的覆盖物Renderer
 */
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay{
    //判断类型
    if (![overlay isKindOfClass:[MAPolyline class]]) {
        return  nil;
    }
    //创建并设置线条的属性
    MAPolylineRenderer* lineRender = [[MAPolylineRenderer alloc]initWithPolyline:overlay];
    lineRender.lineWidth = 5;
    DJFSportPolyLine* polyLine = (DJFSportPolyLine*)lineRender.polyline;
    lineRender.strokeColor = polyLine.lineColor;
    
    //返回
    return lineRender;
}



/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation;{
    if (updatingLocation) {
        //前面定位不太准备，过滤到前面几次定位，获取最终的起始位置
        static int i = 0;
        if (i<3) {
            i+=1;
            return;
        }
        //创建起点
        if (_sportTrackingModel.sportStartLocation == nil) {
            //创建起点
            [_sportTrackingModel drawPolylineWithLocation:userLocation.location ];
            if (_sportTrackingModel.sportStartLocation == nil || _sportTrackingModel.LastStartLocation != nil) {
                return;
            }
            //创建并设置大头针
            MAPointAnnotation* pointAnn = [[MAPointAnnotation alloc]init];
            pointAnn.coordinate = userLocation.coordinate;
            [mapView addAnnotation:pointAnn];
            
            
            //根据起点放大地图
            CGPoint startPoint = [mapView convertCoordinate:userLocation.coordinate toPointToView:_mapView];
            [_mapView setZoomLevel:15 atPivot:startPoint animated:NO];
            
            
            
        }
    }
    
    [self setupDataUI];
}
/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    //判断大头针类型
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        //复用大头针
        static NSString* resID = @"customAnnotation";
        MAAnnotationView* annView = [mapView dequeueReusableAnnotationViewWithIdentifier:resID];
        
        //创建大头针
        if (annView == nil) {
            annView = [[MAAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:resID];
            
            
            //设置大头针图片
            annView.image = self.sportTrackingModel.sportIcon;
            annView.centerOffset = CGPointMake(0, -self.sportTrackingModel.sportIcon.size.height * 0.5);
            
        }
        //[_mapView showAnnotations:@[annotation] animated:YES];
        
        return  annView;
    }
    return nil;
}

#pragma mark UIPopoverPresentationControllerDelegate
//返回popover自适应的样式(该方法只对iPhone有效.在iPhone下popover的跳转默认为全屏,在该代理中返回UIModalPresentationNone表示取消全屏自适应)
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection
{
    //返回UIModalPresentationNone表示在iPhopne下取消全屏自适应
    return UIModalPresentationNone;
}
//- (void)dealloc{
//
//  NSLog(@"地图释放了");
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
