//
//  ZYXImageFrameViewController.m
//  TourNote
//
//  Created by 极客天地 on 2017/3/7.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "ZYXImageFrameViewController.h"

#import "ZYXImageFrameViewModel.h"
#import "ZYXImageFrameCell.h"

#import "UIImage+ZYXFrame.h"


@interface ZYXImageFrameViewController ()<UICollectionViewDelegate,
                                            UICollectionViewDataSource,
                                            UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic)ZYXImageFrameViewModel * imageFrameViewModel;
@property (strong,nonatomic)NSMutableArray<ZYXImageFrameModel*> * dataArray;


@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageFrameImageView;

@property (strong,nonatomic) ZYXImageFrameModel * selectedImageModel;


@end

@implementation ZYXImageFrameViewController
-(ZYXImageFrameViewModel *)imageFrameViewModel{
    if(nil == _imageFrameViewModel){
        _imageFrameViewModel = [[ZYXImageFrameViewModel alloc] init];
    }
    return _imageFrameViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController.navigationBar setHidden:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController.navigationBar setHidden:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)initData{
    self.dataArray = self.imageFrameViewModel.simpleImageFrameModelArray;
}
-(void)initUI{
    self.scrollView.minimumZoomScale = 0.5;   //最小倍数
    self.scrollView.maximumZoomScale = 3.0;  //最大倍数
    self.scrollView.contentSize = CGSizeMake(self.image.size.width,self.image.size.height); //两倍大小图片
    self.scrollView.decelerationRate = 0.0f; //减速速率
    self.scrollView.zoomScale = 1.0;
    
    [self.collectionView registerNib:[ZYXImageFrameCell cellNib] forCellWithReuseIdentifier:[ZYXImageFrameCell reuseIdentifier]];
    
    UIColor * color = [UIColor colorWithHex:0xe5e5e5];
    CGFloat lineWidth = 1;
    [self.collectionView drawBorderSolidLineWithPosition:BorderLinePositionTop Color:color Width:lineWidth];
    [self.collectionView drawBorderSolidLineWithPosition:BorderLinePositionBottom Color:color Width:lineWidth];
    
    self.selectedImageModel = self.dataArray.firstObject;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    
    UIImage * image = [UIImage imageWithContentsOfFile:self.selectedImageModel.imageLocalPath];
    [self showImage:image inImageView:self.imageFrameImageView ViewSize:self.contentView.frame.size];
    
    [self showImage:self.image inImageView:self.imageView ViewSize:self.imageFrameImageView.frame.size];
    self.scrollView.frame = self.imageFrameImageView.frame;
    self.scrollView.contentSize = CGSizeMake(self.imageView.width*self.scrollView.maximumZoomScale, self.imageView.height*self.scrollView.maximumZoomScale);
}

-(void)showImage:(UIImage*)image inImageView:(UIImageView*)imageView ViewSize:(CGSize)viewSize{
    imageView.image = image;
    if(nil == image){
        return;
    }
    CGFloat imageViewWidth = 0;
    CGFloat imageViewHeight = 0;
    CGFloat imageViewLeft = 0;
    CGFloat imageViewTop = 0;
    if(image.size.width >= image.size.height){
        imageViewWidth = viewSize.width;
        imageViewHeight = imageViewWidth/image.size.width * image.size.height;
    }else{
        imageViewHeight = viewSize.height;
        imageViewWidth = imageViewHeight/image.size.height * image.size.width;
    }
    imageViewLeft = (viewSize.width - imageViewWidth)/2.0;
    imageViewTop = (viewSize.height - imageViewHeight)/2.0;
    
    CGRect imageViewFrame = CGRectMake(imageViewLeft, imageViewTop, imageViewWidth, imageViewHeight);
    imageView.frame = imageViewFrame;
}

#pragma mark UICollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZYXImageFrameCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:[ZYXImageFrameCell reuseIdentifier] forIndexPath:indexPath];
    
    ZYXImageFrameModel * imageFrameModel  = self.dataArray[indexPath.item];
    [cell setCellWithModel:imageFrameModel];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = 60;
    CGFloat height = 95;
    return CGSizeMake(width, height);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZYXImageFrameCell * cell  = (ZYXImageFrameCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    UIImage * image  = cell.showFrameImage;
    [self showImage:image inImageView:self.imageFrameImageView ViewSize:self.contentView.frame.size];
    
    
}
- (IBAction)bottomBtnClicked:(UIButton*)sender {
    sender.selected = !sender.selected;
    if(sender.selected){
        self.dataArray = self.imageFrameViewModel.goodImageFrameModelArray;
    }else{
        self.dataArray = self.imageFrameViewModel.simpleImageFrameModelArray;
    }
    [self.collectionView reloadData];
}

#pragma mark - scrollView delegate
//缩放过程中的图像
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if(scrollView != self.scrollView){
        return nil;
    }
    return self.imageView;
}

//缩放结束
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    if(scrollView != self.scrollView){
        return;
    }
    NSLog(@"缩放的比例:%f",scale);
}

//缩放中
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView != self.scrollView){
        return;
    }
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                          scrollView.contentSize.height * 0.5 + offsetY);
    NSLog(@"缩放中");
}
- (IBAction)closeBtnClicked:(id)sender {
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (IBAction)completeBtnClicked:(id)sender {
    UIImage * frmaeImage = self.imageFrameImageView.image;
    UIImage * image = [self handleImage];
    image = [image frameAddImage:frmaeImage];
    self.imageFrameImageView.image = image;
    //self.imageView.frame = self.imageFrameImageView.frame;
    
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:NO];
        if(self.imageFrameCompleteBlock){
            self.imageFrameCompleteBlock(image);
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            if(self.imageFrameCompleteBlock){
                self.imageFrameCompleteBlock(image);
            }
        }];
    }
}
- (UIImage *)handleImage{
    UIImage * originalImage = self.image;
    CGFloat width = self.imageView.width;
    CGFloat rationScale = (originalImage.size.width  / width /1.0);
    
    CGRect currentSquareCutRect = CGRectZero;
    currentSquareCutRect.origin = self.scrollView.contentOffset;
    currentSquareCutRect.size = self.imageFrameImageView.frame.size;
    
    CGFloat origX = (currentSquareCutRect.origin.x - self.imageView.origin.x) * rationScale;
    CGFloat origY = (currentSquareCutRect.origin.y - self.imageView.origin.y)  * rationScale;
    CGFloat oriWidth = currentSquareCutRect.size.width * rationScale;
    CGFloat oriHeight = currentSquareCutRect.size.height * rationScale;
    
    CGRect myRect = CGRectMake(origX, origY, oriWidth, oriHeight);
    
    UIImage * image = [originalImage frameSquareClipInRect:myRect];
    
    return image;
}


@end
