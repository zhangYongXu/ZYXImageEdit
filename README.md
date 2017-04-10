# ZYXImageEdit
图片不同形状的裁剪，和自由形状裁剪，图片边缘模糊。图片添加相框。
使用简单：
ZYXImageEditViewController * imageEditVc = [[ZYXImageEditViewController alloc] init];
    imageEditVc.image = [image fixOrientation];
    imageEditVc.hidesBottomBarWhenPushed = YES;
    //编辑完成后回调
    [imageEditVc setImageEditCompleteBlock:^(UIImage *editedImage) {
        //editedImage编辑后图片
        self.showImage.image = editedImage;
    }];
    
    GWRootNavigationViewController * nvc = [[GWRootNavigationViewController navitionVCArray] lastObject];
    [nvc pushViewController:imageEditVc animated:YES];
