//
//  HMPhotoRecorder.h
//  JiuQiXing
//
//  Created by HM09 on 2017/5/19.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol DJFPhotoRecorderDelegate;

@interface DJFPhotoRecorder : NSObject

//创建自定义相机  参数：预览视图
- (instancetype)initWithPreView:(UIView *)preView;

- (void)start;

- (void)stop;

//前后摄像头对调
- (void)switchCamera;

//拍照
- (void)capture:(void(^)(UIImage *))completion;

@property(nonatomic,weak)id<DJFPhotoRecorderDelegate>delegate;

@end

@protocol DJFPhotoRecorderDelegate <NSObject>

- (void)waterImage:(DJFPhotoRecorder *)recorder;



@end
