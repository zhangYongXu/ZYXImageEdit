//
//  ZYXImageCutViewController.m
//  TourNote
//
//  Created by 极客天地 on 2017/2/8.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "ZYXImageCutViewController.h"

#import "ZYXImageBlurViewController.h"

#import "UIBezierPath+ZYXCut.h"

#import "UIImage+ZYXCut.h"

#import "ZYXCutPathView.h"

#define SquareViewMinWidth 40
#define SquareViewMinHeight 40

typedef NS_ENUM(NSInteger,ClipTypes) {
    ClipTypeSquare = 10001,         //方形裁剪
    ClipTypeJewelry = 10002,        //宝石形裁剪
    ClipTypeTriangle = 10003,       //三角形裁剪
    ClipTypeFivePointStar = 10004,  //五角星裁剪
    ClipTypeEllipse   = 10005,      //椭圆形裁剪
    ClipTypeSawtooth   = 10006,      //椭圆锯齿形裁剪
    ClipTypeHeart = 10007            //心形裁剪
};
@interface ZYXImageCutViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *handleContentView;
@property (weak, nonatomic) IBOutlet UIView *pathHandleContentView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *shapeHandleView;
@property (weak, nonatomic) IBOutlet UIView *pathHandleView;

@property (weak, nonatomic) IBOutlet ZYXCutPathView *pHandleView;
@property (weak, nonatomic) IBOutlet UIView *handleView;
@property (weak, nonatomic) IBOutlet UIView *squareView;
@property (weak, nonatomic) IBOutlet UIButton *squareBtn;


@property (strong,nonatomic) UIView * overView;
@property (strong,nonatomic) UIView * pathOverView;

@property (nonatomic, strong)CAShapeLayer *cutShapeLayer;//裁剪框layer
@property (nonatomic, strong)CAShapeLayer *pathCutShapeLayer;//自由裁layer
@property (nonatomic, assign)CGRect originalSquareFrame;//初始裁剪框的frame
@property (nonatomic, assign)CGRect currentSquareFrame; //当前裁剪框的frame

@property (nonatomic, assign)CGRect currentFrame;


@property (strong,nonatomic) UIBezierPath * fingerClipPath;
@property (strong,nonatomic) UIBezierPath * panCurrentPath;
@property (strong,nonatomic) NSMutableArray * fingerClipPathArray;

@property (strong,nonatomic) UIBezierPath * fingerImageClipPath;
@property (strong,nonatomic) UIBezierPath * panCurrentImagePath;
@property (strong,nonatomic) NSMutableArray * fingerImageClipPathArray;

@property (nonatomic, assign)ClipTypes clipType;  //裁剪的形状
@property (weak, nonatomic) IBOutlet UIButton *scaleBtn;

@property(assign,nonatomic) CGRect beforeOringalFrame;
@property(assign,nonatomic) CGRect beforeOringalBounds;
@property(assign,nonatomic) CGPoint beforeOringalCenter;
@property(assign,nonatomic)CGPoint panStartPoint;
@property(assign,nonatomic)CGPoint panLocationPoint;

@end

@implementation ZYXImageCutViewController
-(UIBezierPath *)fingerClipPath{
    if(nil == _fingerClipPath){
        _fingerClipPath = [[UIBezierPath alloc] init];
        _fingerClipPath.lineWidth = 2.0;
        
    }
    return _fingerClipPath;
}
-(UIBezierPath *)fingerImageClipPath{
    if(nil == _fingerImageClipPath){
        _fingerImageClipPath = [[UIBezierPath alloc] init];
        _fingerImageClipPath.lineWidth = 2.0;
        
    }
    return _fingerImageClipPath;
}
-(NSMutableArray *)fingerClipPathArray{
    if(nil == _fingerClipPathArray){
        _fingerClipPathArray = [[NSMutableArray alloc] init];
    }
    return _fingerClipPathArray;
}
-(NSMutableArray *)fingerImageClipPathArray{
    if(nil == _fingerImageClipPathArray){
        _fingerImageClipPathArray = [[NSMutableArray alloc] init];
    }
    return _fingerImageClipPathArray;
}
- (IBAction)shapeHandleBtnClicked:(id)sender {
    self.shapeHandleView.hidden = NO;
    self.pathHandleView.hidden = YES;
    
    self.handleContentView.hidden = NO;
    self.pathHandleContentView.hidden = YES;
}
- (IBAction)pathHandleBtnClicked:(id)sender {
    self.shapeHandleView.hidden = YES;
    self.pathHandleView.hidden = NO;
    
    self.handleContentView.hidden = YES;
    self.pathHandleContentView.hidden = NO;
}

- (IBAction)closeBtnClicekd:(id)sender {
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
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
    self.clipType = ClipTypeSquare;
    CGFloat space = 40;
    CGFloat WH = SCREEN_WIDTH - space*2;
    CGFloat top = (self.overView.frame.size.height - WH)/2.0;
    CGFloat left = space;
 
    self.originalSquareFrame = CGRectMake(left,top, WH, WH);

}

-(void)initUI{
    self.shapeHandleView.hidden = NO;
    self.pathHandleView.hidden = YES;
    
    self.handleContentView.hidden = NO;
    self.pathHandleContentView.hidden = YES;
    
    [self addPanGestureToSquareBtn];
    [self addPanGestureToScaleBtn];
    [self addPanGestureToPathHandleContentView];
    [self showOriginalImage];
    
    self.scrollView.minimumZoomScale = 1.0;   //最小倍数
    self.scrollView.maximumZoomScale = 2.0;  //最大倍数
    self.scrollView.contentSize = CGSizeMake(self.image.size.width,self.image.size.height); //两倍大小图片
    self.scrollView.decelerationRate = 0.0f; //减速速率
    self.scrollView.zoomScale = 1.0;
    //yes 则发送一个可以touchesCancelled:withEvent:  然后把这个事件当作一次滚动赖实现
    //[self.scrollView setCanCancelContentTouches:YES];
    //滚动的时候是否可以除边界，即到边界的时候是否可以多看到一点内容
    //[self.scrollView setBounces:NO];
    // 当值是NO 立即调用 touchesShouldBegin:withEvent:inContentView 看是否滚动 scroll
    [self.scrollView setDelaysContentTouches:NO];
    
    CGFloat addOffset = 10;
    CGRect rect = CGRectMake(0, 0, self.originalSquareFrame.size.width+addOffset*2, self.originalSquareFrame.size.height+addOffset*2);
    self.squareView.frame = rect;
    self.squareView.center = self.handleView.center;
    [self drawClipPath:self.clipType];
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
-(void)addPanGestureToSquareBtn{
    UIPanGestureRecognizer * squarePanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(squarePanGestureHanele:)];
    [self.squareBtn addGestureRecognizer:squarePanGesture];
}

-(void)addPanGestureToScaleBtn{
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHanele:)];
    [self.scaleBtn addGestureRecognizer:panGesture];
}

-(void)addPanGestureToPathHandleContentView{
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pathHandleContentViewPanGestureHanele:)];
    [self.pathHandleContentView addGestureRecognizer:panGesture];
}

#pragma mark - scrollView delegate
//缩放过程中的图像
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.contentView;
}

//缩放结束
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    NSLog(@"缩放的比例:%f",scale);
}

//缩放中
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.contentView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                          scrollView.contentSize.height * 0.5 + offsetY);
    NSLog(@"缩放中");
}



-(UIView *)overView{
    if(nil == _overView){
        _overView = self.handleView;
        _overView.backgroundColor = [UIColor clearColor];
        _overView.opaque = NO;
    }
    return _overView;
}
-(UIView *)pathOverView{
    if(nil == _pathOverView){
        _pathOverView = self.pHandleView;
        _pathOverView.backgroundColor = [UIColor clearColor];
        _pathOverView.opaque = NO;
    }
    return _pathOverView;
}


-(CGRect)currentSquareFrame{
    CGRect squareViewFrame = self.squareView.frame;
    CGFloat addOffset = 12;
    CGFloat width = squareViewFrame.size.width - addOffset*2;
    CGFloat height = squareViewFrame.size.height - addOffset*2;
    CGFloat left = squareViewFrame.origin.x + addOffset;
    CGFloat top = squareViewFrame.origin.y + addOffset;
    CGRect rect = CGRectMake(left, top, width, height);
    return rect;
}
-(CAShapeLayer *)cutShapeLayer{
    if(nil == _cutShapeLayer){
        _cutShapeLayer = [CAShapeLayer layer];
        _cutShapeLayer.fillRule = kCAFillRuleEvenOdd;
        _cutShapeLayer.fillColor = [[UIColor blackColor] CGColor];
        _cutShapeLayer.opacity = 0.5;
        [self.overView.layer addSublayer:_cutShapeLayer];
    }
    return _cutShapeLayer;
}
-(CAShapeLayer *)pathCutShapeLayer{
    if(nil == _pathCutShapeLayer){
        _pathCutShapeLayer = [CAShapeLayer layer];
        _pathCutShapeLayer.fillRule = kCAFillRuleEvenOdd;
        _pathCutShapeLayer.fillColor = [[UIColor blackColor] CGColor];
        _pathCutShapeLayer.opacity = 0.5;
        [self.pathOverView.layer addSublayer:_pathCutShapeLayer];
    }
    return _pathCutShapeLayer;
}
- (IBAction)shapeTypeBtnClicked:(UIButton*)sender {
    NSInteger tag = sender.tag;
    ClipTypes clipType = tag;
    self.clipType = clipType;
    [self drawClipPath:self.clipType];
}
- (IBAction)revokeBtnClicked:(id)sender {
    [self.fingerClipPathArray removeLastObject];
    [self.fingerClipPath removeAllPoints];
    for(UIBezierPath * path in self.fingerClipPathArray){
        [self.fingerClipPath appendPath:path];
    }
    [self.pHandleView setNeedsDisplay];
    [self drawCustomPathClip];
    
    [self.fingerImageClipPathArray removeLastObject];
    [self.fingerImageClipPath removeAllPoints];
    for(UIBezierPath * path in self.fingerImageClipPathArray){
        [self.fingerImageClipPath appendPath:path];
    }
    
    
}
- (IBAction)allClearBtnClicked:(id)sender {
    [self.fingerClipPath removeAllPoints];
    [self.fingerImageClipPath removeAllPoints];
    [self.pHandleView setNeedsDisplay];
    [self drawCustomPathClip];
}
//绘制自由裁剪框
-(void)drawCustomPathClip{
    CGFloat ScreenWidth = self.pathOverView.width;
    CGFloat ScreenHeight = self.pathOverView.height;
    UIBezierPath * path= [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [path appendPath:self.fingerClipPath];
    path.usesEvenOddFillRule = NO;
    self.pathCutShapeLayer.path = path.CGPath;
}
//绘制裁剪框
-(void)drawClipPath:(ClipTypes)clipType{
    CGFloat ScreenWidth = self.overView.width;
    CGFloat ScreenHeight = self.overView.height;
    
    CGRect currentSquareCutRect = self.currentSquareFrame;
    UIBezierPath * path= [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if(clipType == ClipTypeSquare){
        //绘制矩形裁剪区域
        [path appendPath:[UIBezierPath bezierPathWithRect:currentSquareCutRect]];
    }else if(clipType == ClipTypeJewelry){
        //绘制珠宝形裁剪区域
        UIBezierPath * jewelryPath = [UIBezierPath jewelryPathWithInRect:currentSquareCutRect];
        [path appendPath:jewelryPath];
    }else if(clipType == ClipTypeTriangle){
        //绘制三角形裁剪区域
        UIBezierPath* trianglePath = [UIBezierPath trianglePathWithInRect:currentSquareCutRect];
        [path appendPath:trianglePath];
    }else if(clipType == ClipTypeFivePointStar){
        //绘制五角星形裁剪区域
        UIBezierPath * fivePointStarPath = [UIBezierPath fivePointStarPathWithInRect:currentSquareCutRect];
        [path appendPath:fivePointStarPath];
    }else if(clipType == ClipTypeEllipse){
        //绘制椭圆形或者圆形 裁剪区域
        UIBezierPath * circlePath = [UIBezierPath bezierPathWithOvalInRect:currentSquareCutRect];
        [path appendPath:circlePath];
        
    }else if(clipType == ClipTypeSawtooth){
        //绘制椭圆锯齿形 裁剪区域
        UIBezierPath * sawtoothPath = [UIBezierPath sawtoothPathWithInRect:currentSquareCutRect];
        [path appendPath:sawtoothPath];
    }else if(clipType == ClipTypeHeart){
        //绘制心形或者圆形 裁剪区域
        UIBezierPath * heartPath = [UIBezierPath heartPathWithInRect:currentSquareCutRect];
        [path appendPath:heartPath];
    }
    path.usesEvenOddFillRule = NO;
    self.cutShapeLayer.path = path.CGPath;
 
}



-(void)squarePanGestureHanele:(UIPanGestureRecognizer*)panGesture{
 
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint locationPoint = [panGesture locationInView:self.handleContentView];
    switch (panGesture.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:{
            startPoint = locationPoint;
            self.panStartPoint = startPoint;
            self.beforeOringalCenter = self.squareView.center;
        }
            break;
        case UIGestureRecognizerStateChanged:{
            self.panLocationPoint = locationPoint;
            self.squareView.centerX = self.panLocationPoint.x + (self.beforeOringalCenter.x - self.panStartPoint.x);
            self.squareView.centerY = self.panLocationPoint.y + (self.beforeOringalCenter.y - self.panStartPoint.y);
            [self drawClipPath:self.clipType];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        case UIGestureRecognizerStateFailed:
            break;
    }
}

-(void)panGestureHanele:(UIPanGestureRecognizer*)panGesture{

    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint locationPoint = [panGesture locationInView:self.handleContentView];
    switch (panGesture.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:{
            startPoint = locationPoint;
            self.panStartPoint = startPoint;
            self.beforeOringalBounds = self.squareView.bounds;
            self.beforeOringalFrame = self.squareView.frame;
            self.beforeOringalCenter = self.squareView.center;
        }
            break;
        case UIGestureRecognizerStateChanged:{
            self.panLocationPoint = locationPoint;
            
            [self scaleSquareViewHandle];
            [self drawClipPath:self.clipType];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        case UIGestureRecognizerStateFailed:
            break;
    }
    
}

-(void)pathHandleContentViewPanGestureHanele:(UIPanGestureRecognizer*)panGesture{
    
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint locationPoint = [panGesture locationInView:self.handleContentView];
    switch (panGesture.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:{
            startPoint = locationPoint;
            self.panStartPoint = startPoint;
            
            //[self.fingerClipPath moveToPoint:self.panStartPoint];
            
            self.panCurrentPath = [UIBezierPath bezierPath];
            [self.panCurrentPath moveToPoint:self.panStartPoint];
            
            //为图片自由裁剪准备
            self.panCurrentImagePath = [UIBezierPath bezierPath];
            
            CGPoint imagePoint = [self convertToImagePointWithImageView:self.imageView OriginalPoint:self.panStartPoint];
            [self.panCurrentImagePath moveToPoint:imagePoint];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            self.panLocationPoint = locationPoint;
            UIColor * color = [UIColor colorWithHex:0xE4564A];
            self.pHandleView.path = self.panCurrentPath;
            self.pHandleView.color = color;
            
            [self.panCurrentPath addLineToPoint:self.panLocationPoint];
            
            [self.pHandleView setNeedsDisplay];
            
            CGPoint imagePoint = [self convertToImagePointWithImageView:self.imageView OriginalPoint:self.panLocationPoint];
            [self.panCurrentImagePath addLineToPoint:imagePoint];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            [self.panCurrentPath closePath];
            [self.fingerClipPathArray addObject:self.panCurrentPath];
            [self.fingerClipPath appendPath:self.panCurrentPath];
            [self.fingerClipPath addClip];
            [self.fingerClipPath closePath];
            [self drawCustomPathClip];
            
            self.pHandleView.path = self.fingerClipPath;
            [self.pHandleView setNeedsDisplay];
            
            [self.panCurrentImagePath closePath];
            [self.fingerImageClipPathArray addObject:self.panCurrentImagePath];
            [self.fingerImageClipPath appendPath:self.panCurrentImagePath];
            [self.fingerImageClipPath addClip];
            [self.fingerImageClipPath closePath];
        }
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        case UIGestureRecognizerStateFailed:
            break;
    }
}
//将试图的点按比例转到UIImage上的点
-(CGPoint)convertToImagePointWithImageView:(UIImageView*)imageView OriginalPoint:(CGPoint)originalPoint{
    UIImage * originalImage = imageView.image;
    CGFloat width = imageView.width;
    CGFloat rationScale = (originalImage.size.width  / width /1.0);
    
    CGFloat origX = (originalPoint.x - imageView.frame.origin.x) * rationScale;
    CGFloat origY = (originalPoint.y - imageView.frame.origin.y) * rationScale;
    
    return CGPointMake(origX, origY);
}

//处理缩放SquareView
- (void)scaleSquareViewHandle{
    
//    //当前点是否在起始点的左上象限区域
//    BOOL isLeftTopZoon = self.panLocationPoint.x > self.panStartPoint.x && self.panLocationPoint.y > self.panStartPoint.y;
//    //当前点是否在起始点的右下象限区域
//    BOOL isRightBottomZoon = self.panLocationPoint.x < self.panStartPoint.x && self.panLocationPoint.y < self.panStartPoint.y;
//    //当前点是否在起始点的垂直方向的上方
//    BOOL isTopVertical = self.panLocationPoint.x == self.panStartPoint.x && self.panLocationPoint.y < self.panStartPoint.y;
//    //当前点是否在起始点的垂直方向的下方
//    BOOL isBootomVertical = self.panLocationPoint.x == self.panStartPoint.x && self.panLocationPoint.y > self.panStartPoint.y;
//    
//    //当前点是否在起始点的水平方向的左方
//    BOOL isLeftHorizontal = self.panLocationPoint.x < self.panStartPoint.x && self.panLocationPoint.y == self.panStartPoint.y;
//    //当前点是否在起始点的水平方向的右方
//    BOOL isRightHorizontal = self.panLocationPoint.x > self.panStartPoint.x && self.panLocationPoint.y == self.panStartPoint.y;
//    
//    BOOL isCanScale = isLeftTopZoon || isRightBottomZoon || isTopVertical || isBootomVertical || isLeftHorizontal || isRightHorizontal;
//    
//    if(!isCanScale){
//        return;
//    }
  
    
    CGFloat offX = self.panLocationPoint.x - self.panStartPoint.x;
    CGFloat offY = self.panLocationPoint.y - self.panStartPoint.y;
    
    offX = offX*2;
    offY = offY*2;
    
    CGFloat width = self.beforeOringalBounds.size.width + offX;
    CGFloat height = self.beforeOringalBounds.size.height + offY;
    
    width = width > SquareViewMinWidth ? width : SquareViewMinWidth;
    height = height > SquareViewMinHeight ? height : SquareViewMinHeight;
    
    CGRect newBounds = self.beforeOringalBounds;
    newBounds.size.width = width;
    newBounds.size.height = height;
    self.squareView.bounds = newBounds;
    self.squareView.center = self.beforeOringalCenter;
    
    //NSLog(@"height:%@ bounds:%@ newBounds:%@",@(height),NSStringFromCGRect(self.beforeOringalBounds),NSStringFromCGRect(newBounds));
}
- (CGFloat)distanceWithPoint:(CGPoint)point otherPoint:(CGPoint)otherPoint{
    return sqrt(pow(point.x - otherPoint.x, 2) + pow(point.y - otherPoint.y, 2));
}
- (IBAction)confirmBtnClicked:(id)sender {
    UIImage * image = nil;
    CGSize showImageSize = CGSizeZero;
    if(self.pathHandleView.hidden){
        image = [self getSmallImage];
        showImageSize = self.currentSquareFrame.size;
    }else{
        CGRect rect = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
        image = [self.image clipWithPath:self.fingerImageClipPath InRect:rect];
        showImageSize = self.imageView.size;
    }
    ZYXImageBlurViewController * ibvc = [[ZYXImageBlurViewController alloc] init];
    ibvc.image = image;
    ibvc.showImageSize = showImageSize;
    [ibvc setBlurImageCompleteBlock:^(UIImage *blurImage) {
        
        if(self.navigationController){
            [self.navigationController popViewControllerAnimated:NO];
            if(self.cutImageCompleteBlock){
                self.cutImageCompleteBlock(blurImage);
            }
        }else{
            [self dismissViewControllerAnimated:NO completion:^{
                if(self.cutImageCompleteBlock){
                    self.cutImageCompleteBlock(blurImage);
                }
            }];
        }
    }];
    if(self.navigationController){
        [self.navigationController pushViewController:ibvc animated:YES];
    }else{
        [self presentViewController:ibvc animated:YES completion:^{
            
        }];
    }
    
}

/* 裁剪图片 */
-(UIImage *)getSmallImage
{
    UIImage * originalImage = self.imageView.image;
    CGFloat width = self.imageView.width;
    CGFloat rationScale = (originalImage.size.width  / width /1.0);
    
    CGRect currentSquareCutRect = self.currentSquareFrame;
    
    CGFloat origX = (currentSquareCutRect.origin.x - self.imageView.frame.origin.x) * rationScale;
    CGFloat origY = (currentSquareCutRect.origin.y - self.imageView.frame.origin.y) * rationScale;
    CGFloat oriWidth = currentSquareCutRect.size.width * rationScale;
    CGFloat oriHeight = currentSquareCutRect.size.height * rationScale;
    
    CGRect myRect = CGRectMake(origX, origY, oriWidth, oriHeight);
    
    
    UIImage * clipImage = nil;
    if(self.clipType == ClipTypeSquare){
        clipImage = [originalImage squareClipInRect:myRect];
    }else if(self.clipType == ClipTypeTriangle){
        clipImage = [originalImage triangleClipInRect:myRect];
    }else if(self.clipType == ClipTypeJewelry){
        clipImage = [originalImage jewelryClipInRect:myRect];
    }else if(self.clipType == ClipTypeFivePointStar){
        clipImage = [originalImage fivePointStarClipInRect:myRect];
    }else if(self.clipType == ClipTypeEllipse){
        clipImage = [originalImage ellipseClipInRect:myRect];
    }else if(self.clipType == ClipTypeSawtooth){
        clipImage = [originalImage sawtoothClipInRect:myRect];
    }else if(self.clipType == ClipTypeHeart){
        clipImage = [originalImage heartClipInRect:myRect];
    }
    return clipImage;
}

@end
