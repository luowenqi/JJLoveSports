//
//  JJCircleTransition.m
//  自定义转场动画(luowenqi)
//
//  Created by 罗文琦 on 2017/5/15.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJCircleTransition.h"


@interface JJCircleTransition ()<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property(nonatomic , weak) id <UIViewControllerContextTransitioning> transitionContext;


/**
 是不是推出
 */
@property(nonatomic , assign) BOOL  ispresent;

@end

@implementation JJCircleTransition



+(instancetype)circleTransitionWithArcCenter:(CGPoint)ArcCenter cornerRadius:(CGFloat)cornerRadius{
    return [[self alloc]initWithArcCenter:ArcCenter cornerRadius:cornerRadius];
}


-(instancetype)initWithArcCenter:(CGPoint)ArcCenter cornerRadius:(CGFloat)cornerRadius{
    if (self = [super init]) {
        self.ArcCenter = ArcCenter;
        self.cornerRadius = cornerRadius;
    }
    return self;
}




#pragma mark - UIViewControllerTransitioningDelegate 在这里找到第二个协议
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    self.ispresent = YES;
    //模态来源控制器,当模态控制器被推出的时候动画发生在谁身上
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //模态消失控制器,当模态消失的时候动画发生在谁身上
    self.ispresent = NO;
    return self;
}


#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 1; //动画持续时间,但是这里设置是没有用的
}

#pragma mark - 真正发生动画,设置动画的地方
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    //1.通过上下文中的容器视图
    UIView* containerView = transitionContext.containerView;
    //2.通过容器视图获取到模态来源视图,结束视图
    UIView* formView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView* toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    //把目标视图加到containerView中
    UIView* view = self.ispresent?toView:formView;
    [containerView addSubview:view];
    self.transitionContext = transitionContext;
    [self layerAnimationWithView:view];
    //开始动画
    //记得在动画结束之后告诉系统动画已经结束,不然会让系统一直等待动画结束,从而导致无法响应其他事件
}

#pragma mark - CAAnimationDelegate  动画结束之后调用
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:YES];
}






-(void)layerAnimationWithView:(UIView*)view{
    CGFloat kScreenWidthNow = [UIScreen mainScreen].bounds.size.width;
    CGFloat kScreenHightNow = [UIScreen mainScreen].bounds.size.height;
    //使用layer层的核心动画
    CALayer* layer = [CALayer layer];
    layer.position = self.ArcCenter;
    layer.bounds = CGRectMake(0, 0, self.cornerRadius * 2, self.cornerRadius * 2);
    layer.cornerRadius = self.cornerRadius;
    layer.masksToBounds = YES;
    view.layer.mask = layer;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    //下面是动画
    CGFloat screenInc  =  (CGFloat)sqrt(kScreenHightNow*kScreenHightNow + kScreenWidthNow*kScreenWidthNow);
    CABasicAnimation* animation =[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    if (self.ispresent) {
        animation.fromValue = @1;
        animation.toValue = @(screenInc / self.cornerRadius)
        ;
    }else{
        animation.fromValue =  @(screenInc / self.cornerRadius) ;
        animation.toValue = @1;
    }

    
    if (self.duration >= 0.001) {
        animation.duration = self.duration;
    }
    animation.delegate = self;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [layer addAnimation:animation forKey:@"1"];
}

-(void)setDuration:(CGFloat)duration{
    _duration = duration;
}


-(void)test{
    //    //1.实例化图层  可以使用CAShapeLayer,也可以使用最简单的CALayer
    //    CAShapeLayer *layer = [CAShapeLayer layer];
    //
    //    //2.设置图层属性
    //
    //    //使用贝塞尔曲线绘制圆形路径
    //
    //    //直径
    //    CGFloat radius = 40;
    //
    //
    //    CGFloat topMargin = 25;
    //    CGFloat rightMargin = 15;
    //
    //    CGFloat viewWidth = view.bounds.size.width;
    //    CGFloat viewHeight = view.bounds.size.height;
    //
    //    //动画起始路径
    //
    //    CGRect rect = CGRectMake(viewWidth - radius - rightMargin, topMargin, radius, radius);
    //    //
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    //
    //    //动画结束路径
    //
    //
    //    //计算屏幕对角线
    //    CGFloat endRadius = sqrt(viewWidth*viewWidth + viewHeight*viewHeight);
    //
    //    //使用缩进   --第一个参数：原始大小  第二个参数：X轴缩进（-放大  +缩小）
    //    CGRect endRect = CGRectInset(rect, -endRadius, -endRadius);
    //
    //    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    //
    //    layer.path = path.CGPath;
    //
    //    //3.将图层添加到View的图层-（不会裁切视图，在视图的图层上显示路径的内容）
    //    //    [self.view.layer addSublayer:layer];
    //
    //    //4.设置图层的遮罩-(会裁切视图，只显示路径包含范围内的内容，视图本质上没有发生任何的变化)
    //    //一旦设置了mask遮罩，填充颜色就会失效
    //    view.layer.mask = layer;
    //
    //
    //    //（1）实例化动画对象
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    //    //(2)设置动画属性
    //    //时长
    //    animation.duration = [self transitionDuration:self.transitionContext];
    //
    //    //判断是展现还是解除
    //    if(self.ispresent)
    //    {
    //        //formValue
    //        animation.fromValue = (__bridge id _Nullable)(path.CGPath);
    //        //toValue
    //        animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    //    }
    //    else
    //    {
    //        //formValue
    //        animation.fromValue = (__bridge id _Nullable)(endPath.CGPath);
    //        //toValue
    //        animation.toValue = (__bridge id _Nullable)(path.CGPath);
    //    }
    //
    //
    //    //设置向前填充模式
    //    animation.fillMode = kCAFillModeForwards;
    //    //完成之后不删除
    //    animation.removedOnCompletion = NO;
    //
    //    //设置动画代理  必须要写在添加动画到图层的前面，否则代理不会调用（一旦将动画添加到图层，动画已经开启，在设置代理已经来不及了）
    //    animation.delegate = self;
    //
    //    //(3)将动画添加到图层  -shapheLayer,让哪个图层执行动画就应该将动画添加到哪个图层
    //    [layer addAnimation:animation forKey:nil];
    
    
}






@end
