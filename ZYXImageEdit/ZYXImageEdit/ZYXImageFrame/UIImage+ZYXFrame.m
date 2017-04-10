
//
//  UIImage+ZYXFrame.m
//  TourNote
//
//  Created by 极客天地 on 2017/3/8.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "UIImage+ZYXFrame.h"
#import "YXFileOrDirItemModel.h"

@implementation UIImage (ZYXFrame)
//矩形图片
-(UIImage*)frameSquareClipInRect:(CGRect)rect{
    UIBezierPath * squarePath = [UIBezierPath bezierPathWithRect:rect];
    UIImage * image  = [self frameClipWithPath:squarePath InRect:rect];
    return image;
}
// 根据path在rect范围内切割图片
-(UIImage*)frameClipWithPath:(UIBezierPath*)path InRect:(CGRect)rect{
    UIImage * image = self;
    CGSize contentSize = CGSizeMake(MAX(rect.size.width,image.size.width), MAX(rect.size.height, image.size.height));
    
    //开始绘制图片
    //UIGraphicsBeginImageContext(image.size);
    UIGraphicsBeginImageContext(contentSize);

    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    
    UIBezierPath * clipPath = path;
    CGContextAddPath(contextRef, clipPath.CGPath);
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    //坐标系转换
    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
    CGContextTranslateCTM(contextRef, 0, image.size.height);
    CGContextScaleCTM(contextRef, image.scale, -image.scale);
    //CGRect drawRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGFloat dx = rect.origin.x<0?-rect.origin.x:0;
    CGFloat dy = rect.origin.y<0?rect.origin.y:0;
    CGRect drawRect = CGRectMake(dx, dy, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, drawRect, [image CGImage]);
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat x = rect.origin.x>0?rect.origin.x:0;
    CGFloat y = rect.origin.y>0?rect.origin.y:0;
    CGRect newRect = CGRectMake(x, y, rect.size.width, rect.size.height);
    destImg = [destImg frameClipImageWithRect:newRect];
    
    //转成png格式 会保留透明
    NSData * data = UIImagePNGRepresentation(destImg);
    UIImage * dImage = [UIImage imageWithData:data];
    
    //return destImg;
    return dImage;
}


/* 根据rect裁剪图片 */
-(UIImage *)frameClipImageWithRect:(CGRect)rect{
    UIImage * image  = self;
    CGRect myRect = rect;
    CGImageRef  imageRef = CGImageCreateWithImageInRect(image.CGImage, myRect);
    UIGraphicsBeginImageContext(myRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myRect, imageRef);
    UIImage * clipImage = [UIImage imageWithCGImage:imageRef];
    UIGraphicsEndImageContext();
    return clipImage;
}

-(UIImage*)frameAddImage:(UIImage*)topImage{
    UIImage * image = self;
    
    //开始绘制图片
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //坐标系转换
    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
    CGContextTranslateCTM(contextRef, 0, image.size.height);
    CGContextScaleCTM(contextRef, image.scale, -image.scale);
    CGRect drawRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, drawRect, [image CGImage]);
    CGContextDrawImage(contextRef, drawRect, [topImage CGImage]);
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect myRect = drawRect;
    destImg = [destImg frameClipImageWithRect:myRect];
    
    //转成png格式 会保留透明
    NSData * data = UIImagePNGRepresentation(destImg);
    UIImage * dImage = [UIImage imageWithData:data];
    
    return dImage;
};


@end
