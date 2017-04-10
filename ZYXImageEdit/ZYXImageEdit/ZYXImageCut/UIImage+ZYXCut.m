//
//  UIImage+ZYXCut.m
//  TourNote
//
//  Created by 极客天地 on 2017/2/15.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "UIImage+ZYXCut.h"
#import "UIBezierPath+ZYXCut.h"

@implementation UIImage (ZYXCut)

//矩形图片
-(UIImage*)squareClipInRect:(CGRect)rect{
    UIBezierPath * squarePath = [UIBezierPath bezierPathWithRect:rect];
    UIImage * image  = [self clipWithPath:squarePath InRect:rect];
    return image;
}

//三角形图片
-(UIImage*)triangleClipInRect:(CGRect)rect{
    UIBezierPath * trianglePath = [UIBezierPath trianglePathWithInRect:rect];
    UIImage * image  = [self clipWithPath:trianglePath InRect:rect];
    return image;
}

//宝石形图片
-(UIImage*)jewelryClipInRect:(CGRect)rect{
    UIBezierPath * jewelryPath = [UIBezierPath jewelryPathWithInRect:rect];
    UIImage * image  = [self clipWithPath:jewelryPath InRect:rect];
    return image;
}
//五角星图片
-(UIImage*)fivePointStarClipInRect:(CGRect)rect{
    UIBezierPath * fivePointStarPath = [UIBezierPath fivePointStarPathWithInRect:rect];
    UIImage * image  = [self clipWithPath:fivePointStarPath InRect:rect];
    return image;
}

//椭圆图片
-(UIImage*)ellipseClipInRect:(CGRect)rect{
    UIBezierPath * ellipsePath = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIImage * image  = [self clipWithPath:ellipsePath InRect:rect];
    return image;
}
//椭圆锯齿形图片
-(UIImage*)sawtoothClipInRect:(CGRect)rect{
    UIBezierPath * sawtoothPath = [UIBezierPath sawtoothPathWithInRect:rect];
    UIImage * image  = [self clipWithPath:sawtoothPath InRect:rect];
    return image;
}
//心形图片
-(UIImage*)heartClipInRect:(CGRect)rect{
    UIBezierPath * heartPath = [UIBezierPath heartPathWithInRect:rect];
    UIImage * image  = [self clipWithPath:heartPath InRect:rect];
    return image;
}
// 根据path在rect范围内切割图片
-(UIImage*)clipWithPath:(UIBezierPath*)path InRect:(CGRect)rect{
    UIImage * image = self;
    
    //开始绘制图片
    UIGraphicsBeginImageContext(image.size);
    //UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    ////绘制Clip区域
    CGRect myRect = rect;

    
    UIBezierPath * clipPath = path;
    CGContextAddPath(contextRef, clipPath.CGPath);
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    //坐标系转换
    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
    CGContextTranslateCTM(contextRef, 0, image.size.height);
    CGContextScaleCTM(contextRef, image.scale, -image.scale);
    CGRect drawRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, drawRect, [image CGImage]);
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    destImg = [destImg clipImageWithRect:myRect];
    
    //转成png格式 会保留透明
    NSData * data = UIImagePNGRepresentation(destImg);
    UIImage * dImage = [UIImage imageWithData:data];
    
    //return destImg;
    return dImage;
}


/* 根据rect裁剪图片 */
-(UIImage *)clipImageWithRect:(CGRect)rect{
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



#warning  ZYXImageCutViewController 中弃用了
/*
/* 裁剪图片 */
/*
-(UIImage *)getSmallImage
{
    UIImage * originalImage = self.imageView.image;
    CGFloat width = self.imageView.width;
    CGFloat rationScale = (originalImage.size.width  / width /1.0);
    
    CGRect currentSquareCutRect = self.currentSquareFrame;
    
    CGFloat origX = (currentSquareCutRect.origin.x - self.imageView.frame.origin.x) * rationScale;
    CGFloat origY = (currentSquareCutRect.origin.y - self.imageView.frame.origin.y) * rationScale;
    CGFloat oriWidth = currentSquareCutRect.size.width * rationScale;
    CGFloat oriHeight = currentSquareCutRect.size.height * rationScale;
    
    CGRect myRect = CGRectMake(origX, origY, oriWidth, oriHeight);
    
    
   
     UIImage * oringalClipImage = nil;
     if(self.clipType == ClipTypeSquare){
         oringalClipImage = [self squareClipImage:originalImage InRect:myRect];
     }else if(self.clipType == ClipTypeTriangle){
         oringalClipImage = [self triangleClipImage:originalImage InRect:myRect];
     }else if(self.clipType == ClipTypeJewelry){
         oringalClipImage = [self jewelryClipImage:originalImage InRect:myRect];
     }else if(self.clipType == ClipTypeFivePointStar){
         oringalClipImage = [self fivePointStarClipImage:originalImage InRect:myRect];
     }else if(self.clipType == ClipTypeEllipse){
         oringalClipImage = [self ellipseClipImage:originalImage InRect:myRect];
     }else if(self.clipType == ClipTypeHeart){
         oringalClipImage = [self heartClipImage:originalImage InRect:myRect];
     }
     
     
     CGImageRef  imageRef = CGImageCreateWithImageInRect(oringalClipImage.CGImage, myRect);
     UIGraphicsBeginImageContext(myRect.size);
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextDrawImage(context, myRect, imageRef);
     UIImage * clipImage = [UIImage imageWithCGImage:imageRef];
     UIGraphicsEndImageContext();
     
     return clipImage;

}
*/
#warning 弃用了
/*  ///
//矩形图片
-(UIImage*)squareClipImage:(UIImage *)image InRect:(CGRect)rect{
    
    //开始绘制图片
    UIGraphicsBeginImageContext(image.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    ////绘制Clip区域
    CGRect myRect = rect;
    
    CGFloat squreCutRectX = myRect.origin.x;
    CGFloat squreCutRectY = myRect.origin.y;
    CGFloat squreCutRectW = myRect.size.width;
    CGFloat squreCutRectH = myRect.size.height;
    
    CGPoint leftTopPoint = CGPointMake(squreCutRectX, squreCutRectY);
    CGPoint leftBottomPoint = CGPointMake(squreCutRectX, squreCutRectY+squreCutRectH);
    CGPoint rightBottomPoint = CGPointMake(squreCutRectX+squreCutRectW, squreCutRectY+squreCutRectH);
    CGPoint rightTopPoint = CGPointMake(squreCutRectX + squreCutRectW, squreCutRectY);
    
    CGPoint sPoints[4];//坐标点
    sPoints[0] = leftTopPoint;//坐标1
    sPoints[1] = leftBottomPoint;//坐标2
    sPoints[2] = rightBottomPoint;//坐标3
    sPoints[3] = rightTopPoint;//坐标4
    
    CGContextAddLines(contextRef, sPoints, 4);//添加线
    
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    //坐标系转换
    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
    CGContextTranslateCTM(contextRef, 0, image.size.height);
    CGContextScaleCTM(contextRef, image.scale, -image.scale);
    CGRect drawRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, drawRect, [image CGImage]);
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImg;
}

//三角形图片
-(UIImage*)triangleClipImage:(UIImage *)image InRect:(CGRect)rect{
    
    //开始绘制图片
    UIGraphicsBeginImageContext(image.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    ////绘制Clip区域
    CGRect myRect = rect;
    
    CGFloat squreCutRectX = myRect.origin.x;
    CGFloat squreCutRectY = myRect.origin.y;
    CGFloat squreCutRectW = myRect.size.width;
    CGFloat squreCutRectH = myRect.size.height;
    
    CGPoint topCenterPoint = CGPointMake(squreCutRectX+squreCutRectW/2.0, squreCutRectY);
    CGPoint leftBottomPoint = CGPointMake(squreCutRectX, squreCutRectY+squreCutRectH);
    CGPoint rightBottomPoint = CGPointMake(squreCutRectX+squreCutRectW, squreCutRectY+squreCutRectH);
    
    CGPoint sPoints[3];//坐标点
    sPoints[0] = topCenterPoint;//坐标1
    sPoints[1] = leftBottomPoint;//坐标2
    sPoints[2] = rightBottomPoint;//坐标3
    
    CGContextAddLines(contextRef, sPoints, 3);//添加线
    
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    //坐标系转换
    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
    CGContextTranslateCTM(contextRef, 0, image.size.height);
    CGContextScaleCTM(contextRef, image.scale, -image.scale);
    CGRect drawRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, drawRect, [image CGImage]);
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImg;
}

//宝石形图片
-(UIImage*)jewelryClipImage:(UIImage *)image InRect:(CGRect)rect{
    //开始绘制图片
    UIGraphicsBeginImageContext(image.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    ////绘制Clip区域
    CGRect myRect = rect;
    
    CGFloat squreCutRectX = myRect.origin.x;
    CGFloat squreCutRectY = myRect.origin.y;
    CGFloat squreCutRectW = myRect.size.width;
    CGFloat squreCutRectH = myRect.size.height;
    
    CGPoint leftTopPoint = CGPointMake(squreCutRectX + squreCutRectW*0.28, squreCutRectY + squreCutRectH*0.12);
    CGPoint rightTopPoint = CGPointMake(squreCutRectX + (squreCutRectW - squreCutRectW*0.28), squreCutRectY + squreCutRectH*0.12);
    
    CGPoint leftPoint = CGPointMake(squreCutRectX,squreCutRectY + squreCutRectH*0.4);
    CGPoint rightPoint = CGPointMake(squreCutRectX + squreCutRectW,squreCutRectY + squreCutRectH*0.4);
    CGPoint bottomCenterPoint = CGPointMake(squreCutRectX + squreCutRectW/2.0,squreCutRectY + (squreCutRectH - squreCutRectH*0.12));
    
    CGPoint sPoints[5];//坐标点
    sPoints[0] = leftTopPoint;//坐标1
    sPoints[1] = leftPoint;//坐标2
    sPoints[2] = bottomCenterPoint;//坐标3
    sPoints[3] = rightPoint;//坐标4
    sPoints[4] = rightTopPoint;//坐标4
    CGContextAddLines(contextRef, sPoints, 5);//添加线
    
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    //坐标系转换
    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
    CGContextTranslateCTM(contextRef, 0, image.size.height);
    CGContextScaleCTM(contextRef, image.scale, -image.scale);
    CGRect drawRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, drawRect, [image CGImage]);
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImg;
}
//五角星图片
-(UIImage*)fivePointStarClipImage:(UIImage *)image InRect:(CGRect)rect{
    //开始绘制图片
    UIGraphicsBeginImageContext(image.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    ////绘制Clip区域
    CGRect myRect = rect;
    
    CGFloat squreCutRectX = myRect.origin.x;
    CGFloat squreCutRectY = myRect.origin.y;
    CGFloat squreCutRectW = myRect.size.width;
    CGFloat squreCutRectH = myRect.size.height;
    
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
    
    CGPoint sPoints[10];//坐标点
    sPoints[0] = topCenterPonint;//坐标1
    
    sPoints[1] = left1Point;//坐标2
    sPoints[2] = left2Point;//坐标3
    sPoints[3] = left3Point;//坐标4
    sPoints[4] = left4Point;//坐标5
    
    sPoints[5] = bottomCenterPonint;//坐标6
    
    sPoints[6] = right4Point;//坐标7
    sPoints[7] = right3Point;//坐标8
    sPoints[8] = right2Point;//坐标9
    sPoints[9] = right1Point;//坐标10
    CGContextAddLines(contextRef, sPoints, 10);//添加线
    
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    //坐标系转换
    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
    CGContextTranslateCTM(contextRef, 0, image.size.height);
    CGContextScaleCTM(contextRef, image.scale, -image.scale);
    CGRect drawRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, drawRect, [image CGImage]);
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImg;
}

//椭圆图片
-(UIImage*)ellipseClipImage:(UIImage *)image InRect:(CGRect)rect{
    //开始绘制图片
    UIGraphicsBeginImageContext(image.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    ////绘制Clip区域
    CGRect myRect = rect;
    CGContextAddEllipseInRect(contextRef, myRect); //椭圆
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    //坐标系转换
    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
    CGContextTranslateCTM(contextRef, 0, image.size.height);
    CGContextScaleCTM(contextRef, image.scale, -image.scale);
    CGRect drawRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, drawRect, [image CGImage]);
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImg;
}

//心形图片
-(UIImage*)heartClipImage:(UIImage *)image InRect:(CGRect)rect{
    //开始绘制图片
    UIGraphicsBeginImageContext(image.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    ////绘制Clip区域
    CGRect myRect = rect;
    UIBezierPath * heartPath = [UIBezierPath heartPathWithInRect:myRect];
    CGContextAddPath(contextRef, heartPath.CGPath);
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    //坐标系转换
    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
    CGContextTranslateCTM(contextRef, 0, image.size.height);
    CGContextScaleCTM(contextRef, image.scale, -image.scale);
    CGRect drawRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, drawRect, [image CGImage]);
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImg;
}
*/


@end
