//
//  UIColor+HEX.h
//  Echo
//
//  Created by robu on 15/1/4.
//  Copyright (c) 2015年 Static Ga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HEX)
+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*) color;
//获取两种颜色渐变的颜色点
+(NSMutableArray *)gradientColorArrayStartHexColor:(NSInteger)startColor EndHexColor:(NSInteger)endColor Step:(NSInteger)step Alpha:(CGFloat)alpha;

+(UIColor*)randomColor;
@end
