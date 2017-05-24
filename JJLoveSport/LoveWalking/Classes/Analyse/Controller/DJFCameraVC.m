//
//  DJFCameraVC.m
//  LoveWalking
//
//  Created by 罗文琦 on 2017/5/24.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFCameraVC.h"
#import "DJFCameraMaskView.h"
#import "DJFPhotoRecorder.h"
#define Margin 10

@interface DJFCameraVC ()<DJFPhotoRecorderDelegate>


/**
 底部视图
 */
@property(nonatomic , strong) UIView * bottomView;


/**
 左侧动画界面
 */
@property(nonatomic , strong) DJFCameraMaskView* gearLeftView ;


/**
 右侧动画界面
 */
@property(nonatomic , strong) DJFCameraMaskView* gearRightView;


/**
 拍摄工具
 */
@property(nonatomic , strong) DJFPhotoRecorder * photoRecoder;


/**
 拍摄预览界面
 */
@property(nonatomic , strong) UIView * photoPreView;


/**
 水印图片
 */
@property(nonatomic , strong) UIImageView * waterPic;


@end

@implementation DJFCameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupUI];
    if (self.photoRecoder == nil) {
        self.photoRecoder = [[DJFPhotoRecorder alloc] initWithPreView:self.photoPreView];
        self.photoRecoder.delegate = self;
    }
}


-(void)setupUI{
    [self addBottomView];
    [self addPhotoPreView];
    [self addGearView];
    [self addWaterPic];


}

#pragma mark - 加水印图片
-(void)addWaterPic{

    UIImageView* waterPic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_waterprint_action_oriented"]];
    _waterPic = waterPic;
    [self.photoPreView addSubview:waterPic];
    
    [waterPic mas_makeConstraints:^(MASConstraintMaker *make) {
        [make centerX];
        make.bottom.equalTo(self.photoPreView.mas_bottom).offset(-Margin);
    }];
}



#pragma mark -HMPhotoRecorderDelegate
- (void)waterImage:(DJFPhotoRecorder *)recorder
{
    [self.waterPic.image drawInRect:self.waterPic.frame];
}


-(void)addPhotoPreView{
    
    UIView* photoPreview = [[UIView alloc]init];
    self.photoPreView = photoPreview;
    [self.view addSubview:photoPreview];
    [photoPreview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self.view layoutIfNeeded];
}

#pragma mark - 添加齿轮特效view
-(void)addGearView{
    
    //左侧齿轮
    DJFCameraMaskView* gearLeftView = [[DJFCameraMaskView alloc]init];
    self.gearLeftView = gearLeftView;
    [self.view addSubview:gearLeftView];
    [gearLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.right.equalTo(self.view.mas_left).offset(-52);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width/2);
    }];
    UIImageView* gearLeftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_shutter_center_left"]];
    [gearLeftView addSubview:gearLeftImageView];
    [gearLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(gearLeftView);
        make.right.equalTo(gearLeftView.mas_right).offset(52);
    }];
    
    
    //右侧齿轮
    DJFCameraMaskView* gearRightView = [[DJFCameraMaskView alloc]init];
    self.gearRightView = gearRightView;
    [self.view addSubview:gearRightView];
    
    [gearRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view.mas_right).offset(52);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width/2);
    }];
    
    UIImageView* gearRightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_shutter_center_right"]];
    [gearRightView addSubview:gearRightImageView];
    [gearRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(gearRightView);
        make.left.equalTo(gearRightView.mas_left).offset(-52);
    }];
}




//#pragma mark - 拍照
-(void)takeAphotoButtonClick:(UIButton*)sender{
    
    [self.photoRecoder capture:^(UIImage *image) {
    }];
    
    [self.gearLeftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_left).offset([UIScreen mainScreen].bounds.size.width/2);
    }];
    
    [self.gearRightView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right).offset(-[UIScreen mainScreen].bounds.size.width/2);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        
        [self.gearRightView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_right).offset(52);
        }];
        
        [self.gearLeftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_left).offset(-52);
        }];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }];
    
    //拍照动画
//    [self captureAnimationWithCaptureButton:sender];
    
    
    
 
}


#pragma mark - 转换摄像头
-(void)convertCameraButtonClick:(UIButton*)sender{
    [self.photoRecoder switchCamera];
}



#pragma mark - 添加底部视图
-(void)addBottomView{
    
    UIView* bottomView = [[UIView alloc]init];
    self.bottomView = bottomView;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_offset(120);
    }];
    bottomView.backgroundColor = [UIColor darkGrayColor];
    
    
    UIButton* cancelButton = [[UIButton alloc]init];
    [cancelButton setImage:[UIImage imageNamed:@"ic_waterprint_close"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(bottomView).offset(2*Margin);
    }];
    
    
    UIButton* takePhotoButton = [[UIButton alloc]init ];
    [takePhotoButton setImage:[UIImage imageNamed:@"ic_waterprint_shutter"] forState:UIControlStateNormal];
    [takePhotoButton addTarget:self action:@selector(takeAphotoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:takePhotoButton];
    [takePhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.centerX.equalTo(bottomView.mas_centerX);
    }];
    
    
    UIButton* convertCameraButton = [[UIButton alloc]init];
    [convertCameraButton setImage:[UIImage imageNamed:@"ic_waterprint_revolve"] forState:UIControlStateNormal];
    [convertCameraButton addTarget:self action:@selector(convertCameraButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:convertCameraButton];
    [convertCameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.right.equalTo(bottomView.mas_right).offset(-2*Margin);
    }];
}


#pragma mark - dissMiss
-(void)dismiss:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
