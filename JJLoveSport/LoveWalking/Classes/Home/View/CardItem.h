//
//  CardItem.h
//  Card
//
//  Created by D on 17/1/4.
//  Copyright © 2017年 D. All rights reserved.


#import "CardViewItem.h"

@class CardData;
@interface CardItem : CardViewItem

/**
 *  <#名称#>
 */
@property(nonatomic,assign)NSInteger pageNum;
- (void)setItemWIthImageName:(NSString*)imageName;

@end
