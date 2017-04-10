//
//  ZYXImageBlurViewController.h
//  TourNote
//
//  Created by 极客天地 on 2017/2/9.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "GWRootViewController.h"
typedef void (^ZYXBlurImageCompleteBlock)(UIImage * blurImage);
@interface ZYXImageBlurViewController : GWRootViewController
@property(assign,nonatomic) CGSize  showImageSize;
@property(strong,nonatomic) UIImage * image;

@property(copy,nonatomic)ZYXBlurImageCompleteBlock blurImageCompleteBlock;
-(void)setBlurImageCompleteBlock:(ZYXBlurImageCompleteBlock)blurImageCompleteBlock;
@end
