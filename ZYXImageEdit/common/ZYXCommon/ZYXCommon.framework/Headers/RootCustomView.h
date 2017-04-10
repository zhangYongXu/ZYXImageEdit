//
//  SMDRootCustomView.h
//  Echo
//
//  Created by robu on 15/2/4.
//  Copyright (c) 2015年 Static Ga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootCustomView : UIView
+ (id)loadFromXib;
+ (id)loadFromXibFrame:(CGRect)frame;
+ (UINib*)viewNib;
+ (NSString*)reuseIdentifier;
- (void)initData;
- (void)initUI;
@end
