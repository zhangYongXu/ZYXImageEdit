//
//  SMDTableViewIndexView.h
//  Echo
//
//  Created by robu on 15/2/2.
//  Copyright (c) 2015年 Static Ga. All rights reserved.
//

#import "RootCustomView.h"
@protocol YXTableViewIndexViewDelegate;

@interface YXTableViewIndexView : RootCustomView
@property (strong,nonatomic) UITableView * tableView;
@property (assign,nonatomic) id<YXTableViewIndexViewDelegate> tabelViewIndexViewDelegate;

@property(assign,nonatomic) BOOL isShowTipView;
@property(assign,nonatomic) UIImage* tipViewBackgroundImage;
@property(assign,nonatomic) UIColor* tipViewBackgroundColor;
@property(assign,nonatomic) UIColor* tipViewTitleColor;
@property(assign,nonatomic) UIFont*  tipViewTitleFont;
+ (id)loadFromXibForFrameWork;
-(void)setIndexTitlesArray:(NSArray*)titlesArray;

@end

@protocol YXTableViewIndexViewDelegate <NSObject>

- (void)tableViewSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

@end