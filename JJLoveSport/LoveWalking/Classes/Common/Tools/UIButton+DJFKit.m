//
//  UIButton+DJFKit.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/4.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "UIButton+DJFKit.h"

@implementation UIButton (DJFKit)
+ (instancetype)textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    
    UIButton *button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [button sizeToFit];
    
    return button;
}

@end
