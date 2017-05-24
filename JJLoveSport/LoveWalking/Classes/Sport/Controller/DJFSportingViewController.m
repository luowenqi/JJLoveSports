//
//  DJFSportingViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/2.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFSportingViewController.h"
#import "DJFMapViewController.h"
#import "DJFSportSpeaker.h"
#import "DJFSportSqlModel.h"
#import "DJFSportPolyLineSqlModel.h"
#import "DJFProgressHUD.h"
#import "DJFSportPolyLineSqlModel.h"
@interface DJFSportingViewController ()

/**
 继续按钮水平约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *continueButtronConstraint;

/**
 结束按钮水平约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *finishButtonConstraint;

/**
 运动距离
 */
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceUnit;

/**
 运动时长
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLablel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel1;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

/**
 运动速度
 */
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;


/**
 *  地图
 */
@property(nonatomic,strong)DJFMapViewController *mapVC;
/**
 *  运动轨迹数据模型
 */
@property(nonatomic,strong)DJFSportTrackingModel *sportTrackingModel;


/**
 *  平均速度
 */
@property(nonatomic,strong)UILabel *avgSpeedLbl;

/**
 *  总路程
 */
@property(nonatomic,strong)UILabel *distanceLbl;
/**
 *  最大速度
 */
@property(nonatomic,strong)UILabel *maxSpeedLbl;

/**
 *  speaker
 */
@property(nonatomic,strong)DJFSportSpeaker *speaker;

/**
 *  数据库模型
 */

@property(nonatomic,strong)DJFSportSqlModel * sqlModel;

@property(nonatomic,strong)DJFSportPolyLineSqlModel * polyLineSqlModel;
@end

@implementation DJFSportingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _speaker = [[DJFSportSpeaker alloc]init];
    _sqlModel = [DJFSportSqlModel new];
    _polyLineSqlModel = [DJFSportPolyLineSqlModel new];

    
}

- (void)setupUI{
    
    _sportTrackingModel = [[DJFSportTrackingModel alloc]initWithType:_sportType];
    _sportTrackingModel.Pause = YES;
    _mapVC  = [[UIStoryboard storyboardWithName:@"Sport" bundle:nil] instantiateViewControllerWithIdentifier:@"DJFMapViewController"];
    
    _mapVC.sportTrackingModel = _sportTrackingModel;
    _mapVC.view.backgroundColor = [UIColor whiteColor];
    
    [self setupStoryboard];
    
    [self setBackGroundLayer];
}

-(void)setBackGroundLayer{
    
    //创建渐变layer
    CAGradientLayer *layer = [[CAGradientLayer alloc]init];
    
    //设置大小
    layer.bounds = self.view.bounds;
    layer.position = self.view.center;
    
    //设置颜色
    CGColorRef color1 = [UIColor colorWithHex:0x262626].CGColor;
    CGColorRef color2 = [UIColor colorWithHex:0x5b5757].CGColor;
    CGColorRef color3 = [UIColor colorWithHex:0x282121].CGColor;
    layer.colors = @[(__bridge UIColor *)color1,(__bridge UIColor *)color2,(__bridge UIColor *)color3];
    layer.locations = @[@0,@0.6,@1];
    
    //添加到最底层
    [self.view.layer insertSublayer:layer atIndex:0];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    
    
}


-(void)setupStoryboard{
    
    if (_sportType == DJFSportTypeBike) {
        
        _stepLabel1.hidden = YES;
        _stepLablel.hidden = YES;
    }
    
    //更新数据
    __weak typeof(self) weakSelf = self;
    _sportTrackingModel.sportResult = ^(DJFSportTrackingModel *model) {
        
        
        //设置平均速度
        weakSelf.speedLabel.text = [NSString stringWithFormat:@"%0.2f",model.avgSpeed * 3.6];
        
        //设置距离
        if (model.totalDistance < 1000) {
            weakSelf.distanceLabel.text = [NSString stringWithFormat:@"%0.1f",model.totalDistance];
            weakSelf.distanceUnit.text = @"距离（米）";
        }else{
            weakSelf.distanceLabel.text = [NSString stringWithFormat:@"%0.2f",model.totalDistance * 0.001];
            weakSelf.distanceUnit.text = @"距离（公里）";
        }
        if (weakSelf.sportType == DJFSportTypeBike) {
            weakSelf.stepLablel.hidden = YES;
        }
        weakSelf.stepLablel.text = [NSString stringWithFormat:@"%zd",model.stepCount];
        
        //设置时间
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@",model.totalTimeStr];
        
        
    };
    
    
}

#pragma mark - 按钮点击事件
- (void)pauseSport{
    _sportTrackingModel.Pause = YES;
    [_speaker reportByText:@"暂停运动"];
    
}
- (void)startSport{
    _sportTrackingModel.Pause = NO;
    _sqlModel.startTime = [NSDate date].description;
    [_speaker reportByText:@"开始运动"];
}
- (void)endSport{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否保存运动数据？" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _sqlModel.endTime = [NSDate date].description;
        _sqlModel.totalDistance = @(_sportTrackingModel.totalDistance).description;
        _sqlModel.timeSpend = @(_sportTrackingModel.totalTime).description;
        _sqlModel.avgSpeed = @(_sportTrackingModel.avgSpeed).description;
        _sqlModel.stepCount = @(_sportTrackingModel.stepCount).description;
        _sqlModel.maxSpeed = @(_sportTrackingModel.maxSpeed).description;
        _sqlModel.sportType = @(_sportTrackingModel.sportType).description;


        if ([_sqlModel insertToDB]) {
            _sqlModel = [_sqlModel getLastSportSqlModel];
            if (_sqlModel.mid == 0) {
                [DJFProgressHUD showErrorMessage:@"保存失败"];
            }else{
                NSMutableArray* arrM = [NSMutableArray arrayWithCapacity:100];
                for (DJFSportTrackingLineModel* polyLine in _sportTrackingModel.polyLineList) {
                  
                    NSString* sql = [NSString stringWithFormat:@"INSERT INTO sportPolyLineRecord (startLatitude,startlongitude,endLatitude,endlongitude,lineColor,recordId) VALUES(\"%f\",\"%f\",\"%f\",\"%f\",\"%@\",\"%zd\")",polyLine.lastLocaion.coordinate.latitude,polyLine.lastLocaion.coordinate.longitude,polyLine.endLocation.coordinate.latitude,polyLine.endLocation.coordinate.longitude,[UIColor converUIColorToStirng:polyLine.lineColor],_sqlModel.mid];
                    
                    [arrM addObject:sql];
                }
                [_polyLineSqlModel insertPolyLineListByTransaction:arrM];
                [DJFProgressHUD showSuccessMessage:@"保存成功"];
            }
        }else{
            [DJFProgressHUD showErrorMessage:@"保存失败"];
        }
        [self dismissViewControllerAnimated:YES completion:nil];

    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];

    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
- (void)dealloc{
    //解决循环引用问题
    [_sportTrackingModel.sportTimeDisplayLink invalidate];
    
}
-(void)transBackground{
    
    [self presentViewController:_mapVC animated:YES completion:nil];
}


/**
 点击地图按钮
 */
- (IBAction)mapButtonClick:(UIButton *)sender {
    CGFloat x = sender.center.x - self.mapVC.mapView.compassSize.width/2;
    CGFloat y = sender.center.y - self.mapVC.mapView.compassSize.height/2;
    _mapVC.mapView.compassOrigin = CGPointMake(x, y);
    [self presentViewController:self.mapVC animated:YES completion:nil];
}

/**
 点击状态按钮
 */
- (IBAction)SportStateButtonClick:(UIButton *)sender {
    
    //设置运动状态
    self.mapVC.sportTrackingModel.sportstate = sender.tag;
    switch (sender.tag) {
            
        case SportStateContinue:
            [self foldButton:YES];
            [self startSport];
            break;
            
        case SportStatePause:
            [self foldButton:NO];
            [self pauseSport];
            break;
            
        case SportStateFinish:
            [self endSport];
            //[self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        default:
        {
            [self startSport];
            _startBtn.hidden = YES;
        }
    }
}
/**
 折叠/展开动画
 */
-(void)foldButton:(BOOL)isFold{
    
    //获取暂停按钮
    UIButton *pauseButton = [self.view viewWithTag:2];
    
    float pauseButtonW = pauseButton.bounds.size.width;
    
    BOOL isHidden = NO;
    
    if (isFold == YES) {
        
        _continueButtronConstraint.constant += 5 + pauseButtonW;
        
        _finishButtonConstraint.constant -= 5 + pauseButtonW;
        
        isHidden = NO;
        
    }else{
        
        _continueButtronConstraint.constant -= 5 + pauseButtonW;
        
        _finishButtonConstraint.constant += 5 + pauseButtonW;
        
        pauseButton.hidden = YES;
        isHidden = YES;
        
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            pauseButton.hidden = isHidden;
        }
    }];
    
}


#pragma mark -unwind segue

//使用segue unwind 需要满足两个条件  1.按钮是IBAction  2.参数是UIStoryboardSegue
-(IBAction)dismiss:(UIStoryboardSegue *)segue
{
    //里面不需要实现
}
@end
