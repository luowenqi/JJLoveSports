//
//  JJCircleTransition.h
//  自定义转场动画(luowenqi)
//
//  Created by 罗文琦 on 2017/5/15.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JJCircleTransition : NSObject<UIViewControllerTransitioningDelegate>


/**
 转场持续时间
 */
@property(nonatomic , assign) CGFloat duration;


/**
 圆心位置
 */
@property(nonatomic , assign) CGPoint ArcCenter;


/**
 圆角半径
 */
@property(nonatomic , assign) CGFloat cornerRadius;



/**
指定初始化方法
 */
-(instancetype)initWithArcCenter:(CGPoint)ArcCenter cornerRadius:(CGFloat)cornerRadius;


/**
指定类方法
 */
+(instancetype)circleTransitionWithArcCenter:(CGPoint)ArcCenter cornerRadius:(CGFloat)cornerRadius;


@end
