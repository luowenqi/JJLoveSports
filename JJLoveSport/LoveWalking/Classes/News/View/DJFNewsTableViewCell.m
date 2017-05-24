//
//  DJFNewsTableViewCell.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/4.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFNewsTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface DJFNewsTableViewCell ()

@property(nonatomic,strong)UILabel *titleLlb;
@property(nonatomic,strong)UILabel *dercribleLlb;
@property(nonatomic,strong)UIImageView *thumbImg;

@end

@implementation DJFNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInfoModel:(DJFNewsInfoModel *)infoModel{
    _infoModel = infoModel;
    _titleLlb.text = infoModel.title;
    _dercribleLlb.text = infoModel.descrube;
    [_thumbImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",baseUrl,infoModel.picUrl]]];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //标题
    UILabel* titleLlb = [UILabel new];
    _titleLlb = titleLlb;
    titleLlb.numberOfLines = 1;
    titleLlb.textColor = [UIColor blackColor];
    titleLlb.font = [UIFont systemFontOfSize:18 weight:2];
    [self.contentView addSubview:titleLlb];

    //简介
    
    UILabel* dercribleLlb = [UILabel new];
    _dercribleLlb = dercribleLlb;
    dercribleLlb.numberOfLines = 2;
    dercribleLlb.textColor = [UIColor grayColor];
    dercribleLlb.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:dercribleLlb];
    //图片
    UIImageView* thumbImg = [UIImageView new];
    _thumbImg = thumbImg;
    [self.contentView addSubview:thumbImg];
    
    
    //布局
   [thumbImg mas_makeConstraints:^(MASConstraintMaker *make) {

       make.right.offset(-15);
       make.centerY.offset(0);
       make.width.offset(115);
       make.height.offset(85);
   }];
    [titleLlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.equalTo(thumbImg.mas_left).offset(-20);
        make.top.equalTo(thumbImg.mas_top).offset(01);
    }];
    
    [dercribleLlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLlb.mas_left).offset(0);
        make.right.equalTo(thumbImg.mas_left).offset(-20);
        make.top.equalTo(titleLlb.mas_bottom).offset(10);
    }];
    
}
@end
