//
//  ZYXImageCutViewController.h
//  TourNote
//
//  Created by 极客天地 on 2017/2/8.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "GWRootViewController.h"
typedef void (^ZYXCutImageCompleteBlock)(UIImage * cuttedImage);
@interface ZYXImageCutViewController : GWRootViewController
@property(strong,nonatomic) UIImage * image;

@property(copy,nonatomic)ZYXCutImageCompleteBlock cutImageCompleteBlock;
-(void)setCutImageCompleteBlock:(ZYXCutImageCompleteBlock)cutImageCompleteBlock;
@end
