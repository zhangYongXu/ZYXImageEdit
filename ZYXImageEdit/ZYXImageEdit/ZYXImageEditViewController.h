//
//  ZYXImageEditViewController.h
//  TourNote
//
//  Created by 极客天地 on 2017/3/7.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "GWRootViewController.h"
typedef void (^ZYXImageEditCompleteBlock)(UIImage * editedImage);
@interface ZYXImageEditViewController : GWRootViewController
@property(strong,nonatomic) UIImage * image;

@property(strong,nonatomic)ZYXImageEditCompleteBlock imageEditCompleteBlock;
-(void)setImageEditCompleteBlock:(ZYXImageEditCompleteBlock)imageEditCompleteBlock;
@end
