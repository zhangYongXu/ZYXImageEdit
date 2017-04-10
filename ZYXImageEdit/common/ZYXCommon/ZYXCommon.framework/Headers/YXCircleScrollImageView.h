//
//  YXCircleScrollImageView.h
//  YXebookReader
//
//  Created by BZBY on 15/12/8.
//  Copyright (c) 2015年 BZBY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXCircleScrollImageView;

typedef void (^SingleTapHandleBlock)(NSInteger index);
typedef NSInteger(^ImageNumberBlock)(YXCircleScrollImageView * view);
typedef id(^ImageOrUrlAtIndexBlock)(NSInteger index);
typedef UIImage*(^ImageDefaultAtIndexBlock)(NSInteger index);
typedef void (^ImagePageChangedBlock)(NSInteger index);

@interface YXCircleScrollImageView : UIView
@property (copy,nonatomic) SingleTapHandleBlock singleTapHandle;
@property (copy,nonatomic) ImageNumberBlock imageNumber;
@property (copy,nonatomic) ImageOrUrlAtIndexBlock imageOrUrlAtIndex;
@property (copy,nonatomic) ImageDefaultAtIndexBlock imageDefaultAtIndex;
@property (copy,nonatomic) ImagePageChangedBlock imagePageChanged;

@property (assign,nonatomic) CGFloat pageControllBottom;//底部页码标示视图控件bottom
@property (strong,nonatomic) UIView * customBottomView; //自定义底部视图

@property (assign,nonatomic) BOOL isAotuScrollImage;    //是否自动轮播
@property (assign,nonatomic) NSInteger autoScrollSeconds;//自动轮播间隔时间(秒) 大于0的整数,默认3秒

@property (strong,nonatomic) UIColor * pageIndicatorTintColor;
@property (strong,nonatomic) UIColor * currentPageIndicatorTintColor;

/**
 *  实例化图片轮播滚动视图
 *
 *  @param frame                    frame
 *  @param imageNumberBlock         图片数量
 *  @param ImageOrUrlAtIndexBlock   每一个图片或url
 *  @param imageDefaultAtIndexBlock 默认图片
 *  @param singleTapHandleBlock     图片点击回调
 *
 *  @return 图片轮播滚动视图
 */
+(instancetype)circleScrollImageViewWithFrame:(CGRect)frame ImageNumber:(ImageNumberBlock)imageNumberBlock ImageOrUrlAtIndex:(ImageOrUrlAtIndexBlock)ImageOrUrlAtIndexBlock ImageDefaultAtIndex:(ImageDefaultAtIndexBlock)imageDefaultAtIndexBlock SingleTapHandle:(SingleTapHandleBlock)singleTapHandleBlock;
/**
 *  刷新数据
 */
-(void)reloadData;
@end
