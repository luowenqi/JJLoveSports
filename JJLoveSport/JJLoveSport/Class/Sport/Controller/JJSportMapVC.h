//
//  JJSportMapVC.h
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJSportTrackingModel.h"
@class JJSportMapVC;

@protocol JJSportMapVCDelegate <NSObject>

-(void)updateSportDate:(JJSportTrackingModel*)sportTrackingModel mapVC:(JJSportMapVC*)mapVC;

@end



@interface JJSportMapVC : UIViewController


@property(nonatomic , weak) id<JJSportMapVCDelegate> delegate;


/**
 运动跟踪模型
 */
@property(nonatomic , strong) JJSportTrackingModel* trackingModel;

@end
