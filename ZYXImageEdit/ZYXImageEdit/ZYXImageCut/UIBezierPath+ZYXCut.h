//
//  UIBezierPath+ZYXCut.h
//  TourNote
//
//  Created by 极客天地 on 2017/2/15.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (ZYXCut)
//绘制珠宝形路径
+(UIBezierPath *)jewelryPathWithInRect:(CGRect)rect;
//绘制三角形路径
+(UIBezierPath *)trianglePathWithInRect:(CGRect)rect;
//绘制五角星路径
+(UIBezierPath *)fivePointStarPathWithInRect:(CGRect)rect;
//绘制椭圆锯齿形路径
+(UIBezierPath*)sawtoothPathWithInRect:(CGRect)rect;
//绘制心形路径
+(UIBezierPath *)heartPathWithInRect:(CGRect)rect;
@end
