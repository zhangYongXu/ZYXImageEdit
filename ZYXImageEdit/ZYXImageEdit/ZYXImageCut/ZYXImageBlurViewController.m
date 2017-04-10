//
//  ZYXImageBlurViewController.m
//  TourNote
//
//  Created by 极客天地 on 2017/2/9.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "ZYXImageBlurViewController.h"

#import "GPUImageGaussianBlurFilter.h"
#import "GPUImagePicture.h"
#import "GPUImageGaussianSelectiveBlurFilter.h"

#import <Accelerate/Accelerate.h>

@interface ZYXImageBlurViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property(strong,nonatomic) UIImage * blurImage;
@property(strong,nonatomic) UIImage * willBlurImage;
@property(assign,nonatomic) CGSize  showScaleImageSize;
@end

@implementation ZYXImageBlurViewController
- (IBAction)closeBtnClicked:(id)sender {
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    
}
- (IBAction)completeBtnClicked:(id)sender {
    
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:NO];
        if(self.blurImageCompleteBlock){
            self.blurImageCompleteBlock(self.blurImage);
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            if(self.blurImageCompleteBlock){
                self.blurImageCompleteBlock(self.blurImage);
            }
        }];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController.navigationBar setHidden:YES];
    [self createRightItemWithTitle:@"保存相册"];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController.navigationBar setHidden:NO];
    
}

- (IBAction)saveToLocalBtnClicked:(id)sender {
    [self saveImageToPhotos:self.image];
}

- (void)saveImageToPhotos:(UIImage*)savedImage{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;

    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                 message:msg
                                                delegate:self
                                       cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initData{
    self.blurImage = self.image;
}
-(void)initUI{
    [self showImage:self.image WithShowSize:self.showImageSize];
    
    UIImage * scaleImage = [self getWillBlurImage];
    self.willBlurImage = scaleImage;

}
-(void)showImage:(UIImage*)image WithShowSize:(CGSize)showSize{
    CGRect imageViewFrame = CGRectMake(0, 0, 0, 0);
    imageViewFrame.size = showSize;
    
    self.imageView.frame = imageViewFrame;
    self.imageView.center = CGPointMake(SCREEN_WIDTH/2.0, (SCREEN_HEIGHT - 52)/2.0);
    
    self.imageView.image = image;
}

- (IBAction)sliderValueChanged:(UISlider*)sender {
    CGFloat value  = sender.value;
    UIImage * scaleImage = self.willBlurImage;

    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage * dImage = [self blurryImage:scaleImage withBlurLevel:value];
        dImage = [self addImage:dImage ToImage:self.image];
       //dispatch_async(dispatch_get_main_queue(), ^{
           self.blurImage = dImage;
           [self showImage:self.blurImage WithShowSize:self.showScaleImageSize];
       //});
    //});
}



- (UIImage *) addImage:(UIImage*)iamge ToImage:(UIImage *)img{
    
    CGSize size = CGSizeMake(iamge.size.width, iamge.size.height);
    UIGraphicsBeginImageContext(size);
    
    CGPoint pointImg1 = CGPointMake(0,0);
    [iamge drawAtPoint:pointImg1];
    
    CGPoint pointImg2 = CGPointMake((iamge.size.width - img.size.width)/2.0, (iamge.size.height - img.size.height)/2.0);
    [img drawAtPoint: pointImg2];
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}
-(UIImage *)getWillBlurImage{
    self.showScaleImageSize = CGSizeMake(self.showImageSize.width + 30, self.showImageSize.height + 30);
    CGFloat percent = (self.showScaleImageSize.width - self.showImageSize.width)/self.showScaleImageSize.width;
    
    UIImage * image = [self scaleBoaderWithImage:self.image ExtentPercent:percent];
    return image;
}
// 添加图片边界留白
-(UIImage*)scaleBoaderWithImage:(UIImage*)image ExtentPercent:(CGFloat)extentPercent{
    
    CGFloat width = image.size.width * (1 + extentPercent);
    CGFloat height = image.size.height * (1 + extentPercent);
    CGSize scaleSize = CGSizeMake(width,height);
    //开始绘制图片
    UIGraphicsBeginImageContext(scaleSize);
    //UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
//    CGContextAddRect(contextRef, CGRectMake(0, 0, scaleSize.width, scaleSize.height));
//    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithHex:0x45fa45 alpha:0.4].CGColor);
//    CGContextFillPath(contextRef);
    
    //坐标系转换
    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
    CGContextTranslateCTM(contextRef, 0, image.size.height);
    CGContextScaleCTM(contextRef, image.scale, -image.scale);
    CGRect drawRect = CGRectMake((width - image.size.width)/2.0, -(height - image.size.height)/2.0, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, drawRect, [image CGImage]);
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    
    //转成png格式 会保留透明
    NSData * data = UIImagePNGRepresentation(destImg);
    UIImage * dImage = [UIImage imageWithData:data];
    
    //return destImg;
    return dImage;
}



- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
{
    if (image==nil)
    {
        NSLog(@"error:为图片添加模糊效果时，未能获取原始图片");
        return nil;
    }
    //模糊度,
    if (blur < 0.025f) {
        blur = 0.025f;
    } else if (blur > 1.0f) {
        blur = 1.0f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 120);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    //CGColorSpaceRelease(colorSpace);   //多余的释放
    CGImageRelease(imageRef);
    return returnImage;
}

@end
