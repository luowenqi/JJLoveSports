//
//  DJFFoodInfoViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/5.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFFoodInfoViewController.h"
#import "DJFFoodListTableViewCell.h"
#import <WebKit/WebKit.h>
#import "DJFFoodInfoView.h"
#import <UIImageView+WebCache.h>
#import "DJFFoodInfoCell.h"
#import "DJFFoodInfoView.h"
@interface DJFFoodInfoViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>;
/**
 *  食物大图
 */
@property(nonatomic,strong)UIImageView *foodPic;

/**
 *  食物明细
 */
@property(nonatomic,strong)UIView *infoView;


@end
static NSString* resId1 = @"resid1";
static NSString* resId2 = @"resid2";
@implementation DJFFoodInfoViewController{
    UITableView* popView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    //大图片
    [self createBigPic];
    //[self createFoodInfo];
    
    
    popView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:popView];
    popView.backgroundColor = [UIColor clearColor];
    popView.contentInset = UIEdgeInsetsMake(220, 0, 0, 0);
    popView.delegate = self;
    popView.dataSource = self;
    popView.rowHeight = UITableViewAutomaticDimension;
    popView.estimatedRowHeight = 400;
    popView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [popView registerClass:[DJFFoodInfoView class] forCellReuseIdentifier:resId1];
    [popView registerClass:[DJFFoodInfoCell class] forCellReuseIdentifier:resId2];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//     DJFFoodInfoView* infoView = [DJFFoodInfoView new];
//    infoView.infoModel = _infoModel;
//    [popView setTableHeaderView:infoView];
//    popView.tableFooterView = [[UIView alloc]init];
//    __weak typeof(infoView) weakinfoView = infoView;
//    infoView.changeHeigh = ^{
//      
//        [popView setTableHeaderView:weakinfoView];
//       
//    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        DJFFoodInfoView* foodView = [tableView dequeueReusableCellWithIdentifier:resId1 forIndexPath:indexPath];
        foodView.infoModel = _infoModel;
        foodView.selectionStyle = UITableViewCellSelectionStyleNone;
        foodView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        return foodView;
    }else{
        DJFFoodInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:resId2 forIndexPath:indexPath];
        cell.fId = _infoModel.fId;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)createBigPic{
   
    
    //异步加载图片，防止约束错误
    _foodPic = [UIImageView new];
    
    //图片
    [_foodPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",baseUrl,_infoModel.imgUrl]]placeholderImage:[UIImage imageNamed:@""]];
    
    _foodPic.frame = CGRectMake(0, 0, SCREEN_BOUNDS.size.width, 220);
    [self.view addSubview:_foodPic];
    _foodPic.contentMode = UIViewContentModeScaleAspectFill;
    _foodPic.clipsToBounds = YES;
    //食物标题
    UILabel* foodNameLbl = [[UILabel alloc]init];
    foodNameLbl.text = _infoModel.title;
    foodNameLbl.textColor = [UIColor whiteColor];
    foodNameLbl.font = [UIFont systemFontOfSize:24];
    [_foodPic addSubview:foodNameLbl];
    
    [foodNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.offset(-15);
        make.right.offset(-10);
    }];
    
    //烹饪时间
    UILabel* cookMinLlb = [[UILabel alloc]init];
    cookMinLlb.text =_infoModel.time;
    cookMinLlb.textColor = [UIColor whiteColor];
    cookMinLlb.font = [UIFont systemFontOfSize:14];
    cookMinLlb.numberOfLines = 1;
    [_foodPic addSubview:cookMinLlb];
    
    [cookMinLlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(foodNameLbl.mas_left).offset(0);
        make.bottom.equalTo(foodNameLbl.mas_top).offset(-8);
        make.right.offset(-10);
    }];

}
-(void)dealloc{
    //NSLog(@"释放了");
}


#pragma makr - 代理协议

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    int contentOffext = scrollView.contentOffset.y;
    _foodPic.frame = CGRectMake(0, 0, SCREEN_BOUNDS.size.width,abs(contentOffext));
}


@end
