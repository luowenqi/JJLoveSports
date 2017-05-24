//
//  DJFHomeViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFHomeViewController.h"
#import "DJFSportTrackingModel.h"
#import "DJFSportingViewController.h"
#import  "CardView.h"
#import "CardItem.h"
#import "DJFCircleAnimationView.h"
#import "DJFSportTimingView.h"
@interface DJFHomeViewController ()<CardViewDelegate, CardViewDataSource>
@property (weak, nonatomic) IBOutlet CardView *cardView;



@property (strong, nonatomic) NSMutableArray<NSString *> * model1;
/**
 遮罩View
 */
@property (weak, nonatomic) IBOutlet UIView *shadeView;

@end
static NSString * ITEM_XIB    = @"CardItem";
static NSString * ITEM_RUID   = @"Item_RUID";
@implementation DJFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    self.cardView.delegate   = self;
    self.cardView.dataSource = self;
    self.cardView.maxItems   = 3;
    self.cardView.scaleRatio = 0.05;
    self.cardView.mode = CardViewItemScrollModeRemove;
    
    [self.view layoutIfNeeded];
    
    [self.cardView registerXibFile:ITEM_XIB forItemReuseIdentifier:ITEM_RUID];
    [self.cardView reloadData];

//    [self setBootomViewCornerRadius];
    
}




- (void)initData
{

    
    NSArray * imageNames = @[ @"1", @"2", @"3"];
    
    
    
    self.model1 = [NSMutableArray array];
    
    for (NSInteger i = 0; i < imageNames.count; i++) {
        
        [self.model1 addObject:imageNames[i]];
    }
    
}
- (NSInteger)numberOfItemsInCardView:(CardView *)cardView
{

    return [self.model1 count];
}

- (CardViewItem *)cardView:(CardView *)cardView itemAtIndex:(NSInteger)index
{
    
    CardItem * item = (CardItem *)[cardView dequeueReusableCellWithIdentifier:ITEM_RUID];
    item.pageNum = index;
    [item setItemWIthImageName:self.model1[index]];
    
    return item;
}

-(void)setupUI{
    
    
    
    [self setBackGroundLayer];
    
    
    if (_shadeView.layer.cornerRadius == 0) {
        
        [self setBootomViewCornerRadius];
    }
    
    [self beginCirclleAnimation];

    
}

-(void)beginCirclleAnimation{
    
    DJFCircleAnimationView * view1 = [[DJFCircleAnimationView alloc ]initWithFrame:self.view.bounds];
    
    //设置圆心坐标偏移点
    view1.circlCenter = CGPointMake(_shadeView.center.x - 10, _shadeView.center.y -3);
    //设置外接矩形
    view1.circleBounds = _shadeView.frame;
    
    [self.view insertSubview:view1 atIndex:0];
    //设置背景颜色为透明，否则会遮挡其他视图
    view1.backgroundColor = [UIColor clearColor];
    
    
    //左侧圆圈
    DJFCircleAnimationView *view2 = [[DJFCircleAnimationView alloc] initWithFrame:self.view.bounds];
    //x右移 y不移动
    view2.circlCenter = CGPointMake(_shadeView.center.x + 10, _shadeView.center.y);
    view2.circleBounds = _shadeView.frame;
    
    [self.view insertSubview:view2 atIndex:0];
    //设置背景颜色为透明，否则会遮挡其他视图
    view2.backgroundColor = [UIColor clearColor];
    
}


-(void)setBootomViewCornerRadius{
    
    _shadeView.layer.masksToBounds = YES;
    _shadeView.layer.cornerRadius = _shadeView.bounds.size.height * 0.5;
    
}


-(void)setBackGroundLayer{
    
    //创建渐变layer
    CAGradientLayer *layer = [[CAGradientLayer alloc]init];
    
    //设置大小
    layer.bounds = self.view.bounds;
    layer.position = self.view.center;
    
    //设置颜色
    CGColorRef color1 = [UIColor colorWithHex:0x394552].CGColor;
    CGColorRef color2 = [UIColor colorWithHex:0x406497].CGColor;
    CGColorRef color3 = [UIColor colorWithHex:0x406578].CGColor;
    layer.colors = @[(__bridge UIColor *)color1,(__bridge UIColor *)color2,(__bridge UIColor *)color3];
    layer.locations = @[@0,@0.6,@1];
    
    //添加到最底层
    [self.view.layer insertSublayer:layer atIndex:0];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    
    
}

#pragma mark - 按钮点击事件

- (IBAction)SportStateButtonClick:(UIButton *)sender { 
 
    
    DJFSportTimingView *timingView = [[DJFSportTimingView alloc] initWithSourceView:sender Completion:^{
     
        DJFSportingViewController *sportVC = [[UIStoryboard storyboardWithName:@"Sport" bundle:nil] instantiateViewControllerWithIdentifier:@"DJFSportingViewController"];
        
        sportVC.sportType = _cardView.pageIndex + 1;
        //3.跳转
        [self presentViewController: sportVC animated:YES completion:nil];
    }];
   
    
    //这里应该添加到tabBarController.view才能覆盖tabbar
    [self.tabBarController.view addSubview:timingView];

    
   
    
    
}


@end
