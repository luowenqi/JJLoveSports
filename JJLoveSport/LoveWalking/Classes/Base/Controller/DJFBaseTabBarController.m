//
//  DJFBaseTabBarController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFBaseTabBarController.h"

@interface DJFBaseTabBarController ()

@end

@implementation DJFBaseTabBarController
+(void)initialize{
    //MARK: 设置主题及关闭透明效果
    //关闭半透明效果
    [[UITabBar appearance]setTranslucent:NO];
    //设置主题颜色
    [UITabBar appearance].barTintColor = [UIColor lightGrayColor];
    //THEME_COLOR;
    
    //MARK: 按钮文本设置
    //设置按钮文本颜色
    UITabBarItem* item = [UITabBarItem appearance];
    //正常状态
    NSDictionary* normalStatus = @{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    //选中状态
    NSDictionary* selectedStatus  = @{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName:KRGBA(236, 176, 17, 1)};
    //设置正常状态
    [item setTitleTextAttributes:normalStatus forState:UIControlStateNormal];
    //设置选中状态
    [item setTitleTextAttributes:selectedStatus forState:UIControlStateSelected];
}

@end
