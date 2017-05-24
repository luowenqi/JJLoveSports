//
//  UILabel+DJFKit.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/6.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "UILabel+DJFKit.h"

@implementation UILabel (DJFKit)
+ (void)changeLineSpaceForLabel:(UILabel*)label withSpace:(float)space{
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (instancetype)createLabelWith:(NSString*)title fontSize:(CGFloat)fontSize numberOfLine:(NSInteger)numberOfLine color:(UIColor*)color{
    UILabel* label  = [self new];
    label.text = title;
    label.textColor = color;
    label.numberOfLines = numberOfLine;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}
@end
