//
//  UIButton+Addtion.h
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Addtion)

-(instancetype)initWithTitle:(NSString*)titlet titleColor:(UIColor*)titleColor image:(NSString*)imageName selectImage:(NSString*)selectImageName addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
