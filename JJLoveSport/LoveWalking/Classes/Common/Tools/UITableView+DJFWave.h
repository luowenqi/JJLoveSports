//
//  UITableView+DJFWave.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/16.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kBOUNCE_DISTANCE  2

typedef NS_ENUM(NSInteger,WaveAnimation) {
    LeftToRightWaveAnimation = -1,
    RightToLeftWaveAnimation = 1
};
@interface UITableView (DJFWave)
- (void)reloadDataAnimateWithWave:(WaveAnimation)animation;
@end
