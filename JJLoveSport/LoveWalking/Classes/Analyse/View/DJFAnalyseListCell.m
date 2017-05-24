//
//  DJFAnalyseListCell.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/16.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFAnalyseListCell.h"

@interface DJFAnalyseListCell ()
/**
 *  时间
 */
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *distanceLabel;
@property(nonatomic,strong)UILabel *timeSpendLabel;

@end
@implementation DJFAnalyseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setSportSqlModel:(DJFSportSqlModel *)sportSqlModel{
    _sportSqlModel = sportSqlModel;
    _timeLabel.text = sportSqlModel.endTime;
    CGFloat distance = sportSqlModel.totalDistance.floatValue;
    _distanceLabel.text = [NSString stringWithFormat:@"%.2lf",distance * 0.001];
    NSInteger timeSpend = sportSqlModel.timeSpend.integerValue;
    _timeSpendLabel.text = [NSString stringWithFormat:@"%02zd:%02zd:%02zd",timeSpend/3600,(timeSpend%3600)/60,timeSpend%60];
}

- (void)setupUI{
    self.contentView.backgroundColor = [UIColor blackColor];
    _timeLabel = [UILabel createLabelWith:@"" fontSize:12 numberOfLine:1 color:[UIColor lightGrayColor]];
    [self.contentView addSubview:_timeLabel];
    _timeLabel.font = [UIFont fontWithName:@"MFLiHei_Noncommercial-Regular" size:12];
    _distanceLabel = [UILabel createLabelWith:@"" fontSize:26 numberOfLine:1 color:[UIColor whiteColor]];
    [self.contentView addSubview:_distanceLabel];
    
    _distanceLabel.font = [UIFont fontWithName:@"MFLiHei_Noncommercial-Regular" size:24];
    UILabel* distanceUnitLabel = [UILabel createLabelWith:@"KM" fontSize:15 numberOfLine:1 color:[UIColor lightGrayColor]];
    [self.contentView addSubview:distanceUnitLabel];
    distanceUnitLabel.font = [UIFont fontWithName:@"MFLiHei_Noncommercial-Regular" size:15];
    _timeSpendLabel = [UILabel createLabelWith:@"" fontSize:15 numberOfLine:1 color:[UIColor lightGrayColor]];
    [self.contentView addSubview:_timeSpendLabel];
    _timeSpendLabel.font = [UIFont fontWithName:@"MFLiHei_Noncommercial-Regular" size:15];
    
    UIView* lineView = [UIView new];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:lineView];
    
    UILabel* accessconyLabel = [UILabel createLabelWith:@">" fontSize:15 numberOfLine:1 color:[UIColor whiteColor]];
    [self.contentView addSubview:accessconyLabel];
    accessconyLabel.font = [UIFont fontWithName:@"MFLiHei_Noncommercial-Regular" size:15];
    [accessconyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.offset(0);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(10);
    }];
    
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel.mas_left).offset(0);
        make.top.equalTo(_timeLabel.mas_bottom).offset(15);
    }];
    
    [distanceUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_distanceLabel.mas_right).offset(10);
        make.bottom.equalTo(_distanceLabel.mas_bottom).offset(0);
    }];
    
    [_timeSpendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(distanceUnitLabel.mas_right).offset(15);
        make.bottom.equalTo(distanceUnitLabel.mas_bottom).offset(0);
   
        
    }];
    [lineView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_timeSpendLabel.mas_bottom).offset(15);
        make.height.offset(1);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    
}
@end
