//
//  DJFMapTypeViewController.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/2.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

typedef enum : NSUInteger {
    DJFMapTypeFlat = 1,
    DJFMapTypeReal, 
    DJFMapTypeMix,
} DJFMapType;
#import "DJFBaseViewController.h"

@interface DJFMapTypeViewController : DJFBaseViewController
/**
 *  所选择的地图类型
 */
@property(nonatomic,copy)void(^mapType)(DJFMapType mapType);
@end
