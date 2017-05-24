//
//  DJFSetpModel.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/1.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJFSetpModel : NSObject
@property(nonatomic,strong) NSDate *date;

@property(nonatomic,assign) int record_no;

@property(nonatomic, strong) NSString *record_time;

@property(nonatomic,assign) int step;

//g是一个震动幅度的系数,通过一定的判断条件来判断是否计做一步
@property(nonatomic,assign) double g;

@end
