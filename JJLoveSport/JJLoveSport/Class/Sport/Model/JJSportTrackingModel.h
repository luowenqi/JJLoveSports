//
//  JJSportTrackingModel.h
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    JJSportTypeRun,
    JJSJJSportWalk,
    JJSJJSportRiding,
} JJSportType;

@interface JJSportTrackingModel : NSObject


/**
 运动类型
 */
@property(nonatomic , assign) JJSportType sportType;


/**
 运动类型图片
 */
@property(nonatomic , strong) UIImage * sportTpyeImage;


-(instancetype)initWithSportType:(JJSportType)sportType;

@end
