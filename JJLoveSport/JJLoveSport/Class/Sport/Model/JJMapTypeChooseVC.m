//
//  JJMapTypeChooseVC.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/16.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJMapTypeChooseVC.h"
#define Margin 15
@interface JJMapTypeChooseVC ()

@property(nonatomic , strong) UIButton * selectMapType;

@end

@implementation JJMapTypeChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


-(void)setupUI{
    
    //平面地图按钮
    NSArray* mapTpyeButtonNormalImage = @[@"ic_sport_gps_map_flatmode",@"ic_sport_gps_map_mixmode",@"ic_sport_gps_map_realmode"];
    NSArray* mapTpyeButtonSelectedImage = @[@"ic_sport_gps_map_flatmode_selected",@"ic_sport_gps_map_mixmode_selected",@"ic_sport_gps_map_realmode_selected"];
    
   
    for (NSInteger i = 0; i< mapTpyeButtonNormalImage.count; i++) {
        UIButton* button = [[UIButton alloc]init];
         button  = [[UIButton alloc]initWithTitle:nil titleColor:nil image:mapTpyeButtonNormalImage[i] HightImageName:nil addTarget:self action:@selector(changeMapViewType:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:mapTpyeButtonSelectedImage[i]]   forState:UIControlStateSelected];
        
        [self.view addSubview:button];
        [button sizeToFit];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset( (button.bounds.size.width + Margin)*i + Margin);
            make.centerY.equalTo(self.view);
        }];
        button.tag = i;
        
        if (i == 0) {
            self.selectMapType = button;
            self.selectMapType.selected = YES;
        }
        
    }
//    self.selectMapType = (UIButton*) [self.view viewWithTag:0];

    

}


#pragma mark - 更改地图类型
-(void)changeMapViewType:(UIButton*)sender{
    

    if (self.selectMapType == sender) {
        return;
    }
    
    self.selectMapType.selected = NO;
    self.selectMapType = sender;
    self.selectMapType.selected = YES;
    [self.deleagte changeMapeType:sender];

}

@end
