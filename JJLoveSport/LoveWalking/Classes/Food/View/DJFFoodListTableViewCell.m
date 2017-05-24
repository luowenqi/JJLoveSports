//
//  DJFFoodListTableViewCell.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/6.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFFoodListTableViewCell.h"

@interface DJFFoodListTableViewCell ()

@property(nonatomic,strong)UILabel *leftTitle;
@property(nonatomic,strong)UILabel *rightDesc;
@end
@implementation DJFFoodListTableViewCell

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

- (void)setListModel:(DJFFoodListModel *)listModel{
    _listModel = listModel;
    _leftTitle.text = listModel.name;
    _rightDesc.text = listModel.weight;
    
}
- (void)setupUI{
    UILabel* leftTitle = [UILabel createLabelWith:@"" fontSize:14 numberOfLine:1 color:KRGBA(62, 47, 36, 1)];
    _leftTitle = leftTitle;
    [self.contentView addSubview:leftTitle];
    [UILabel changeSpaceForLabel:leftTitle withLineSpace:0 WordSpace:4];
    UILabel* rightDesc = [UILabel createLabelWith:@"" fontSize:14 numberOfLine:1 color:KRGBA(62, 47, 36, 1)];
    _rightDesc = rightDesc;
    [self.contentView addSubview:rightDesc];
    
    [leftTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.equalTo(rightDesc.mas_left).offset(5);
        make.centerY.offset(0);
    }];
    
    [rightDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.centerY.offset(0);
        make.width.offset(100);
    }];
    rightDesc.textAlignment = NSTextAlignmentRight;
    //self.contentView.backgroundColor = [UIColor grayColor];
  
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
