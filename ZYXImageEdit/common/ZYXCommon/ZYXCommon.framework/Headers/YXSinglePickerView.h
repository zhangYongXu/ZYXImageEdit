//
//  YXSinglePickerView.h
//  LuNengHotel
//
//  Created by 拓之林 on 16/4/13.
//  Copyright © 2016年 拓之林. All rights reserved.
//

#import "RootCustomView.h"
typedef void (^SinglePickerViewConfirmBlock)(NSArray * array,NSInteger index);
typedef NSString* (^SinglePickerViewTitleForRowBlock)(NSArray * array,NSInteger index);
typedef NS_ENUM(NSInteger, SinglePickerViewStatus) {
    SinglePickerViewStatusHidden = 0,
    SinglePickerViewStatusShowing = 1
};
@interface YXSinglePickerView : RootCustomView
@property(strong,nonatomic)UIColor* confirmBtnTextColor;
@property(strong,nonatomic)UIColor* confirmBtnBackgroundColor;
@property(strong,nonatomic)UIColor* bottomViewBackgroundColor;

+(YXSinglePickerView*)SinglePickerView;

-(void)showSinglePickerViewAnimation:(BOOL)isAnimation;
-(void)hiddenSinglePickerViewAnimation:(BOOL)isAnimation;

-(void)refreshDataWithArray:(NSArray*)array TitleForRowBlock:(SinglePickerViewTitleForRowBlock)titleForRowBlock ConfirmBlock:(SinglePickerViewConfirmBlock)confirmBlock;

@end
