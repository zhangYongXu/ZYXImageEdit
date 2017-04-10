//
//  ZYXImagePickerManager.m
//  TourNote
//
//  Created by 极客天地 on 2017/3/8.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "ZYXImagePickerManager.h"
static ZYXImagePickerManager * shareIntance = nil;
@interface ZYXImagePickerManager()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(copy,nonatomic)ZYXImagePickerCompleteBlock imagePickerCompleteBlock;
@end
@implementation ZYXImagePickerManager

+(ZYXImagePickerManager *)shareInstance{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareIntance = [[ZYXImagePickerManager alloc] init];
    });
    return shareIntance;
}
+(void)showImagePickerWithSorceType:(UIImagePickerControllerSourceType)sourceType CompleteBlock:(ZYXImagePickerCompleteBlock)completeBlock{
    ZYXImagePickerManager * imagePicker = [ZYXImagePickerManager shareInstance];
    imagePicker.imagePickerCompleteBlock = completeBlock;
    [imagePicker showImagePickerWithSorceType:sourceType];
}
-(void)showImagePickerWithSorceType:(UIImagePickerControllerSourceType)sourceType{
    if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        if(![self judgePhotosRight]){
            return;
        }
    }else if (sourceType == UIImagePickerControllerSourceTypeCamera){
        if(![self judgeCameraRight]){
            return;
        }
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = NO;//设置可编辑
    picker.sourceType = sourceType;
    [APPDelegate.window.rootViewController presentViewController:picker animated:YES completion:^{}];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if(self.imagePickerCompleteBlock){
        self.imagePickerCompleteBlock(image);
    }
}

#pragma mark 判断相机权限
- (BOOL)judgeCameraRight{
    return [ZYXSystemRightMonitor judgeCameraRightAndShowTipAlert];
}
#pragma mark 判断相册权限
- (BOOL)judgePhotosRight {
    return [ZYXSystemRightMonitor judgePhotosRightAndShowTipAlert];
}
@end
