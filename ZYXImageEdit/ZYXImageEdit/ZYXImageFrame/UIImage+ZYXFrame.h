//
//  UIImage+ZYXFrame.h
//  TourNote
//
//  Created by 极客天地 on 2017/3/8.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZYXFrame)
//矩形图片
-(UIImage*)frameSquareClipInRect:(CGRect)rect;
-(UIImage*)frameAddImage:(UIImage*)topImage;

@end
