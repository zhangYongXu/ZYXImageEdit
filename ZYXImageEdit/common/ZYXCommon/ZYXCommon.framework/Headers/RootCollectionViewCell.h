//
//  RootCollectionViewCell.h
//  YXebookReader
//
//  Created by BZBY on 15/11/25.
//  Copyright (c) 2015年 BZBY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RefreshUIFinishedBlock)(UIWebView * webView);
typedef void (^RefreshUIFinishedHeightBlock)(CGFloat realHeight);
@interface RootCollectionViewCell : UICollectionViewCell


+ (id)loadFromXib;
+ (NSString*)reuseIdentifier;
+ (UINib*)cellNib;


- (void)setCellWithModel:(id)model;
- (void)setCellWithModel:(id)model RefreshUIFinishedBlock:(RefreshUIFinishedBlock)refreshUIFinishedBlock;
- (void)setCellWithModel:(id)model RefreshUIFinishedHeightBlock:(RefreshUIFinishedHeightBlock)refreshUIFinishedHeightBlock;
- (void)initData;
- (void)initUI;

@end
