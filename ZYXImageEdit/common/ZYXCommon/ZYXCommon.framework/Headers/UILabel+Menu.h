//
//  UILabel+Menu.h
//  BoBo
//
//  Created by BZBY on 15/8/10.
//  Copyright (c) 2015年 bzby. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MenuItemHandelType) {
    MenuItemHandelTypeCopy = 0,
    MenuItemHandelTypeDelete = 1,
    MenuItemHandelTypeReport = 2
};
typedef void(^MenuItemHandleBlock)(void);
typedef void(^MenuWillShowHandleBlock)(void);
typedef void(^MenuWillHiddenHandleBlock)(void);
typedef void(^LabelTapGetureHandle)(void);
@interface UILabel (Menu)
- (void)addMenuItemWithHandleByType:(MenuItemHandelType)handleType HandleBlock:(MenuItemHandleBlock)handleBlock;
- (void)addLabelTapGetureHandle:(LabelTapGetureHandle)labelTapGetureHandle;
#pragma mark 用默认长安手势触发
- (void)initMenuWithMenuWillShowHandleBlock:(MenuWillShowHandleBlock)menuWillShowHandleBlock MenuWillHiddenHandleBlock:(MenuWillHiddenHandleBlock)menuWillHiddenHandleBlock;
#pragma mark 用自定义事件触发
-(void)initMenuUseCustomEventWithMenuWillShowHandleBlock:(MenuWillShowHandleBlock)menuWillShowHandleBlock MenuWillHiddenHandleBlock:(MenuWillHiddenHandleBlock)menuWillHiddenHandleBlock;
- (void)showMenuInRect:(CGRect)rect;
-(void)hiddenMenu;
@end

@interface LabelMenuManager : NSObject
@property (strong,nonatomic) NSMutableDictionary * menuItemDict;
@property (strong,nonatomic) NSMutableDictionary * handleBlockDict;
@property (copy,nonatomic) MenuWillShowHandleBlock menuWillShowHandleBlock;
@property (copy,nonatomic) MenuWillHiddenHandleBlock menuWillHiddenHandleBlock;
@property (copy,nonatomic) LabelTapGetureHandle labelTapGetureHandle;
@end
