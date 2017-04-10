//
//  UIImage+ZYX.h
//  TourNote
//
//  Created by 极客天地 on 17/1/17.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZYX)
+(UIImage*)convertToImageWithView:(UIView*)view;
+(UIImage *)convertToImageWithScrollView:(UIScrollView *)scrollView;
+(UIImage *)convertToImageWithScrollView:(UIScrollView *)scrollView WithScale:(CGFloat)scale;

+(NSString*)base64StringWithImage:(UIImage*)image;
+(UIImage*)imageFromBase64String:(NSString*)string;
//按尺寸压缩
- (UIImage *)scaleToSize:(CGSize)size;

@end
