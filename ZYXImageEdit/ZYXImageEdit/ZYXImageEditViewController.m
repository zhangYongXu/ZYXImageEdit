//
//  ZYXImageEditViewController.m
//  TourNote
//
//  Created by 极客天地 on 2017/3/7.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "ZYXImageEditViewController.h"

#import "ZYXImageFrameViewController.h"
#import "ZYXImageCutViewController.h"

@interface ZYXImageEditViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ZYXImageEditViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑图片";
    [self createRightItemWithTitle:@"完成"];
}
-(void)rightItemClickedHandle:(UIBarButtonItem *)sender{
    
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
        if(self.imageEditCompleteBlock){
            self.imageEditCompleteBlock(self.image);
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            if(self.imageEditCompleteBlock){
                self.imageEditCompleteBlock(self.image);
            }
        }];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.top = 20;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)initData{
    
}
-(void)initUI{
    [self showOriginalImage];
}
-(void)showOriginalImage{
    self.imageView.image = self.image;
    if(nil == self.image){
        return;
    }
    CGFloat imageViewWidth = 0;
    CGFloat imageViewHeight = 0;
    CGFloat imageViewLeft = 0;
    CGFloat imageViewTop = 0;
    if(self.image.size.width >= self.image.size.height){
        imageViewWidth = self.contentView.width;
        imageViewHeight = imageViewWidth/self.image.size.width * self.image.size.height;
    }else{
        imageViewHeight = self.contentView.height;
        imageViewWidth = imageViewHeight/self.image.size.height * self.image.size.width;
    }
    imageViewLeft = (self.contentView.width - imageViewWidth)/2.0;
    imageViewTop = (self.contentView.height - imageViewHeight)/2.0;
    
    CGRect imageViewFrame = CGRectMake(imageViewLeft, imageViewTop, imageViewWidth, imageViewHeight);
    self.imageView.frame = imageViewFrame;
}
- (IBAction)addImageFrameBtnClicked:(id)sender {
    ZYXImageFrameViewController * imageFrameVC = [[ZYXImageFrameViewController alloc] init];
    imageFrameVC.image = self.image;
    [imageFrameVC setImageFrameCompleteBlock:^(UIImage *frameImage) {
        
        if(self.navigationController){
            [self.navigationController popViewControllerAnimated:YES];
            if(self.imageEditCompleteBlock){
                self.imageEditCompleteBlock(frameImage);
            }
        }else{
            [self dismissViewControllerAnimated:NO completion:^{
                if(self.imageEditCompleteBlock){
                    self.imageEditCompleteBlock(frameImage);
                }
            }];
        }
    }];
    if(self.navigationController){
        [self.navigationController pushViewController:imageFrameVC animated:YES];
    }else{
        [self presentViewController:imageFrameVC animated:YES completion:^{
            
        }];
    }
    
    
}
- (IBAction)imageCutBtnClicked:(id)sender {
    ZYXImageCutViewController * imageCutVC = [[ZYXImageCutViewController alloc] init];
    imageCutVC.image = self.image;
    [imageCutVC setCutImageCompleteBlock:^(UIImage *cuttedImage) {
        if(self.imageEditCompleteBlock){
            self.imageEditCompleteBlock(cuttedImage);
        }
        if(self.navigationController){
            [self.navigationController popViewControllerAnimated:YES];
            if(self.imageEditCompleteBlock){
                self.imageEditCompleteBlock(cuttedImage);
            }
        }else{
            [self dismissViewControllerAnimated:NO completion:^{
                if(self.imageEditCompleteBlock){
                    self.imageEditCompleteBlock(cuttedImage);
                }
            }];
        }
    }];
    if(self.navigationController){
        [self.navigationController pushViewController:imageCutVC animated:YES];
    }else{
        [self presentViewController:imageCutVC animated:YES completion:^{
                
        }];
    }
}


@end
