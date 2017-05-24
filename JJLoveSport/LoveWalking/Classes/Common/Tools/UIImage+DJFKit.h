//
//  UIImage+DJFKit.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/18.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DJFKit)
//修改image的大小

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

// 控件截屏
+ (UIImage *)imageWithCaputureView:(UIView *)view;

@end
