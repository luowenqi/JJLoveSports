//
//  DJFCircleAnimationView.h
//  LoveWalking
//
//  Created by 陈逸麒 on 2017/5/15.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJFCircleAnimationView : UIView

/**
 圆心参考坐标
 */
@property(nonatomic,assign)CGPoint circlCenter;

/**
 内切圆外正方形
 */
@property(nonatomic,assign)CGRect circleBounds;

@end
