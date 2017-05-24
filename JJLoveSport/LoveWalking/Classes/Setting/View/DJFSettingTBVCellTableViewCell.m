//
//  DJFSettingTBVCellTableViewCell.m
//  LoveWalking
//
//  Created by 陈逸麒 on 2017/5/13.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFSettingTBVCellTableViewCell.h"

@interface DJFSettingTBVCellTableViewCell ()

/**
 图标
 */
@property(nonatomic,weak)UIImageView *iconView;

/**
 图标名
 */
@property(nonatomic,weak)UILabel *nameLabel;

@end

@implementation DJFSettingTBVCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    ////1.创建UIimageView
    UIImageView *imView = [[UIImageView alloc]init];
    
    //设置UIimageView
    UIImage *im = [UIImage imageNamed:@"content_img_01"];
    imView.image = im;
    
    //记录
    _iconView = imView;
    
    [self.contentView addSubview:imView];
    
    CGFloat w = 24;
    CGFloat h = 24;
    CGFloat margin = 10;
    
    [imView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(margin);
        make.size.mas_equalTo(CGSizeMake(w, h));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:15];
    
    _nameLabel = nameLabel;
    
    [self.contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(imView.mas_right).offset(margin);
        make.centerY.mas_equalTo(self.contentView);
        
    }];
    
    //3.创建右边尖括号
    UIImageView *imaView = [[UIImageView alloc]init];
    
    //设置右边尖括号
    UIImage *image = [UIImage imageNamed:@"position-right"];
    
    imaView.image = image;
    
    
    //添加
    [self.contentView addSubview:imaView];
    
    [imaView sizeToFit];
    //布局右边尖括号
    [imaView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.contentView).offset(-w+10);
        make.centerY.mas_equalTo(self.contentView);
        
    }];

    
    
}

-(void)setArrList:(DJFSettingTBVModel *)arrList{
    
    _arrList = arrList;
    
    _iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",arrList.icon]];
    
    _nameLabel.text = arrList.name;
    
}
@end
