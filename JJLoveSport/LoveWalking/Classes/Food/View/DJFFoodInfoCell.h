//
//  DJFFoodInfoCell.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/15.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJFFoodInfoCell : UITableViewCell
/**
 *  <#名称#>
 */
@property(nonatomic,strong)NSString *fId;
/**
 *  高度变化回调
 */
@property(nonatomic,copy)void(^changeHeigh)();

@end
