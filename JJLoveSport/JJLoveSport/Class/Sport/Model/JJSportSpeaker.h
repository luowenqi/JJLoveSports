//
//  JJSportSpeaker.h
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/18.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJSportSpeaker : NSObject

/**
 运动播报距离单位
*/
@property(nonatomic , assign) int  distanceUnit;


/**
 运动类型
 */
@property(nonatomic , assign) JJSportType  sportType;



/**
指定初始化方法
 */
-(instancetype)initWithSportType:(JJSportType)sportType andDistanceUnit:(int)distanceUnit;

/**
 播报运动开始
 */
-(void)speakSportStart;


/**
播报运动状态
 */
-(void)speakSportState:(JJSportState)sportState;


/**
播报运动综合信息
 */
-(void)speakSportCompositeDataDistance:(CGFloat)distance time:(int)time speed:(CGFloat)speed;



@end
