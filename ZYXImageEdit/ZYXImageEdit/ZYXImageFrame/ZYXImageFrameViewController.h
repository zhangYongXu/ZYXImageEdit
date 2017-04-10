//
//  ZYXImageFrameViewController.h
//  TourNote
//
//  Created by 极客天地 on 2017/3/7.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "GWRootViewController.h"
typedef void (^ZYXImageFrameCompleteBlock)(UIImage * frameImage);
@interface ZYXImageFrameViewController : GWRootViewController
@property(strong,nonatomic) UIImage * image;

@property(strong,nonatomic)ZYXImageFrameCompleteBlock imageFrameCompleteBlock;
-(void)setImageFrameCompleteBlock:(ZYXImageFrameCompleteBlock)imageFrameCompleteBlock;
@end
