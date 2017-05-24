//
//  DJFFoodInfoView.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/6.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFFoodInfoView.h"
#import "DJFFoodListTableViewCell.h"
#import <WebKit/WebKit.h>
@interface DJFFoodInfoView ()<UITableViewDataSource,WKNavigationDelegate>
/**
 *  <#名称#>
 */
@property(nonatomic,strong)UITableView *foodListTbList;

/**
 *  <#名称#>
 */
@property(nonatomic,strong)WKWebView * wkWebView;

@property(nonatomic,strong)UILabel *deslbl;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIView *lineView2;
@property(nonatomic,strong)UIView *lineView3;
@property(nonatomic,strong)UILabel *calorieLbl;
@property(nonatomic,strong)UILabel *carbonLbl;
@property(nonatomic,strong)UILabel *proteinLbl;
@property(nonatomic,strong)UILabel *fatLbl;

@property(nonatomic,strong)UILabel *calorieLbl2;
@property(nonatomic,strong)UILabel *carbonLbl2;
@property(nonatomic,strong)UILabel *proteinLbl2;
@property(nonatomic,strong)UILabel *fatLbl2;
@property(nonatomic,strong)UILabel *foodListLbl;
@property(nonatomic,strong)UILabel *stepLbl;
@end
static NSString* resId = @"resId";
@implementation DJFFoodInfoView{
    CGFloat webViewH;
    CGFloat tableViewH;
    NSMutableArray* infoListArrM;
    CGFloat lastHeight ;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        //self.frame = CGRectMake(0, 0, 375, 1000);
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    [self createFoodInfo];
//    //监听wkwebview contentSize的变化
//    [_wkWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)setInfoModel:(DJFFoodInfoModel *)infoModel{
    _infoModel = infoModel;
    _deslbl.text = infoModel.describe;
    _carbonLbl.text = infoModel.carbon.length > 0 ? infoModel.carbon : @"0g";
    _calorieLbl.text = infoModel.calorie.length > 0 ? infoModel.calorie : @"0g";
    _fatLbl.text = infoModel.fat.length > 0 ? infoModel.fat : @"0g";
    _proteinLbl.text = infoModel.protein.length > 0 ? infoModel.protein :@"0g";
}

- (void)createFoodInfo{
    
    //简介
    _deslbl = [UILabel createLabelWith:@"" fontSize:14 numberOfLine:0 color:[UIColor darkGrayColor]];
    [self.contentView addSubview:_deslbl];

    [UILabel changeLineSpaceForLabel:_deslbl withSpace:5];
    //线
    _lineView = [UIView new];
    _lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_lineView];
    
    infoListArrM = [NSMutableArray arrayWithCapacity:4];
    
    _calorieLbl = [UILabel createLabelWith:@"" fontSize:18 numberOfLine:1 color:[UIColor blackColor]];
    _calorieLbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_calorieLbl];
    [infoListArrM addObject:_calorieLbl];
    
    _carbonLbl = [UILabel createLabelWith:@"" fontSize:18 numberOfLine:1 color:[UIColor blackColor]];
    _carbonLbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_carbonLbl];
    [infoListArrM addObject:_carbonLbl];
    
    _proteinLbl = [UILabel createLabelWith:@"" fontSize:18 numberOfLine:1 color:[UIColor blackColor]];
    [self.contentView addSubview:_proteinLbl];
    _proteinLbl.textAlignment = NSTextAlignmentCenter;
    [infoListArrM addObject:_proteinLbl];
    
    _fatLbl = [UILabel createLabelWith:@"" fontSize:18 numberOfLine:1 color:[UIColor blackColor]];
    _fatLbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_fatLbl];
    [infoListArrM addObject:_fatLbl];
    
    
    
    _calorieLbl2 = [UILabel createLabelWith:@"千卡" fontSize:14 numberOfLine:1 color:[UIColor grayColor]];
    [self.contentView addSubview:_calorieLbl2];
    
    _carbonLbl2 = [UILabel createLabelWith:@"碳水" fontSize:14 numberOfLine:1 color:[UIColor grayColor]];
    [self.contentView addSubview:_carbonLbl2];
    
    _proteinLbl2 = [UILabel createLabelWith:@"蛋白质" fontSize:14 numberOfLine:1 color:[UIColor grayColor]];
    [self.contentView addSubview:_proteinLbl2];
    
    _fatLbl2 = [UILabel createLabelWith:@"脂肪" fontSize:14 numberOfLine:1 color:[UIColor grayColor]];
    [self.contentView addSubview:_fatLbl2];
    
    //MARK: 食材
    _lineView2 = [UIView new];
    [self.contentView addSubview:_lineView2];
    _lineView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _foodListLbl = [UILabel createLabelWith:@"食材" fontSize:14 numberOfLine:1 color:[UIColor blackColor]];
    [self.contentView addSubview:_foodListLbl];
    
    _foodListTbList = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    _foodListTbList.allowsSelection = NO;
    _foodListTbList.rowHeight = 30;
    _foodListTbList.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:_foodListTbList];
    
    _foodListTbList.dataSource = self;
    _foodListTbList.scrollEnabled = NO;
    [_foodListTbList registerClass:[DJFFoodListTableViewCell class] forCellReuseIdentifier:resId];
    _lineView3 = [UIView new];
    [self.contentView addSubview:_lineView3];
    _lineView3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //MARK: 步骤
    _stepLbl = [UILabel createLabelWith:@"步骤" fontSize:14 numberOfLine:1 color:[UIColor blackColor]];
    [self.contentView addSubview:_stepLbl];
    
    [_deslbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-15);
        make.top.offset(15);
        
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.height.offset(1);
        make.top.equalTo(_deslbl.mas_bottom).offset(10);
    }];
    
    [infoListArrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:50 leadSpacing:30 tailSpacing:30];
    [infoListArrM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.mas_bottom).offset(20);
    }];
    
    [_calorieLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_calorieLbl);
        make.top.equalTo(_calorieLbl.mas_bottom).offset(5);
    }];
    
    [_carbonLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_carbonLbl);
        make.top.equalTo(_carbonLbl.mas_bottom).offset(5);
    }];
    
    [_proteinLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_proteinLbl);
        make.top.equalTo(_proteinLbl.mas_bottom).offset(5);
    }];
    
    [_fatLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_fatLbl);
        make.top.equalTo(_fatLbl.mas_bottom).offset(5);
        
    }];
    
    [_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(8);
        make.top.equalTo(_carbonLbl2.mas_bottom).offset(20);
    }];
    [_foodListLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.top.equalTo(_lineView2.mas_bottom).offset(20);
        
    }];
    [_foodListTbList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.height.offset(tableViewH);
        make.top.equalTo(_foodListLbl.mas_bottom).offset(15);
    }];
    
    [_lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(8);
        make.top.equalTo(_foodListTbList.mas_bottom).offset(15);
    }];
    
    [_stepLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_foodListLbl.mas_left);
        make.top.equalTo(_lineView3.mas_bottom).offset(20);
        make.bottom.offset(-10);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.offset(0);
    }];

    
}

#pragma mark - 数据源协议

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = _infoModel.foodList.count;
    tableViewH = count * 30;
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DJFFoodListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: resId forIndexPath:indexPath];
    cell.listModel = _infoModel.foodList[indexPath.row];
    if (indexPath.row % 2) {
        cell.backgroundColor = KRGBA(249, 247, 253, 1);
    }
    return cell;
}

@end
