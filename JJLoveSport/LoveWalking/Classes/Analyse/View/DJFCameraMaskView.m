//
//  DJFCameraMaskView.m
//  LoveWalking
//
//  Created by 罗文琦 on 2017/5/24.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFCameraMaskView.h"
#import <AVFoundation/AVFoundation.h>

@interface DJFCameraMaskView ()

/**
 预览视图
 */
@property(nonatomic , strong) UIView*  preView;

@end

@implementation DJFCameraMaskView



- (void)drawRect:(CGRect)rect {

    //1.使用贝塞尔路径填充颜色
    //1.1创建贝塞尔路径矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    //1.2.给当前绘制环境填充颜色
    UIColor *color = [UIColor colorWithRed:36/255.f green:40/255.f blue:46/255.f alpha:1];
    [color setFill];
    //1.3.使用绘制的贝塞尔路径填充当前绘制环境
    [path fill];
    
    //2.1绘制贝塞尔路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    //2.2设置线宽
    [linePath setLineWidth:0.8];
    
    //1.移动画笔到起点
    [linePath moveToPoint:CGPointMake(self.frame.size.width, 0)];
    //2.画线
    [linePath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    
    //2.4线条设置颜色
    UIColor *lineColor = [UIColor colorWithWhite:0.05 alpha:1];
    [lineColor setStroke];
    
    //2.5线条贝塞尔描边
    [linePath stroke];
    
    
    //2.1绘制贝塞尔路径
    UIBezierPath *linePath2 = [UIBezierPath bezierPath];
    //2.2设置线宽
    [linePath2 setLineWidth:0.8];
    
    //1.移动画笔到起点
    [linePath2 moveToPoint:CGPointMake(0, 0)];
    //2.画线
    [linePath2 addLineToPoint:CGPointMake(0, self.frame.size.height)];
    
    //2.4线条设置颜色
    UIColor *lineColor2 = [UIColor colorWithWhite:0.05 alpha:1];
    [lineColor2 setStroke];
    
    //2.5线条贝塞尔描边
    [linePath2 stroke];
    
    //3.0 使用清除图层清除颜色 第一个参数：上下文  第二个参数：要清除颜色的区域
    //为了避免由于像素锯齿导致的显示问题，建议这里清除图层最好比图片的尺寸小一个像素
    CGContextClearRect(UIGraphicsGetCurrentContext(), CGRectInset(self.subviews[0].frame, 1, 1));
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)awakeFromNib{
    
    
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    
}

@end
