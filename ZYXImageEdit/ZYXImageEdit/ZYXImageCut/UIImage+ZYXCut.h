//
//  UIImage+ZYXCut.h
//  TourNote
//
//  Created by 极客天地 on 2017/2/15.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZYXCut)
//矩形图片
-(UIImage*)squareClipInRect:(CGRect)rect;
//三角形图片
-(UIImage*)triangleClipInRect:(CGRect)rect;
//宝石形图片
-(UIImage*)jewelryClipInRect:(CGRect)rect;
//五角星图片
-(UIImage*)fivePointStarClipInRect:(CGRect)rect;
//椭圆图片
-(UIImage*)ellipseClipInRect:(CGRect)rect;
//椭圆锯齿形图片
-(UIImage*)sawtoothClipInRect:(CGRect)rect;
//心形图片
-(UIImage*)heartClipInRect:(CGRect)rect;

-(UIImage*)clipWithPath:(UIBezierPath*)path InRect:(CGRect)rect;
@end
