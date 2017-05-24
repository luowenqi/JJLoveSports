//
//  CardItem.m
//  Card
//
//  Created by D on 17/1/4.
//  Copyright © 2017年 D. All rights reserved.


#import "CardItem.h"
#import "CardViewConstants.h"


@interface CardItem ()

@property (weak, nonatomic) IBOutlet UIView  * bgView;
@property (weak, nonatomic) IBOutlet UIImageView * iconImageView;

@property (weak, nonatomic) IBOutlet UIView  * alphaMaskView;

@property (weak, nonatomic) IBOutlet UILabel *pageNumLbl;


@end


@implementation CardItem

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.bgView.layer.cornerRadius  = 10;
    _pageNumLbl.text = [NSString stringWithFormat:@"%zd/3",_pageNum + 1];
    self.layer.shadowColor   = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset  = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 0.15;
    self.layer.shadowRadius  = 2;
}

- (void)setPageNum:(NSInteger)pageNum{
    _pageNum = pageNum;
     _pageNumLbl.text = [NSString stringWithFormat:@"%zd/3",_pageNum + 1];
}
- (void)setItemWIthImageName:(NSString *)imageName{
     self.iconImageView.image = [UIImage imageNamed:imageName];
}

- (void)addAlphaMaskView
{
    self.alphaMaskView.alpha = 0.1;
}

- (void)removeAlphaMaskView
{
    self.alphaMaskView.alpha = 0;
}

@end
