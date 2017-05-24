//
//  DJFCircleAnimationView.m
//  LoveWalking
//
//  Created by 陈逸麒 on 2017/5/15.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFCircleAnimationView.h"

@implementation DJFCircleAnimationView


-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 0.6);
    
    CGContextSetLineWidth(context, 1);
    
    
    
    CGContextAddArc(context, _circlCenter.x, _circlCenter.y, _circleBounds.size.height * 0.5, 0, M_PI * 2, 0);
    
    CGContextDrawPath(context, kCGPathStroke);
    
}


@end
