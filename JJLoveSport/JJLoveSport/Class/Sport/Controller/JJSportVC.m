//
//  JJSportVC.m
//  JJSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportVC.h"
#import "JJSportSupportVC.h"

#define BASETAG 50
#define MarginTop 20
#define MarginLeft 20



@interface JJSportVC ()

/**
 运动类型按钮
 */
@property(nonatomic , strong) UIButton* choiceSportTypButton;


/**
 开始运动
 */
@property(nonatomic , strong) UIButton* startButton;

/**
 运动按钮数组
 */
@property(nonatomic , strong) NSMutableArray<UIButton*> * sportTypes;


/**
 遮罩视图
 */
@property(nonatomic , strong) UIView * maskView;




/**
 当前运动类型
 */
@property(nonatomic , assign) JJSportType  currentSportType;


@end

@implementation JJSportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
}

#pragma mark - 创建遮罩视图
-(void)crearMaskView{
    
    self.maskView  = [[UIView alloc]initWithFrame:self.view.bounds];
    _maskView.backgroundColor = [UIColor clearColor];
    self.maskView.alpha = 0.4;
    
    UIBlurEffect *blureffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blureffect];
    effectView.frame = self.view.bounds;
    [_maskView addSubview:effectView];
}

#pragma mark - 创建界面
-(void)setupUI{
    

    
    self.sportTypes = [NSMutableArray array];

    //创建开始按钮
    [self creatStartButton];
    
    //创建三种运动模式的开关
    [self creatSportModelButton];
    
    //创建遮罩视图
    [self crearMaskView];
    
    
}


#pragma mark - 创建开始运动按钮
-(void)creatStartButton{

    

    _startButton = [[UIButton alloc]initWithTitle:@"开始" titleColor:[UIColor whiteColor] image:nil HightImageName:nil addTarget:self action:@selector(startSport:) forControlEvents:UIControlEventTouchUpInside];

     [_startButton setBackgroundImage:[UIImage imageNamed:@"btn_start_normal_118x118_"] forState:UIControlStateNormal];
     [_startButton setBackgroundImage:[UIImage imageNamed:@"btn_start_normal_118x118_"] forState:UIControlStateHighlighted];
    
    _startButton.titleLabel.font = [UIFont systemFontOfSize:24];
   
    [self.view addSubview:_startButton];

    [_startButton sizeToFit];
    [_startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make centerX];
        make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(-50);
    }];
    
}


#pragma mark - 开始运动
-(void)startSport:(UIButton* )sender{
    

    JJSportSupportVC* sportSupportVC = [[JJSportSupportVC alloc]init];
    
    sportSupportVC.sportType = self.currentSportType;
  
    
    [self presentViewController:sportSupportVC animated:YES completion:nil];

}










#pragma mark - 创建运动模块按钮
-(void)creatSportModelButton{

    for (NSInteger i = 0; i< (KGlobalSportTypeImageNames.count + 1 ); i++) {
        UIButton* button = [[UIButton alloc]init];
        if (i == KGlobalSportTypeImageNames.count) {
            button = [[UIButton alloc]initWithTitle:nil titleColor:nil image:KGlobalSportTypeImageNames[0] HightImageName:KGlobalSportTypeImageNames[0] addTarget:self action:@selector(choiceSportType) forControlEvents:UIControlEventTouchUpInside];
        }else{
        
             button = [[UIButton alloc]initWithTitle:nil titleColor:nil image:KGlobalSportTypeImageNames[i] HightImageName:KGlobalSportTypeImageNames[i] addTarget:self action:@selector(chageSportType:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        [_sportTypes addObject:button];
        [self.view addSubview:button];
        button.tag = i + BASETAG ;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(MarginTop);
            make.left.equalTo(self.view).offset(MarginLeft);
        }];
    }
    
    
    _choiceSportTypButton = _sportTypes.lastObject;

    [_choiceSportTypButton setImage:[UIImage imageNamed:@"ic_sport_type_close_44x44_"] forState:UIControlStateSelected];
    
    [_sportTypes removeLastObject];
  
}


#pragma mark - 选择运动种类
-(void)choiceSportType{
    
    _choiceSportTypButton.selected = !_choiceSportTypButton.selected;
    
    UIButton* btn = [[UIButton alloc] init];
    
    if (self.choiceSportTypButton.selected) {
        
        [self.view insertSubview:self.maskView belowSubview:_sportTypes[0]];
        
        for (NSInteger i = 0; i< self.sportTypes.count; i++) {
            btn = self.sportTypes[i];
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:40 initialSpringVelocity:30 options:0 animations:^{
                
                _choiceSportTypButton.transform = CGAffineTransformRotate(btn.transform, M_PI_4);

                [btn mas_updateConstraints:^(MASConstraintMaker *make) {
        
                    make.top.equalTo(self.view).offset((_choiceSportTypButton.bounds.size.width +MarginTop) * (i+1) + MarginTop);
    
                }];
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
    
    if (!self.choiceSportTypButton.selected) {
        for (NSInteger i = 0; i< self.sportTypes.count; i++) {
            btn = self.sportTypes[i];
            
            [UIView animateWithDuration:0.5 animations:^{
                
                _choiceSportTypButton.transform = CGAffineTransformRotate(btn.transform, -M_PI_4);
               
                [btn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view).offset(MarginTop);

                }];
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self.maskView removeFromSuperview];
            }];
        }
    }
}


#pragma mark - 更换运动类型
-(void)chageSportType:(UIButton*)sender{
    
    [self.choiceSportTypButton setImage:[UIImage imageNamed:KGlobalSportTypeImageNames[sender.tag - BASETAG]] forState:UIControlStateNormal];
    
    [self choiceSportType];
    
    _currentSportType = sender.tag - BASETAG;

}





#pragma mark - 隐藏运动模块的navigationBar,设置全局色彩
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = KGlobalGreen;
}





@end
