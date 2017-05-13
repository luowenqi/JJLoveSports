//
//  UILabel+Addtion.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/12.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "UILabel+Addtion.h"

@implementation UILabel (Addtion)

-(instancetype)initWithText:(NSString*)text andFont:(UIFont*)font textColor:(UIColor*)color{

    if (self = [super initWithFrame:CGRectZero] ) {
        
        self.text = text;
        self.font = font;
        self.textColor = color;
        
    }
    
    return self;
}


@end
