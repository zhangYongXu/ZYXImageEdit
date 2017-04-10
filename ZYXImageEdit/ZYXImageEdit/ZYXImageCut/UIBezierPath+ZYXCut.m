//
//  UIBezierPath+ZYXCut.m
//  TourNote
//
//  Created by 极客天地 on 2017/2/15.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "UIBezierPath+ZYXCut.h"

@implementation UIBezierPath (ZYXCut)
//绘制珠宝形路径
+(UIBezierPath *)jewelryPathWithInRect:(CGRect)rect{
    //绘制珠宝形裁剪区域
    CGFloat squreCutRectX = rect.origin.x;
    CGFloat squreCutRectY = rect.origin.y;
    CGFloat squreCutRectW = rect.size.width;
    CGFloat squreCutRectH = rect.size.height;
    UIBezierPath* jewelryPath = [UIBezierPath bezierPath];
    CGPoint leftTopPoint = CGPointMake(squreCutRectX + squreCutRectW*0.28, squreCutRectY + squreCutRectH*0.12);
    CGPoint rightTopPoint = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*0.28), squreCutRectY + squreCutRectH*0.12);
    
    CGPoint leftPoint = CGPointMake(squreCutRectX,squreCutRectY + squreCutRectH*0.4);
    CGPoint rightPoint = CGPointMake(squreCutRectX + squreCutRectW,squreCutRectY + squreCutRectH*0.4);
    CGPoint bottomCenterPoint = CGPointMake(squreCutRectX + squreCutRectW/2.0,squreCutRectY + (squreCutRectH - squreCutRectH*0.12));
    [jewelryPath moveToPoint:leftTopPoint];
    
    [jewelryPath addLineToPoint:leftPoint];
    [jewelryPath addLineToPoint:bottomCenterPoint];
    [jewelryPath addLineToPoint:rightPoint];
    [jewelryPath addLineToPoint:rightTopPoint];
    
    //线条的颜色
    UIColor *strokColor = [UIColor clearColor];
    [strokColor set];
    
    [jewelryPath closePath]; //第五条线通过调用closePath方法得到的
    [jewelryPath stroke]; //Draws line 根据坐标点连线
    return jewelryPath;
}
//绘制三角形路径
+(UIBezierPath *)trianglePathWithInRect:(CGRect)rect{
    //绘制三角形裁剪区域
    UIBezierPath * trianglePath = [UIBezierPath bezierPath];
    CGFloat squreCutRectX = rect.origin.x;
    CGFloat squreCutRectY = rect.origin.y;
    CGFloat squreCutRectW = rect.size.width;
    CGFloat squreCutRectH = rect.size.height;
    
    CGPoint topCenterPoint = CGPointMake(squreCutRectX+squreCutRectW/2.0, squreCutRectY);
    CGPoint leftBottomPoint = CGPointMake(squreCutRectX, squreCutRectY+squreCutRectH);
    CGPoint rightBottomPoint = CGPointMake(squreCutRectX+squreCutRectW, squreCutRectY+squreCutRectH);
    
    [trianglePath moveToPoint:topCenterPoint];
    
    [trianglePath addLineToPoint:leftBottomPoint];
    [trianglePath addLineToPoint:rightBottomPoint];
    //线条的颜色
    UIColor *strokColor = [UIColor clearColor];
    [strokColor set];
    
    [trianglePath closePath]; //第三条线通过调用closePath方法得到的
    [trianglePath stroke]; //Draws line 根据坐标点连线
    return trianglePath;
}
//绘制五角星路径
+(UIBezierPath *)fivePointStarPathWithInRect:(CGRect)rect{
    CGFloat squreCutRectX = rect.origin.x;
    CGFloat squreCutRectY = rect.origin.y;
    CGFloat squreCutRectW = rect.size.width;
    CGFloat squreCutRectH = rect.size.height;
    UIBezierPath* fivePointStarPath = [UIBezierPath bezierPath];
    CGPoint topCenterPonint = CGPointMake(squreCutRectX + squreCutRectW/2.0, squreCutRectY);
    CGPoint left1Point = CGPointMake(squreCutRectX + squreCutRectW*0.37, squreCutRectY + squreCutRectH*0.34);
    CGPoint left2Point = CGPointMake(squreCutRectX , squreCutRectY + squreCutRectH*0.34);
    CGPoint left3Point = CGPointMake(squreCutRectX + squreCutRectW*0.25, squreCutRectY + squreCutRectH*0.63);
    CGPoint left4Point = CGPointMake(squreCutRectX + squreCutRectW*0.12, squreCutRectY + squreCutRectH);
    
    CGPoint bottomCenterPonint = CGPointMake(squreCutRectX + squreCutRectW/2.0, squreCutRectY + squreCutRectH*0.75);
    
    CGPoint right4Point = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*0.12), squreCutRectY + squreCutRectH);
    CGPoint right3Point = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*0.25), squreCutRectY + squreCutRectH*0.63);
    CGPoint right2Point = CGPointMake(squreCutRectX + squreCutRectW, squreCutRectY + squreCutRectH*0.34);
    CGPoint right1Point = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*0.37), squreCutRectY + squreCutRectH*0.34);
    
    [fivePointStarPath moveToPoint:topCenterPonint];
    
    [fivePointStarPath addLineToPoint:left1Point];
    [fivePointStarPath addLineToPoint:left2Point];
    [fivePointStarPath addLineToPoint:left3Point];
    [fivePointStarPath addLineToPoint:left4Point];
    
    [fivePointStarPath addLineToPoint:bottomCenterPonint];
    
    [fivePointStarPath addLineToPoint:right4Point];
    [fivePointStarPath addLineToPoint:right3Point];
    [fivePointStarPath addLineToPoint:right2Point];
    [fivePointStarPath addLineToPoint:right1Point];
    
    //线条的颜色
    UIColor *strokColor = [UIColor clearColor];
    [strokColor set];
    
    [fivePointStarPath closePath]; //第十条线通过调用closePath方法得到的
    [fivePointStarPath stroke]; //Draws line 根据坐标点连线
    return fivePointStarPath;
}
//绘制椭圆锯齿形路径
+(UIBezierPath*)sawtoothPathWithInRect:(CGRect)rect{
    CGFloat squreCutRectX = rect.origin.x;
    CGFloat squreCutRectY = rect.origin.y;
    CGFloat squreCutRectW = rect.size.width;
    CGFloat squreCutRectH = rect.size.height;
    
    UIBezierPath* sawtoothPath = [UIBezierPath bezierPath];
    
    CGFloat percent1 = 0.11;
    CGFloat percent2 = 0.04;
    CGFloat percent3 = 0.17;
    CGFloat percent4 = 0.15;
    CGFloat percent5 = 0.28;
    CGFloat percent6 = 0.31;
    CGFloat percent7 = 0.42;
    
    CGPoint topCenterPoint = CGPointMake(squreCutRectX + squreCutRectW/2.0, squreCutRectY);
    CGPoint leftTop1Point = CGPointMake(squreCutRectX + squreCutRectW*percent7, squreCutRectY + squreCutRectH*percent1);
    CGPoint leftTop2Point = CGPointMake(squreCutRectX + squreCutRectW*percent6, squreCutRectY + squreCutRectH*percent2);
    CGPoint leftTop3Point = CGPointMake(squreCutRectX + squreCutRectW*percent5, squreCutRectY + squreCutRectH*percent3);
    CGPoint leftTop4Point = CGPointMake(squreCutRectX + squreCutRectW*percent4, squreCutRectY + squreCutRectH*percent4);
    CGPoint leftTop5Point = CGPointMake(squreCutRectX + squreCutRectW*percent3, squreCutRectY + squreCutRectH*percent5);
    CGPoint leftTop6Point = CGPointMake(squreCutRectX + squreCutRectW*percent2, squreCutRectY + squreCutRectH*percent6);
    CGPoint leftTop7Point = CGPointMake(squreCutRectX + squreCutRectW*percent1, squreCutRectY + squreCutRectH*percent7);
    
    CGPoint leftCenterPoint = CGPointMake(squreCutRectX, squreCutRectY + squreCutRectH/2.0);
    CGPoint leftBottom1Point = CGPointMake(squreCutRectX + squreCutRectW*percent1, squreCutRectY + (squreCutRectH - squreCutRectH*percent7));
    CGPoint leftBottom2Point = CGPointMake(squreCutRectX + squreCutRectW*percent2, squreCutRectY + (squreCutRectH - squreCutRectH*percent6));
    CGPoint leftBottom3Point = CGPointMake(squreCutRectX + squreCutRectW*percent3, squreCutRectY + (squreCutRectH - squreCutRectH*percent5));
    CGPoint leftBottom4Point = CGPointMake(squreCutRectX + squreCutRectW*percent4, squreCutRectY + (squreCutRectH - squreCutRectH*percent4));
    CGPoint leftBottom5Point = CGPointMake(squreCutRectX + squreCutRectW*percent5, squreCutRectY + (squreCutRectH - squreCutRectH*percent3));
    CGPoint leftBottom6Point = CGPointMake(squreCutRectX + squreCutRectW*percent6, squreCutRectY + (squreCutRectH - squreCutRectH*percent2));
    CGPoint leftBottom7Point = CGPointMake(squreCutRectX + squreCutRectW*percent7, squreCutRectY + (squreCutRectH - squreCutRectH*percent1));
    
    CGPoint bottomCenterPoint = CGPointMake(squreCutRectX + squreCutRectW/2.0, squreCutRectY + squreCutRectH);
    CGPoint rightBottom1Point = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*percent1), squreCutRectY + (squreCutRectH - squreCutRectH*percent7));
    CGPoint rightBottom2Point = CGPointMake(squreCutRectX + (squreCutRectW -squreCutRectW*percent2), squreCutRectY + (squreCutRectH - squreCutRectH*percent6));
    CGPoint rightBottom3Point = CGPointMake(squreCutRectX + (squreCutRectW -squreCutRectW*percent3), squreCutRectY + (squreCutRectH - squreCutRectH*percent5));
    CGPoint rightBottom4Point = CGPointMake(squreCutRectX + (squreCutRectW -squreCutRectW*percent4), squreCutRectY + (squreCutRectH - squreCutRectH*percent4));
    CGPoint rightBottom5Point = CGPointMake(squreCutRectX + (squreCutRectW -squreCutRectW*percent5), squreCutRectY + (squreCutRectH - squreCutRectH*percent3));
    CGPoint rightBottom6Point = CGPointMake(squreCutRectX + (squreCutRectW -squreCutRectW*percent6), squreCutRectY + (squreCutRectH - squreCutRectH*percent2));
    CGPoint rightBottom7Point = CGPointMake(squreCutRectX + (squreCutRectW -squreCutRectW*percent7), squreCutRectY + (squreCutRectH - squreCutRectH*percent1));
    
    CGPoint rightCenterPoint = CGPointMake(squreCutRectX + squreCutRectW, squreCutRectY + squreCutRectH/2.0);
    CGPoint rightTop1Point = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*percent7), squreCutRectY + squreCutRectH*percent1);
    CGPoint rightTop2Point = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*percent6), squreCutRectY + squreCutRectH*percent2);
    CGPoint rightTop3Point = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*percent5), squreCutRectY + squreCutRectH*percent3);
    CGPoint rightTop4Point = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*percent4), squreCutRectY + squreCutRectH*percent4);
    CGPoint rightTop5Point = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*percent3), squreCutRectY + squreCutRectH*percent5);
    CGPoint rightTop6Point = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*percent2), squreCutRectY + squreCutRectH*percent6);
    CGPoint rightTop7Point = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*percent1), squreCutRectY + squreCutRectH*percent7);
    
    [sawtoothPath moveToPoint:topCenterPoint];
    
    [sawtoothPath addLineToPoint:leftTop1Point];
    [sawtoothPath addLineToPoint:leftTop2Point];
    [sawtoothPath addLineToPoint:leftTop3Point];
    [sawtoothPath addLineToPoint:leftTop4Point];
    [sawtoothPath addLineToPoint:leftTop5Point];
    [sawtoothPath addLineToPoint:leftTop6Point];
    [sawtoothPath addLineToPoint:leftTop7Point];
    
    [sawtoothPath addLineToPoint:leftCenterPoint];
    
    [sawtoothPath addLineToPoint:leftBottom1Point];
    [sawtoothPath addLineToPoint:leftBottom2Point];
    [sawtoothPath addLineToPoint:leftBottom3Point];
    [sawtoothPath addLineToPoint:leftBottom4Point];
    [sawtoothPath addLineToPoint:leftBottom5Point];
    [sawtoothPath addLineToPoint:leftBottom6Point];
    [sawtoothPath addLineToPoint:leftBottom7Point];

    [sawtoothPath addLineToPoint:bottomCenterPoint];
    
    [sawtoothPath addLineToPoint:rightBottom7Point];
    [sawtoothPath addLineToPoint:rightBottom6Point];
    [sawtoothPath addLineToPoint:rightBottom5Point];
    [sawtoothPath addLineToPoint:rightBottom4Point];
    [sawtoothPath addLineToPoint:rightBottom3Point];
    [sawtoothPath addLineToPoint:rightBottom2Point];
    [sawtoothPath addLineToPoint:rightBottom1Point];
    
    [sawtoothPath addLineToPoint:rightCenterPoint];
    
    [sawtoothPath addLineToPoint:rightTop7Point];
    [sawtoothPath addLineToPoint:rightTop6Point];
    [sawtoothPath addLineToPoint:rightTop5Point];
    [sawtoothPath addLineToPoint:rightTop4Point];
    [sawtoothPath addLineToPoint:rightTop3Point];
    [sawtoothPath addLineToPoint:rightTop2Point];
    [sawtoothPath addLineToPoint:rightTop1Point];
    
    //线条的颜色
    UIColor *strokColor = [UIColor clearColor];
    [strokColor set];
    
    [sawtoothPath closePath]; //第N条线通过调用closePath方法得到的
    [sawtoothPath stroke]; //Draws line 根据坐标点连线
    
    return sawtoothPath;
}
//绘制心形路径
+(UIBezierPath *)heartPathWithInRect:(CGRect)rect{
    CGFloat squreCutRectX = rect.origin.x;
    CGFloat squreCutRectY = rect.origin.y;
    CGFloat squreCutRectW = rect.size.width;
    CGFloat squreCutRectH = rect.size.height;
    
    UIBezierPath *heartPatch = [[UIBezierPath alloc] init];
    
    
    CGPoint topCenterPoint = CGPointMake(squreCutRectX + squreCutRectW/2.0, squreCutRectY + squreCutRectH * 0.2);
    CGPoint leftPoint = CGPointMake(squreCutRectX,  squreCutRectY + squreCutRectH*0.32);
    CGPoint bottomCenterPoint = CGPointMake(squreCutRectX + squreCutRectW/2.0, squreCutRectY + squreCutRectH*0.9);
    CGPoint rightPoint = CGPointMake(squreCutRectX + squreCutRectW,squreCutRectY +squreCutRectH*0.32);
    
    
    [heartPatch moveToPoint:leftPoint];
    CGPoint controlPoint = CGPointMake(squreCutRectX + squreCutRectW/4.5, squreCutRectY - squreCutRectH*0.12);
    CGPoint controlPoint2 = CGPointMake(squreCutRectX, squreCutRectY + squreCutRectH*0.15 );
    
    [heartPatch addCurveToPoint:topCenterPoint controlPoint1:controlPoint2 controlPoint2:controlPoint];
    
    controlPoint = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW/4.5), squreCutRectY - squreCutRectH*0.12);
    controlPoint2 = CGPointMake(squreCutRectX + squreCutRectW, squreCutRectY + squreCutRectH*0.15 );
    
    [heartPatch addCurveToPoint:rightPoint controlPoint1:controlPoint controlPoint2:controlPoint2];
    
    controlPoint = CGPointMake(squreCutRectX + squreCutRectW, squreCutRectY + squreCutRectH*0.6);
    [heartPatch addQuadCurveToPoint:bottomCenterPoint controlPoint:controlPoint];
    
    
    controlPoint = CGPointMake(squreCutRectX , squreCutRectY + squreCutRectH*0.6);
    [heartPatch addQuadCurveToPoint:leftPoint controlPoint:controlPoint];
    
    
    
    //线条处理
    [heartPatch setLineCapStyle:kCGLineCapRound];
    
    //线条的颜色
    UIColor *strokColor = [UIColor clearColor];
    [strokColor set];
    
    //根据坐标点连线
    [heartPatch stroke];
    //clipToBounds 切掉多余的部分
    [heartPatch addClip];
    
    return heartPatch;
}
@end
