//
//  UIColor+DJFKit.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/4/30.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "UIColor+DJFKit.h"

@implementation UIColor (DJFKit)


/*  从HEX数值得到一个UIColor对象 */
+ (id)colorWithHex:(unsigned int)hex
{
    return [UIColor colorWithHex:hex
                           alpha:1.0];
}

/*  从HEX数值和Alpha数值得到一个UIColor对象 */
+ (id)colorWithHex:(unsigned int)hex
             alpha:(float)alpha
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hex & 0xFF)) / 255.0
                           alpha:alpha];
}
/* 创建一个随机UIColor对象 */
+ (UIColor *)randomColor
{
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    
    return [UIColor colorWithRed:r/255.0
                           green:g/255.0
                            blue:b/255.0
                           alpha:1.0];
}

/*  从已知UIColor对象和Alpha对象得到一个UIColor对象 */
+ (UIColor *)colorWithColor:(UIColor *)color
                      alpha:(float)alpha
{
    if([color isEqual:[UIColor whiteColor]])
        return [UIColor colorWithWhite:1.000
                                 alpha:alpha];
    if([color isEqual:[UIColor blackColor]])
        return [UIColor colorWithWhite:0.000
                                 alpha:alpha];
    
    // 使用CGColorGetComponents方法，获取'color'关联的颜色组件
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return [UIColor colorWithRed:components[0]
                           green:components[1]
                            blue:components[2]
                           alpha:alpha];
}


/*!
 *  UIColor 转UIImage
 *
 *  @param color color
 *
 *  @return UIColor 转UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
//将color 转换成16进制文本
+(NSString*)converUIColorToStirng:(UIColor*)color{
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
    return [NSString stringWithFormat:@"%06x", rgb];
}
//将16进制文本 转换成color
+(UIColor*)toUIColorByStr:(NSString*)colorStr{
    
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end
