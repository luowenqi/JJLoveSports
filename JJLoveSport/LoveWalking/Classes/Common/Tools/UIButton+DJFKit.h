//
//  UIButton+DJFKit.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/4.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (DJFKit)
/// 创建文本按钮
///
/// @param title         文本
/// @param fontSize      字体大小
/// @param normalColor   默认颜色
/// @param selectedColor 选中颜色
///
/// @return UIButton
+ (instancetype)textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

@end
