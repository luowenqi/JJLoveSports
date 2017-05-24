//
//  DJFBaseControl.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/4.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFBaseControl.h"

@implementation DJFBaseControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {}
@end
