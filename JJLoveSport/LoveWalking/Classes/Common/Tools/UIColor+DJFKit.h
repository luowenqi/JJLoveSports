//
//  UIColor+DJFKit.h
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DJFKit)

/*!
 *  返回一个RGBA格式的UIColor对象
 */
#define KRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


/*!
 *  从HEX数值得到一个UIColor对象
 */
+ (UIColor *)colorWithHex:(unsigned int)hex;

/*!
 *  从HEX数值和Alpha数值得到一个UIColor对象
 */
+ (UIColor *)colorWithHex:(unsigned int)hex
                    alpha:(float)alpha;

/*!
 *  创建一个随机UIColor对象
 */
+ (UIColor *)randomColor;

/*!
 *  从已知UIColor对象和Alpha对象得到一个UIColor对象
 */
+ (UIColor *)colorWithColor:(UIColor *)color
                      alpha:(float)alpha;

/*!
 *  UIColor 转UIImage
 *
 *  @param color color
 *
 *  @return UIColor 转UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
//将color 转换成16进制文本
+(NSString*)converUIColorToStirng:(UIColor*)color;
//将16进制文本 转换成color
+(UIColor*)toUIColorByStr:(NSString*)colorStr;
@end
