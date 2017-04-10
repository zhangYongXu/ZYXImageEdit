//
//  ViewController.m
//  ZYXImageEdit
//
//  Created by 极客天地 on 2017/4/10.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "ViewController.h"

#import "ZYXImageEditViewController.h"
#import "GWRootNavigationViewController.h"

#import "ZYXImagePickerManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectPhotoClicked:(id)sender {
    [self selectImage];
}

-(void)selectImage{
    
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:@"选择图片" preferredStyle:UIAlertControllerStyleActionSheet];
    // 响应方法-取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    // 响应方法-相册
    UIAlertAction *takeAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showImagePickerVCWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    // 响应方法-拍照
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showImagePickerVCWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    // 添加响应方式
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:takeAction];
    [actionSheetController addAction:photoAction];
    // 显示
    [APPDelegate.window.rootViewController presentViewController:actionSheetController animated:YES completion:nil];
}
- (void)showImagePickerVCWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    [ZYXImagePickerManager showImagePickerWithSorceType:sourceType CompleteBlock:^(UIImage *image) {
        [self didSelectedImage:image];
    }];
}
- (void)didSelectedImage:(UIImage*)image{
    ZYXImageEditViewController * imageEditVc = [[ZYXImageEditViewController alloc] init];
    imageEditVc.image = [image fixOrientation];
    imageEditVc.hidesBottomBarWhenPushed = YES;
    [imageEditVc setImageEditCompleteBlock:^(UIImage *editedImage) {
        self.showImage.image = editedImage;
    }];
    
    GWRootNavigationViewController * nvc = [[GWRootNavigationViewController navitionVCArray] lastObject];
    [nvc pushViewController:imageEditVc animated:YES];
}

@end
