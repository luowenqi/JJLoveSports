//
//  DJFCategoryView.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/4.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJFBaseControl.h"
@interface DJFCategoryView : DJFBaseControl


/**
 *  当前索引
 */
@property(nonatomic,assign)NSInteger currentIndex;

/**
 * 返回选中按钮tag
 */
-(NSInteger)getSelectBtnTag;
/**
 *  频道列表
 */
@property(nonatomic,strong)NSArray *catagoryList;
@end
