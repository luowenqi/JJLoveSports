//
//  UILabel+DJFKit.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/6.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DJFKit)
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
+ (void)changeLineSpaceForLabel:(UILabel*)label withSpace:(float)space;

+ (instancetype)createLabelWith:(NSString*)title fontSize:(CGFloat)fontSize numberOfLine:(NSInteger)numberOfLine color:(UIColor*)color;
@end
