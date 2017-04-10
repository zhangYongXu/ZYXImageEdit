//
//  ECBaseTableViewCell.h
//  Echo
//
//  Created by Dean on 13-11-16.
//  Copyright (c) 2013年 Static Ga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTableViewCell : UITableViewCell
- (void)initData;
- (void)initUI;
//autolayout下 动态计算高度
- (CGFloat)calculateFlexibleHeight;
+ (id)loadFromXib;
+ (UINib*)cellNib;
+ (NSString*)reuseIdentifier;
//固定高度
+ (CGFloat)cellHeight;
- (void)setCellWithModel:(id)model;
@end
