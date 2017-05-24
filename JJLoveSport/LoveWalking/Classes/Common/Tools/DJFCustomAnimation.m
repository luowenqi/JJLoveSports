//
//  DJFCustomAnimation.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/2.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFCustomAnimation.h"

@interface DJFCustomAnimation ()<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

//是否展现
@property(nonatomic,assign)BOOL isPresent;

//用weak防止循环引用
@property(nonatomic,weak)id <UIViewControllerContextTransitioning> transitionContext;
@end

@implementation DJFCustomAnimation

#pragma mark - UIViewControllerTransitioningDelegate:
//转场动画执行对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _isPresent = YES;
    
    return self;
}
//转场动画解除对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    _isPresent = NO;
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning 转场动画实现
//动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.8;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //1.获取上下文的容器视图
    UIView *containerView = transitionContext.containerView;
    //2.获取目标视图
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    //获取龙猫控制器视图  如果是present则是toView   如果是diss则是fromeView
    UIView *desView = self.isPresent?toView:fromView;
    //3.将目标视图添加到容器视图
    [containerView addSubview:desView];
    
    //4.开始动画
    [self animationWithView:desView];
    
    //5.一定要告诉上下文完成转场,否则上下文将会一直等待系统告知转场是否完成,会让我们的控制器失去一切(被上下文拦截)
    //    [transitionContext completeTransition:YES];
    //赋值转场上下文(转场上下文完成转场需要在动画完成之后告知)
    self.transitionContext = transitionContext;
}

- (void)animationWithView:(UIView *)view
{
    //1.创建CAShapeLayer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    //2.创建贝塞尔路径(参数矩形是圆形的外接矩形)
    //间距
    CGFloat margin = 20;
    //圆的半径
    CGFloat radius = 25;
    //屏幕尺寸
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewHeight = [UIScreen mainScreen].bounds.size.height;
    
    //屏幕对角线的距离
    CGFloat endRadius = sqrt((viewWidth * viewWidth + viewHeight*viewHeight));
    
    
    //起始点圆路径
    CGRect startRect = CGRectMake(viewWidth - 20 - radius*2, margin, radius*2, radius *2);
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:startRect];
    
    //结束圆路径
    //使用缩进矩形范围创建结束圆的外接矩形(以原始矩形,中心不点按照按钮进行缩放) 第一个参数:原始矩形 第二个参数:x轴缩放量(+缩小  -放大) 第三个参数:y轴缩放量(+缩小  -放大)
    CGRect endRect = CGRectInset(startRect, -endRadius, -endRadius);
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    //3.设置layer的属性
    
    //填充颜色
    layer.fillColor = [UIColor redColor].CGColor;
    
    //4.将贝塞尔路径作为layer的路径
    layer.path = startPath.CGPath;
    //将shapelayer作为父视图layer的遮罩图层(1.会裁切图层,只保留shapelayer形状的可见区域  2.使用遮罩图层的话,layer的设置颜色失效  3.如果将shaprelayer作为父视图图层的遮罩图层,则不需要在将layer添加到父视图图层中)
    view.layer.mask = layer;
    
    
    //使用核心动画实现layer层的动画 参数:动画作用属性的keypath
    
    //1.创建核心动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    
    //2.设置动画时间
    basicAnimation.duration = [self transitionDuration:self.transitionContext];
    
    //3.设置动画的起始值和结束值
    
    if (self.isPresent)//展现小圆变大圆
    {
        basicAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
        basicAnimation.toValue = (__bridge id _Nullable)endPath.CGPath;
    }
    else//解除大圆变小圆
    {
        basicAnimation.fromValue = (__bridge id _Nullable)(endPath.CGPath);
        basicAnimation.toValue = (__bridge id _Nullable)startPath.CGPath;
    }
    
    basicAnimation.delegate = self;
    
    
    //4.设置动画属性
    //设置动画填充模式(如果不设置填充模式为向前填充,只设置removedOnCompletion无法做到动画完成不还原的效果)
    basicAnimation.fillMode = kCAFillModeForwards;
    //设置动画完成之后不移除
    basicAnimation.removedOnCompletion = NO;
    
    //5.添加到动画到图层(动画在哪一个图层执行,就添加到哪一个图层)
    [layer addAnimation:basicAnimation forKey:nil];
}

#pragma mark -CAAnimationDelegate:负责转场动画的开始和结束监听

//动画(动画结束之后才告知转场上下文完成转场)
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //完成转场
    [self.transitionContext completeTransition:YES];
}
@end
