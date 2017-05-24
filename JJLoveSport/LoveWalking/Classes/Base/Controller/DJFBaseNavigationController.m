//
//  DJFBaseNavigationController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFBaseNavigationController.h"

@interface DJFBaseNavigationController ()

@end

@implementation DJFBaseNavigationController

+(void)initialize{
    
    //关闭透明效果
    [[UINavigationBar appearance]setTranslucent:NO];
    //设置导航条背景颜色
    [UINavigationBar appearance].barTintColor =THEME_COLOR;
    //[UIColor greenColor];
    //THEME_COLOR;
    [UINavigationBar appearance].tintColor = [UIColor blackColor];
    
    //MARK: 设置导航条标题字体颜色
    UIBarButtonItem* item = [UIBarButtonItem appearance];
    //设置颜色
    item.tintColor = [UIColor yellowColor];
    
    //字体样式
    NSDictionary* attDict = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18 weight:10]};
    //设置按钮正常状态下样式
    [item setTitleTextAttributes:attDict forState:UIControlStateNormal];
    //设置标题正常状态下样式
    [[UINavigationBar appearance]setTitleTextAttributes:attDict];
    
    //MARK: 清除毛玻璃效果
    [[UINavigationBar appearance]setShadowImage:[UIImage new]];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
}

@end
