//
//  RootCollectionReusableView.h
//  LuNengHotel
//
//  Created by 拓之林 on 16/3/29.
//  Copyright © 2016年 拓之林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootCollectionReusableView : UICollectionReusableView
+ (id)loadFromXib;
+ (id)loadFromXibFrame:(CGRect)frame;
+ (UINib*)viewNib;
+ (NSString*)reuseIdentifier;
- (void)initData;
- (void)initUI;
@end
