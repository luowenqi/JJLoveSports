//
//  HMPhotoRecorder.m
//  JiuQiXing
//
//  Created by HM09 on 2017/5/19.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "DJFPhotoRecorder.h"

#import <AVFoundation/AVFoundation.h>

/**
 #import <AVFoundation/AVCaptureDevice.h>
 #import <AVFoundation/AVCaptureInput.h>
 #import <AVFoundation/AVCaptureOutput.h>
 #import <AVFoundation/AVCaptureSession.h>
 #import <AVFoundation/AVCaptureVideoPreviewLayer.h>
 */

@interface DJFPhotoRecorder ()

//预览视图
@property(nonatomic,strong)UIView *preView;

//输入设备（摄像头）
@property(nonatomic,strong)AVCaptureDeviceInput *captureDeviceInput;

//输出设备（静态图像输出）
@property(nonatomic,strong)AVCaptureStillImageOutput *captureStillImageOutput;
//拍摄会话
@property(nonatomic,strong)AVCaptureSession *captureSession;
//预览图层
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@end

@implementation DJFPhotoRecorder


- (instancetype)initWithPreView:(UIView *)preView
{
    self = [super init];
    self.preView = preView;
    
    //搭建拍摄会话环境
    [self setupSession];
    return self;
}

#pragma mark -切换摄像头
//原理：将后置摄像头先从拍摄会话中移除，然后再将前置摄像头添加到拍摄会话
- (void)switchCamera
{
    //1.先获取当前摄像头的方向
    AVCaptureDevicePosition position = self.captureDeviceInput.device.position;
    //2.目标摄像头的方向(当前摄像头的反方向)
    AVCaptureDevicePosition desPosition = position==AVCaptureDevicePositionBack?AVCaptureDevicePositionFront:AVCaptureDevicePositionBack;
    //2.从设备数组中获取与当前摄像头反方向的摄像头
    //创建设备（拍照：摄像头）
    __block AVCaptureDevice *device;
    //获取当前设备所支持的所有的硬件设备(模拟器没有设备)
    NSArray *arr = [AVCaptureDevice devices];
    //遍历数组，找到后置摄像头
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AVCaptureDevice *captureDevice = (AVCaptureDevice *)obj;
        
        if (captureDevice.position == desPosition) {
            device = captureDevice;
        }
    }];
    
    //为了避免切换摄像头的过渡效果，我们可以在切换输入设备之前先停止拍摄会话运行，等新的输入设备添加之后再开启会话
    [self.captureSession stopRunning];
    
    //3.创建新的输入设备
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    //4.先移除旧的输入设备（拍摄会话不能同时执行前后摄像头，如果不移除则不能添加新的输入设备）
    [self.captureSession removeInput:self.captureDeviceInput];
    //5.再加入新输入设备
    if ([self.captureSession canAddInput:input]) {
        [self.captureSession addInput:input];
    }
    
    //6.保存本次新的输入设备
    self.captureDeviceInput = input;
    
    //7.重新开启会话
    [self.captureSession startRunning];
    
}


#pragma mark -获取图片
- (void)capture:(void (^)(UIImage *))completion
{
    //0.获取输出设备与输入设备之间的连接(数组中一般只有一个元素，取决于输入设备数量)
    NSArray *arr= self.captureStillImageOutput.connections;
    AVCaptureConnection *conection = arr.lastObject;
    //1.从输出设备中获取数据(异步操作：拍摄过程内存环境很复杂，同步达不到要求)
    /**
     Connection：输出设备与输入设备之间的连接
     completionHandler：完成回调
     */
    [self.captureStillImageOutput captureStillImageAsynchronouslyFromConnection:conection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
        //报错信息
        if (error == nil) {
            //输出设备图像缓冲区(负责管理与图像相关的一切内存缓冲区：原始图片内存，胶卷，焦距，曝光长度，制造商)
           // NSLog(@"%@",imageDataSampleBuffer);
            
            //2.从图像缓冲区中获取图像(同步操作)
           NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            
            //3.获取图片(默认图片大小是屏幕的大小，要想图片显示与预览视图一样大小)
            UIImage *image = [UIImage imageWithData:data];
            //NSLog(@"%@",image);
            
            //4.裁切图片
            UIImage *resultImage = [self cutImageWithSourceImage:image];
            
            //4.送出回调
            if (completion) {
                completion(image);
            }
            
            //5.将图片保存到系统相册(异步)
            UIImageWriteToSavedPhotosAlbum(resultImage, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
        }
        else
        {
            NSLog(@"%@",error.description);
        }
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error == nil)
    {
       // NSLog(@"图片保存到系统相册成功");
    }
}

- (UIImage *)cutImageWithSourceImage:(UIImage *)image
{
    //1.开启图片绘制上下文(画布的大小，最终绘制图片的大小)
    UIGraphicsBeginImageContext(self.preView.bounds.size);
    
    //3.绘制图片
    
    //3.1 计算需要裁切的大小
    CGFloat width = [UIScreen mainScreen].bounds.size.width - self.preView.bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height - self.preView.bounds.size.height;
    
    [image drawInRect:CGRectInset(self.preView.frame, -width*0.5, -height*0.5)];

    
    //3.1在上下文绘制图片的环境中送出代理，以便外部可以直接添加水印照片
    //1.照片添加水印一定要在上下文绘制环境中添加，所以一定要在关闭上下文之前送出代理
    //2.为了避免水印添加在被裁切的区域，所以建议在原图片裁切之后送出代理
    //3.添加水印照片操作需要在获取上下文图片之前进行
    if (self.delegate && [self.delegate respondsToSelector:@selector(waterImage:)]) {
        [self.delegate waterImage:self];
    }
    
    //4.从上下文中获取裁切好的图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    //5.关闭上下文
    UIGraphicsEndImageContext();
    
    //6.返回图片
    return resultImage;
}


- (void)start
{
    [self.captureSession startRunning];
}

- (void)stop
{
    [self.captureSession stopRunning];
}

- (void)setupSession
{
    //0创建设备（拍照：摄像头）
    __block AVCaptureDevice *device;
    //获取当前设备所支持的所有的硬件设备(模拟器没有设备)
    NSArray *arr = [AVCaptureDevice devices];
    //遍历数组，找到后置摄像头
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AVCaptureDevice *captureDevice = (AVCaptureDevice *)obj;
       if (captureDevice.position == AVCaptureDevicePositionBack)
       {
           device = captureDevice;
       };
    }];
    
    
    
    //1.创建输入设备  参数：设备  error：报错信息
    self.captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //2.创建输出设备
    self.captureStillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    //3.创建拍摄会话
    self.captureSession = [[AVCaptureSession alloc] init];
    //4.将输入设备输出设备添加到拍摄会话
    if ([self.captureSession canAddInput:self.captureDeviceInput]) {
        [self.captureSession addInput:self.captureDeviceInput];
    }
    if ([self.captureSession canAddOutput:self.captureStillImageOutput]) {
        [self.captureSession addOutput:self.captureStillImageOutput];
    }
    
    //5.创建预览图层
    self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    
    
    //6.将预览图层添加到预览视图，（这里为了避免遮盖其他视图，建议使用insert插入到最深处）
    [self.preView.layer insertSublayer:self.captureVideoPreviewLayer atIndex:0];
    
    //6.1设置预览图层的位置(position)和大小(bounds)
    self.captureVideoPreviewLayer.position = self.preView.center;
    self.captureVideoPreviewLayer.bounds = self.preView.bounds;
    
    //6.2 设置预览图层的
    //系统默认是：AVLayerVideoGravityResizeAspect相当于AspectFit(当图片大于视图时，图片会等比缩小，导致视图只有部分区域才能看到图片) 为了更好的用户体验这里强烈建议大家使用：AVLayerVideoGravityResizeAspectFill（当图片大于视图时，图片不会等比缩小也不会放大，只是视图只能看到图片的部分区域）
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    
    //7.开启会话（拍摄会话开始工作：捕捉图像）
    [self.captureSession startRunning];
}

@end
