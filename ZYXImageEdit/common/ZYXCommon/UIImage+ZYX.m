//
//  UIImage+ZYX.m
//  TourNote
//
//  Created by 极客天地 on 17/1/17.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "UIImage+ZYX.h"

@implementation UIImage (ZYX)

+(UIImage*)convertToImageWithView:(UIView*)view{
    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(view.frame.size,NO,0.0);
    {
        [view.layer renderInContext: UIGraphicsGetCurrentContext()];
        image= UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    if(image != nil) {
        return image;
    }
    return nil;
}
+ (UIImage *)convertToImageWithScrollView:(UIScrollView *)scrollView{
    return [self convertToImageWithScrollView:scrollView WithScale:0.0];
}

+ (UIImage *)convertToImageWithScrollView:(UIScrollView *)scrollView WithScale:(CGFloat)scale{
    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize,NO,scale);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset= CGPointZero;
        scrollView.frame= CGRectMake(0, 0, scrollView.contentSize.width,scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image= UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset= savedContentOffset;
        scrollView.frame= savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if(image != nil) {
        return image;
    }
    return nil;
}

+(NSString*)base64StringWithImage:(UIImage*)image{
    NSData *data = UIImagePNGRepresentation(image);
    
    NSString * encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return encodedImageStr;
}
+(UIImage*)imageFromBase64String:(NSString*)string{
    NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}
- (UIImage *)scaleToSize:(CGSize)size{
//    NSData * data = UIImagePNGRepresentation(self);
//    NSLog(@"压缩前大小:%ld",data.length);

    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    
//    data = UIImagePNGRepresentation(scaledImage);
//    NSLog(@"压缩后大小:%ld",data.length);
    return scaledImage;
}
@end
