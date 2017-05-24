//
//  DJFHomeViewController.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.

#import "DJFSportTimingView.h"

@interface DJFSportTimingView ()

@property(nonatomic,strong)UIView *sourceView;

@property(nonatomic,copy)void(^completionBlock)(void);


//倒计时文本
@property(nonatomic,strong)UILabel *label;
//倒计时透明圆形视图
@property(nonatomic,strong)UIView *circleView;

@end

@implementation DJFSportTimingView

- (instancetype)initWithSourceView:(UIView *)sourceView Completion:(void(^)(void))completion
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    self.sourceView = sourceView;
    self.completionBlock = completion;
    
    //1.添加CAShapeLayer图层动画
    [self addLayerAnimation];
    
    return self;
}

- (void)addLayerAnimation
{
    //1.创建形状图层ShapreLayer
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    //2.创建圆形贝塞尔路径  参数是圆的外接矩形
    
    
    //默认情况下，frame属性是父视图坐标系，我们不能保证sourceView的父视图一定是控制器视图，所以这里可以将sourceView的位置转化为相对于屏幕坐标系的位置
    
    CGRect startRect = [self.sourceView convertRect:self.sourceView.bounds toView:self];
    UIBezierPath *startBezierPath = [UIBezierPath bezierPathWithOvalInRect:startRect];
    
    
    CGFloat sWidth = self.frame.size.width;
    CGFloat sHeight = self.frame.size.height;
    //结束圆的半径（屏幕的半径）
    
    CGFloat endRadius = sqrt(sWidth*sWidth + sHeight*sHeight);
    //使用缩进矩形创建结束圆的外接矩形 //第一个参数：原始矩形  第二个参数：X方向缩进的距离（+缩小  -放大） 第三个参数：Y方向缩进的距离
    CGRect endRect = CGRectInset(startRect, -(endRadius), -endRadius);
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    
    
    
    //3.设置形状图层的填充颜色  fillColor:填充圆  strokeColor:边框圆
    shapeLayer.fillColor = [UIColor darkGrayColor].CGColor;
    //[UIColor colorWithRed:100/255.f green:188/255.f blue:127/255.f alpha:1].CGColor;
    //4.设置绘制好的贝塞尔路径为形状图层的路径
    shapeLayer.path = startBezierPath.CGPath;
    
    //5.将shape添加到视图中,addSublayer是在当前的图层上添加一个layer形状区域
    [self.layer addSublayer:shapeLayer];
    
    //6.执行动画
    [self animationWithStartPath:startBezierPath EndPath:endPath ShapeLayer:shapeLayer];
    
    //7. 1s钟之后开始倒计时动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setupUI];
        [self timingAnimation];
    });
}


//创建控件时给最大状态
- (void)setupUI
{

    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.circleView.center = self.center;
    self.circleView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    self.circleView.layer.masksToBounds = YES;
    self.circleView.layer.cornerRadius = self.circleView.bounds.size.width*0.5;
    [self addSubview:self.circleView];
    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.label.center = self.center;
    self.label.font = [UIFont fontWithName:@"arial" size:100];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor whiteColor];
    [self addSubview:self.label];
    
}

#pragma mark -倒计时动画

- (void)timingAnimation
{
    static int i = 3;
    if (i == 0) {
        //倒计时动画完成
        
        //执行外部完成回调
        if (self.completionBlock) {
            self.completionBlock();
        
            i = 3;
            //移除自己
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [self removeFromSuperview];
            });
        }
        return;
    }
    
    self.label.text = [NSString stringWithFormat:@"%d",i];
    //1.文字和圆形视图一起方法
    //1.1 动画起始状态
    self.label.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.label.alpha = 0;
    self.circleView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    self.circleView.alpha = 0;
    
    [UIView animateWithDuration:0.6 animations:^{
        //1.2动画最终状态
        self.label.transform = CGAffineTransformMakeScale(1, 1);
        self.label.alpha = 1;
        self.circleView.transform = CGAffineTransformMakeScale(1, 1);
        self.circleView.alpha = 1;
    } completion:^(BOOL finished) {
        // 1.3 动画完成状态  （label缩小,圆形视图消失）
        self.circleView.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            self.label.transform = CGAffineTransformMakeScale(0.3, 0.3);
            self.label.alpha = 0.5;

        } completion:^(BOOL finished) {
            //最终结束   1。动画循环次数减1  2.递归
            i --;
            [self timingAnimation];
        }];
    }];
}


- (void)animationWithStartPath:(UIBezierPath *)startPath EndPath:(UIBezierPath *)endPath ShapeLayer:(CAShapeLayer *)shapeLayer
{
    //1.创建核心动画  参数：动画改变的值
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    
    //2.动画基础参数
    basicAnimation.duration = 0.6;
    //3.动画  开始值和结束值
    //如果是present，动画是由小圆到大圆  如果是dismiss，动画由大圆到小圆
        basicAnimation.fromValue = (__bridge id )(startPath.CGPath);
        basicAnimation.toValue = (__bridge id)(endPath.CGPath);
    //4.设置动画执行完毕不恢复  1.设置填充模式为向前填充  2.设置动画完成移除属性removedOnCompletion为NO
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    //4.执行动画   谁要执行动画就将动画添加到谁身上
    [shapeLayer addAnimation:basicAnimation forKey:nil];
}

- (void)dealloc
{
    NSLog(@"倒计时动画被移除");
}



@end
