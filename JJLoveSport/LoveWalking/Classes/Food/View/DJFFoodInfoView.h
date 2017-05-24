//
//  DJFFoodInfoView.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/6.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJFFoodInfoModel.h"
@interface DJFFoodInfoView : UITableViewCell
/**
 *  高度变化回调
 */
@property(nonatomic,copy)void(^changeHeigh)();
/**
 *  <#名称#>
 */
@property(nonatomic,strong)DJFFoodInfoModel * infoModel;

@end
