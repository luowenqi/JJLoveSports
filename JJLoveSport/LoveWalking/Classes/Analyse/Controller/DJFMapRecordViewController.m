//
//  DJFMapRecordViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/16.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFMapRecordViewController.h"
#import "DJFSportPolyLineSqlModel.h"
#import "DJFSportPolyLine.h"
#import "CADisplayLink+DJFKit.h"
#import "DJFCameraVC.h"
#define Margin 10

@interface DJFMapRecordViewController ()<MAMapViewDelegate,CLLocationManagerDelegate,UIPopoverPresentationControllerDelegate>
/**
 *  <#名称#>
 */
@property(nonatomic,strong)MAMapView *mapView;
/**
 *  <#名称#>
 */
@property(nonatomic,strong)NSArray<DJFSportPolyLineSqlModel*> *mapPolyLineList;

/**
 *  <#名称#>
 */
@property (nonatomic, strong) CADisplayLink* displayLink;
/**
 *
 */
@property(nonatomic,copy)NSMutableArray<DJFSportPolyLine*>* arrayM;
/**
 *  <#名称#>
 */
@property(nonatomic,assign)NSInteger polyLineCount;

@property(nonatomic,assign)NSInteger currentIndex;


/**
 最大速度
 */
@property(nonatomic , strong)  UILabel* maxSpeedLab;



/**
 平均速度
 */
@property(nonatomic , strong) UILabel* avgSpeedLab;

/**
 运动总时间
 */
@property(nonatomic , strong) UILabel * totalTimeLab;


/**
 运动总距离
 */
@property(nonatomic , strong) UILabel * totalDistanceLab;


/**
 运动步数
 */
@property(nonatomic , strong) UILabel* stepNumLab;

@end

@implementation DJFMapRecordViewController{
    ;

   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapPolyLineList = [NSArray array];
    [self.view layoutIfNeeded];
    // Do any additional setup after loading the view.

    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    //定时绘制路线
     [self setupMapLineData];
}


- (void)setupUI{
    _mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
    //设置代理
    _mapView.delegate = self;
    [self setupInfo];
    [self setRightItem];
}

#pragma mark - 设置nav右侧的按钮
-(void)setRightItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takeAPhotoOrsaveScreenshot:)];
}

//拍照或者保存截图
-(void)takeAPhotoOrsaveScreenshot:(UIBarButtonItem*)sender{
    UIAlertController* alerController = [UIAlertController alertControllerWithTitle:@"" message:@"请选择操作" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* photograph = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        DJFCameraVC* cameraVC = [[DJFCameraVC alloc]init];
        [self presentViewController:cameraVC animated:YES completion:nil];
    }];
    [alerController addAction:photograph];
    
    
    UIAlertAction* Screenshot = [UIAlertAction actionWithTitle:@"截图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             UIGraphicsBeginImageContextWithOptions(self.view.window.bounds.size, YES, 0);
            [self.view.window drawViewHierarchyInRect:self.view.window.frame afterScreenUpdates:YES];
            UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
            UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            //结束图片上下文
            UIGraphicsEndImageContext();
    }];
    
    [alerController addAction:Screenshot];
    UIAlertAction* cancel= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alerController addAction:cancel];
    [self presentViewController:alerController animated:YES completion:nil];
}



#pragma mark - 完成拍摄
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error == nil)
    {
        UIAlertController* alerController = [UIAlertController alertControllerWithTitle:@"保存截图成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alerController addAction:action];
        [self presentViewController:alerController animated:YES completion:nil];
    }
}



- (void)setupMapLineData{
    //获取线条数据
    _mapPolyLineList = [[DJFSportPolyLineSqlModel new]getListByRecordId:@(_mid).description];
     _arrayM = [NSMutableArray arrayWithCapacity:_mapPolyLineList.count];
    
    //遍历数组并创建线条模型数组
    for (DJFSportPolyLineSqlModel* polyLineSql in _mapPolyLineList) {
        CLLocationCoordinate2D coord[2];
        coord[0].latitude = polyLineSql.startLatitude;
        coord[0].longitude = polyLineSql.startlongitude;
        
        coord[1].latitude = polyLineSql.endLatitude;
        coord[1].longitude = polyLineSql.endlongitude;
        
        DJFSportPolyLine* polyLine = [DJFSportPolyLine polylineWithCoordinates:coord count:2 andPolyLineColor:[UIColor toUIColorByStr:polyLineSql.lineColor]];

        [_arrayM addObject:polyLine];
        
    }
    
    //计算可能区别及设置可以区域的中心点
    CGFloat maxLatitude = [[_arrayM valueForKeyPath:@"@max.startLatitude"] floatValue];
    CGFloat minLatitude = [[_arrayM valueForKeyPath:@"@min.endLatitude"] floatValue];
    CGFloat maxlongitude = [[_arrayM valueForKeyPath:@"@max.startlongitude"] floatValue];
    CGFloat minlongitude = [[_arrayM valueForKeyPath:@"@min.endlongitude"] floatValue];
    CGFloat regionLatitude = maxLatitude - minLatitude + 0.01;
    CGFloat regionLongitude = maxlongitude - minlongitude + 0.01;
    
    MACoordinateSpan span = {regionLatitude, regionLongitude}; //显示范围精度
    CLLocationCoordinate2D center = {(maxLatitude + minLatitude)*0.5 - 0.005,(maxlongitude + minlongitude)*0.5};
    MACoordinateRegion region = {center, span}; //显示区域
    [_mapView setRegion:region animated:NO];
    //[_mapView setCenterCoordinate:center];

    //开启定时描绘线条
    __weak typeof(self) weakSelf = self;
    _displayLink = [CADisplayLink displayLinkWithExecuteBlock:^(CADisplayLink *displayLink) {
        if (weakSelf.currentIndex < weakSelf.polyLineCount) {
            [weakSelf.mapView addOverlay:weakSelf.arrayM[weakSelf.currentIndex]];
            weakSelf.currentIndex ++ ;
        }else{
            [weakSelf.displayLink setPaused:YES];
        }
    }];
    _displayLink.frameInterval = 0.5;
    
    
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    _polyLineCount = _arrayM.count;
}


#pragma mark - 设置底部信息栏
- (void)setupInfo{
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    [self.view addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(2*Margin);
        make.bottom.equalTo(self.view.mas_bottom).offset(-2*Margin);
        make.right.equalTo(self.view).offset(-2*Margin);
        make.height.offset(100);
    }];
    effectView.layer.masksToBounds = YES;
    effectView.layer.cornerRadius = 15;
    
    
    UILabel* totalTimeLbl = [UILabel new];
    [effectView addSubview:totalTimeLbl];
    _totalTimeLab = totalTimeLbl;
    _totalTimeLab.font = [UIFont boldSystemFontOfSize:30];
    _totalTimeLab.textColor = [UIColor whiteColor];
    
    
     UILabel* totalDistanceLbl = [UILabel new];
     [effectView addSubview:totalDistanceLbl];
    _totalDistanceLab = totalDistanceLbl;
    totalDistanceLbl = totalDistanceLbl;
    totalDistanceLbl.font = [UIFont boldSystemFontOfSize:30];
    totalDistanceLbl.textColor = [UIColor whiteColor];
    
    
    //设置时间以及距离的位置
    [totalTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(effectView.mas_top).offset(Margin);
        make.centerX.equalTo(effectView.mas_centerX).multipliedBy(0.5);
    }];
    
    [totalDistanceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(effectView.mas_top).offset(Margin);
        make.centerX.equalTo(effectView.mas_centerX).multipliedBy(1.5);
    }];
    
    //总计时间lab(固定不变)
    UILabel* timeStringLab = [[UILabel alloc]init];
    timeStringLab.text = @"🕒总计时间";
    [effectView addSubview:timeStringLab];
    [timeStringLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(effectView.mas_centerX).multipliedBy(0.5);
        make.top.equalTo(totalTimeLbl.mas_bottom).offset(Margin/2);
    }];
    timeStringLab.font = [UIFont systemFontOfSize:14];
    timeStringLab.textColor = [UIColor colorWithWhite:0.8 alpha:1];
    
    
    
    
    
    //全程总距离lab(固定不变)
    UILabel* distanceStingLab = [[UILabel alloc]init];
    distanceStingLab.text = @"全程总距离：公里";
    [effectView addSubview:distanceStingLab];
    [distanceStingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(effectView.mas_centerX).multipliedBy(1.5);
        make.top.equalTo(totalTimeLbl.mas_bottom).offset(Margin/2);
    }];
    distanceStingLab.font = [UIFont systemFontOfSize:14];
    distanceStingLab.textColor = [UIColor colorWithWhite:0.8 alpha:1];
    
    
    
    
    //添加一条细线
    UIView* colorView = [[UIView alloc]init];
    [effectView addSubview:colorView];

    [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(effectView);
        make.height.mas_offset(1.5);
        make.centerY.equalTo(effectView).offset(-12);
    }];
    [self.view layoutIfNeeded];
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    gradientLayer.type = kCAGradientLayerAxial;
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint =CGPointMake(1, 0.5);
    gradientLayer.position = colorView.center;
    gradientLayer.bounds = colorView.bounds;
    [colorView.layer addSublayer:gradientLayer];
    gradientLayer.locations = @[@0,@0.6,@1];
    CGColorRef color1 = [UIColor redColor].CGColor;
    CGColorRef color2 = [UIColor yellowColor].CGColor;
    CGColorRef color3 = [UIColor greenColor].CGColor;
    gradientLayer.colors = @[(__bridge UIColor*)color1,(__bridge UIColor*)color2,(__bridge UIColor*)color3];
 

    //最大速度
    UILabel* maxSpeedLab = [[UILabel alloc]init];
    [effectView addSubview:maxSpeedLab];
    [maxSpeedLab mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.centerX.equalTo(effectView.mas_centerX).multipliedBy(0.5);
        make.left.equalTo(effectView.mas_left).offset(Margin);
        make.bottom.equalTo(effectView.mas_bottom).offset(-Margin/2);
    }];
    
    maxSpeedLab.textColor = [UIColor whiteColor];
    maxSpeedLab.font = [UIFont systemFontOfSize:13];
    _maxSpeedLab = maxSpeedLab;
    
    
    
    //最大速度
    UILabel* stepNumLab = [[UILabel alloc]init];
    [effectView addSubview:stepNumLab];
    [stepNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(effectView.mas_centerX);
        make.bottom.equalTo(effectView.mas_bottom).offset(-Margin/2);
    }];
    
    stepNumLab.textColor = [UIColor whiteColor];
    stepNumLab.font = [UIFont systemFontOfSize:13];
    _stepNumLab = stepNumLab;
    
    
    
    
    //平均速度
    UILabel* avgSpeedLab = [[UILabel alloc]init];
    [effectView addSubview:avgSpeedLab];
    [avgSpeedLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(effectView.mas_centerX).multipliedBy(1.5);
        make.right.equalTo(effectView.mas_right).offset(-Margin);
        make.bottom.equalTo(effectView.mas_bottom).offset(-Margin/2);
    }];
    
    avgSpeedLab.textColor = [UIColor whiteColor];
    avgSpeedLab.font = [UIFont systemFontOfSize:13];
    _avgSpeedLab = avgSpeedLab;
   
    
}

#pragma mark - 视图即将消失
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
    [_displayLink setPaused:YES];
     [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
   
}

#pragma mark - 设置线条
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        DJFSportPolyLine* polyLine = (DJFSportPolyLine*)overlay;
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = polyLine.lineColor;
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}

-(void)setSportSqlModel:(DJFSportSqlModel *)sportSqlModel{

    _sportSqlModel = sportSqlModel;
    _totalTimeLab.text = [NSString stringWithFormat:@"%02zd:%02zd:%02zd",sportSqlModel.timeSpend.integerValue/3600,(sportSqlModel.timeSpend.integerValue%3600)/60,sportSqlModel.timeSpend.integerValue%60];
    _totalDistanceLab.text = [NSString stringWithFormat:@"%.2lf",sportSqlModel.totalDistance.floatValue * 0.001];
    _maxSpeedLab.text = [NSString stringWithFormat:@"最大速度%.2lf m/s",(sportSqlModel.maxSpeed.floatValue)];
    _avgSpeedLab.text = [NSString stringWithFormat:@"平均速度%.2lf m/s",(sportSqlModel.avgSpeed.floatValue)];
    _stepNumLab.text =[NSString stringWithFormat:@"步数%ld",sportSqlModel.stepCount.integerValue];
}



-(void)dealloc{
    
}
@end
