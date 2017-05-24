//
//  DJFHomeViewController.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJFSportTimingView : UIView


/**
 创建倒计时动画视图

 @param sourceView 来源视图（以哪一个视图作为中心点开始放大）
 @param completion 倒计时完成回调
 @return 倒计时视图
 */
- (instancetype)initWithSourceView:(UIView *)sourceView Completion:(void(^)(void))completion;

@end
