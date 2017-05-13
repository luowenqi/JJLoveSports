//
//  JJSportMaskView.h
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/12.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JJSportMaskViewDelegate <NSObject>


/**
 展开地图
 */
-(void)showMap;


/**
改变运动状态
 */
-(void)changeSportState:(UIButton*)sender;


@end


@interface JJSportMaskView : UIView


@property(nonatomic , weak) id<JJSportMaskViewDelegate>  delegate;

@end
