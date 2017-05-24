//
//  CADisplayLink+DJFKit.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/18.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class CADisplayLink;

typedef void(^QSExecuteDisplayLinkBlock) (CADisplayLink *displayLink);
@interface CADisplayLink (DJFKit)
@property (nonatomic,copy)QSExecuteDisplayLinkBlock executeBlock;

+ (CADisplayLink *)displayLinkWithExecuteBlock:(QSExecuteDisplayLinkBlock)block;

@end
