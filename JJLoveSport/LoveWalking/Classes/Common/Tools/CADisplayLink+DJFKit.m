//
//  CADisplayLink+DJFKit.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/18.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "CADisplayLink+DJFKit.h"

@implementation CADisplayLink (DJFKit)
- (void)setExecuteBlock:(QSExecuteDisplayLinkBlock)executeBlock{
    
    objc_setAssociatedObject(self, @selector(executeBlock), [executeBlock copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (QSExecuteDisplayLinkBlock)executeBlock{
    
    return objc_getAssociatedObject(self, @selector(executeBlock));
}

+ (CADisplayLink *)displayLinkWithExecuteBlock:(QSExecuteDisplayLinkBlock)block{
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(qs_executeDisplayLink:)];
    displayLink.executeBlock = [block copy];
    return displayLink;
}

+ (void)qs_executeDisplayLink:(CADisplayLink *)displayLink{
    
    if (displayLink.executeBlock) {
        displayLink.executeBlock(displayLink);
    }
}
@end
