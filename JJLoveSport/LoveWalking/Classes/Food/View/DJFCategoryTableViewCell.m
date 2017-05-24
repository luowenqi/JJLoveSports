//
//  DJFCategoryTableViewCell.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/5.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFCategoryTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface DJFCategoryTableViewCell ()

@property(nonatomic,strong)UIImageView *foodImg;
@property(nonatomic,strong)UILabel *titleLbl;
@property(nonatomic,strong)UILabel *praiseNum;

@end
@implementation DJFCategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setInfoModel:(DJFFoodInfoModel *)infoModel{
    _infoModel = infoModel;
    _titleLbl.text = infoModel.title;
    _praiseNum.text = infoModel.praiseNum;
    [_foodImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",baseUrl,infoModel.imgUrl]]placeholderImage:[UIImage imageNamed:@""]];
   // NSLog(@"%@",[NSString stringWithFormat:@"%@/%@",baseUrl,infoModel.imgUrl]);
    
}

- (void)setupUI{
    
    self.contentView.backgroundColor = [UIColor blackColor];
    //背景图片
    UIImageView* foodImg = [[UIImageView alloc]init];
   
    _foodImg = foodImg;
    [self.contentView addSubview:foodImg];
    
    //标题
    UILabel* titleLbl = [[UILabel alloc]init];
    _titleLbl = titleLbl;
    titleLbl.numberOfLines = 1;
    titleLbl.font = [UIFont systemFontOfSize:24 weight:2];
    titleLbl.textColor = [UIColor orangeColor];
    [self.contentView addSubview:titleLbl];
    //点赞
    UIImageView* praiseImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"discoverNav_collectionHeart_6P"]];
    [self.contentView addSubview:praiseImg];
   
    UILabel* praiseNum = [[UILabel alloc]init];
    praiseNum.textColor = [UIColor whiteColor];
    _praiseNum = praiseNum;
    [self.contentView addSubview:praiseNum];
    
    //布局
    [foodImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.offset(-5);
    }];
    
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset( 20);
        make.right.offset(-40);
        make.bottom.offset(-40);
    }];
    
    [praiseNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.bottom.offset(-8);
    }];
    [praiseImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(praiseNum.mas_left).offset(-5);
        make.centerY.equalTo(praiseNum.mas_centerY);
        make.width.height.offset(15);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
