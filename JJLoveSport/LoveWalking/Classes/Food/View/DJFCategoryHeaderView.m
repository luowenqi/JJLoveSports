//
//  DJFCategoryHeaderView.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/5.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFCategoryHeaderView.h"

@interface DJFCategoryHeaderView ()
@property(nonatomic,strong)UILabel *categoryLbl;
@property(nonatomic,strong)UILabel *subtitleLbl;
@end
@implementation DJFCategoryHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setTypeModel:(DJFFoodTypeModel *)typeModel{
    _typeModel = typeModel;
    _categoryLbl.text = typeModel.type;
    _subtitleLbl.text = typeModel.subTitle;
    
}
- (void)setupUI{
    UILabel* categoryLbl = [[UILabel alloc]init];
    _categoryLbl = categoryLbl;
    categoryLbl.textColor = [UIColor whiteColor];
    categoryLbl.font = [UIFont systemFontOfSize:24];
    [self addSubview:categoryLbl];
    
    UILabel* subtitleLbl = [[UILabel alloc]init];
    _subtitleLbl = subtitleLbl;
    subtitleLbl.textAlignment = NSTextAlignmentRight;
    subtitleLbl.textColor = [UIColor whiteColor];
    subtitleLbl.font = [UIFont systemFontOfSize:16];
    [self addSubview:subtitleLbl];
    UIImageView* moreImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"taoge"]];
    [self addSubview:moreImg];
    
    [categoryLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(10);
        make.right.equalTo(subtitleLbl.mas_left).offset(40);
    }];
    [moreImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.centerY.offset(0);
    }];
    [subtitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moreImg.mas_left).offset(0);
        make.centerY.offset(0);
    }];
}
@end
