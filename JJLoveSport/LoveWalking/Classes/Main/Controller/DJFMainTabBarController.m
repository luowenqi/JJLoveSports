//
//  DJFMainTabBarController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFMainTabBarController.h"
#import "DJFBaseNavigationController.h"
@interface DJFMainTabBarController ()

@end

@implementation DJFMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    [self makeTabChildControllers];
    
}

/**
 创建标签控制器上的控制器
 */
-(void)makeTabChildControllers{
    //食谱
    [self addChildViewController:@"DJFFoodViewController" andTitle:@"食谱" andImage:@"ic_tab_circle"];
    //资讯
    [self addChildViewController:@"DJFNewsViewController" andTitle:@"资讯" andImage:@"ic_tab_discovered"];
    //运动
//    [self addChildViewController:@"DJFHomeViewController" andTitle:@"运动" andImage:@"ic_tab_sports"];
    [self addChildStroryBoard:@"Home" andIdentifier:@"DJFHomeViewController" andTitle:@"运动" andImage:@"ic_tab_sports"];
    //[self addChildViewController:@"DJFMapViewController" andTitle:@"地图" andImage:@"ic_tab_sports"];
    //分析
    [self addChildViewController:@"DJFAnalyseViewController" andTitle:@"分析" andImage:@"ic_tab_mine"];
    //设置
    [self addChildViewController:@"DJFSettingViewController" andTitle:@"设置" andImage:@"ic_tab_message"];
    
    //跳转到指定的页面
    self.selectedIndex = 2;
}
/**
 将控制器增加到标签控制器上
 
 @param controllerName 控制器名
 @param title 控制器标题
 @param imageName 图标名
 */
-(void)addChildViewController:(NSString*)controllerName andTitle:(NSString*)title andImage:(NSString*)imageName{
    //根据类名获取控制器名
    Class cls = NSClassFromString(controllerName);
    //创建控制器
    UIViewController* vc = [cls new];
    
    //设置按钮图标正常状态和选中状态
    vc.tabBarItem.image = [[UIImage imageNamed:[imageName stringByAppendingString:@"_normal_22x22_"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[imageName stringByAppendingString:@"_selected_22x22_"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置导航控制器和标签控制器标题
    vc.title = title;
    
    //创建导航控制器
    DJFBaseNavigationController* nav = [[DJFBaseNavigationController alloc]initWithRootViewController:vc];
    
    //将控制器增加到标签控制器上
    [self addChildViewController:nav];
    
}

/**
 将控制器增加到标签控制器上
 
 @param storyBoardName 故事版名
 @param identifier 控制器名
 @param title 控制器标题
 @param imageName 图标名
 */
-(void)addChildStroryBoard:(NSString*)storyBoardName  andIdentifier:(NSString*)identifier andTitle:(NSString*)title andImage:(NSString*)imageName{
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    
    UIViewController* vc = [storyBoard instantiateViewControllerWithIdentifier:identifier];
    
    //设置按钮图标正常状态和选中状态
    vc.tabBarItem.image = [[UIImage imageNamed:[imageName stringByAppendingString:@"_normal_22x22_"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[imageName stringByAppendingString:@"_selected_22x22_"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置导航控制器和标签控制器标题
    vc.title = title;
    
    //创建导航控制器
    DJFBaseNavigationController* nav = [[DJFBaseNavigationController alloc]initWithRootViewController:vc];
    
    //将控制器增加到标签控制器上
    [self addChildViewController:nav];
    
}@end
