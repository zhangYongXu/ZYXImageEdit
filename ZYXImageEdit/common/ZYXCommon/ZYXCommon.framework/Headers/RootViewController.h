//
//  RootViewController.h
//  bzbyTeacher
//
//  Created by bzby on 15/3/11.
//  Copyright (c) 2015年 bzby. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RightItemBtnHandleBlock)(UIButton * button);

@interface RootViewController : UIViewController
/**
 *  初始化方法
 *
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中图片
 *
 *  @return 控制器实例
 */
- (instancetype)initWithTitle:(NSString*)title Image:(UIImage*)image SelectedImage:(UIImage*)selectedImage;
/**
 *  设置tabBar标题和图片
 *
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中图片
 */
-(void)configTabBarItemWithTitle:(NSString*)title Image:(UIImage*)image SelectedImage:(UIImage*)selectedImage;
/**
 *  初始化数据
 */
-(void)initData;
/**
 *  初始化UI
 */
-(void)initUI;
/**
 *  默认初始化导航条
 */
- (void)initNavigationBar;


- (void)createBackItemWithTitle:(NSString*)title;
- (void)createBackItemWithImage:(UIImage*)image;
- (void)backItemClickedHandle:(UIBarButtonItem*)sender;

- (void)createRightItemWithTitle:(NSString*)title;
- (void)createRightItemWithImage:(UIImage*)image;
- (void)rightItemClickedHandle:(UIBarButtonItem*)sender;

- (void)createLeftItemWithTitle:(NSString*)title;
- (void)createLeftItemWithImage:(UIImage*)image;
- (void)createLeftItemWithTitle:(NSString*)title IsRun:(BOOL)isRun;
- (void)leftItemClickedHandle:(UIBarButtonItem*)sender;
- (void)createLeftItemWithTitle:(NSString*)title Image:(UIImage*)image;


- (void)addRightItemBtnWithImage:(UIImage*)image HandleBlock:(RightItemBtnHandleBlock)handleBlock;
- (void)rightItemShowRedDotViewWithNumber:(NSInteger)number Index:(NSInteger)index;
@end
