//
//  DJFCategoryView.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/4.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFCategoryView.h"
#import "UIButton+DJFKit.h"
@interface DJFCategoryView ()
/**
 *   黄色小条
 */
@property (nonatomic, weak)UIView* underLine;
/**
 *   选中状态的按钮
 */
@property (nonatomic, weak)UIButton* seletedBtn;

/**
 *  黄色小条坐标
 */
@property(nonatomic,assign)CGFloat underLineOffsetX;

/**
 *  按钮数组
 */
@property(nonatomic,strong)NSMutableArray<UIButton*> * categroyBtnList;
@end
@implementation DJFCategoryView
#pragma mark - 返回选中按钮tag
-(NSInteger)getSelectBtnTag{
    return _seletedBtn.tag;
}
#pragma mark - 黄色小线数据更新并移动

- (void)setCurrentIndex:(NSInteger)currentIndex{
    
    _currentIndex = currentIndex;
    //根据偏移移动黄色线条
    _underLineOffsetX = currentIndex * (self.bounds.size.width / _catagoryList.count);
    [_underLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(_underLineOffsetX);
    }];
    //更新按钮选中状态
    _seletedBtn.selected = NO;
    _seletedBtn = _categroyBtnList[currentIndex];
    _seletedBtn.selected = YES;
}
#pragma mark - 按钮点击事件
-(void)selectCategory:(UIButton*)btn{
    
    if (btn.tag == _currentIndex) {
        return;
    }
    //MARK: 根据点击移动黄色小线
    [_underLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(btn.bounds.size.width * btn.tag);
    }];
    //MARK: 按钮事件
    _seletedBtn.selected = NO;
    btn.selected = YES;
    _seletedBtn = btn;
    _currentIndex = _seletedBtn.tag;
    //MARK: 发送按钮更新消息
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - UI搭建

- (void)setCatagoryList:(NSArray *)catagoryList{
    _catagoryList = catagoryList;
    
    //MARK: 按钮
    //设置背景颜色
    self.backgroundColor = [UIColor whiteColor];
    //菜单列表
    NSArray*  categoryBtnNameList = _catagoryList;
    _categroyBtnList = [NSMutableArray arrayWithCapacity:categoryBtnNameList.count];
    //创建按钮
    for (NSInteger i = 0 ; i < categoryBtnNameList.count;i++) {
        UIButton* btn = [UIButton textButton:categoryBtnNameList[i] fontSize:14 normalColor:[UIColor blackColor] selectedColor:[UIColor orangeColor]];
        [self addSubview:btn];
        [_categroyBtnList addObject:btn];
        //按钮点击
        [btn addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
        //增加tag值
        btn.tag = i;
    }
    //设置按钮位置
    [_categroyBtnList mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0 ];
    [_categroyBtnList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
    }];
    //设置第一个按钮为默认选中状态
    _categroyBtnList[0].selected = YES;
    _seletedBtn = _categroyBtnList[0];
 
    //MARK: 小黄条
    UIView* underLine  = [UIView new];
    underLine.backgroundColor = [UIColor orangeColor];
    [self addSubview:underLine];
    [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(2);
        make.width.equalTo(_categroyBtnList[0].mas_width).offset(0);
        make.bottom.left.offset(0);
    }];
    //记录
    _underLine = underLine;
    
}


@end
