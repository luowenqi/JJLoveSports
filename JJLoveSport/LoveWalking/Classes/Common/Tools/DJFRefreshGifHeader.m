//
//  DJFRefreshGifHeader.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/18.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFRefreshGifHeader.h"
#import "UIImage+DJFKit.h"
@implementation DJFRefreshGifHeader

- (void)prepare{
    [super prepare];
    
    NSMutableArray* lodingImages = [NSMutableArray arrayWithCapacity:9];
    for (NSInteger i = 0 ; i < 9; i++) {
        NSString *imageName = [NSString stringWithFormat:@"PullToRefreshLoading%zd_32x32_", i];
        UIImage *image = [UIImage imageNamed:imageName];
      UIImage *newImage = [image imageByScalingToSize:CGSizeMake(32, 32)];
        [lodingImages addObject:newImage];
    }
    /** 普通闲置状态 */
    //MJRefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
   // MJRefreshStatePulling,
    /** 正在刷新中的状态 */
   // MJRefreshStateRefreshing,
    /** 即将刷新的状态 */
    //MJRefreshStateWillRefresh,
    //松开就可以进行刷新的状态
    [self setImages:lodingImages forState:MJRefreshStatePulling];
    //正在刷新中的状态
    [self setImages:lodingImages forState:MJRefreshStateRefreshing];
}

@end
