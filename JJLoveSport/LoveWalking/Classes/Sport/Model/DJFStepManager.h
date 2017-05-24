//
//  DJFStepManager.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/1.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJFStepManager : NSObject
@property (nonatomic) NSInteger step;                       // 运动步数（总计）
/**
 *  是否暂停计步
 */
@property(nonatomic,assign,getter=isPasue) BOOL pause;
+ (instancetype)sharedManager;

//开始计步
- (void)startWithStep;


////得到所走的路程(单位:米)
- (CGFloat)getStepDistance;

- (void)restStep;
- (void)tearDown;
@end
