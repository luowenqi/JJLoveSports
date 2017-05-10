//
//  UIButton+Addtion.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "UIButton+Addtion.h"

@implementation UIButton (Addtion)


-(instancetype)initWithTitle:(NSString*)titlet titleColor:(UIColor*)titleColor image:(NSString*)imageName selectImage:(NSString*)selectImageName addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{

    if (self = [super init]) {
        
        [self setTitle:titlet forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateHighlighted];
        [self addTarget:target action:action forControlEvents:controlEvents];
        self.contentMode = UIViewContentModeScaleToFill;
    }
    return self;
}

@end
