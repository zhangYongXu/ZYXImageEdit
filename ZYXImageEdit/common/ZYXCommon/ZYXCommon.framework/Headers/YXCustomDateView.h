//
//  YXDateView.h
//  BoBo
//
//  Created by BZBY on 15/7/22.
//  Copyright (c) 2015年 bzby. All rights reserved.
//
#import "RootModel.h"
#import "RootCustomView.h"
@protocol YXCustomDateViewDelegate;
typedef NS_ENUM(NSInteger, DateViewStatus) {
    DateViewStatusHidden = 0,
    DateViewStatusShowing = 1
};
typedef NS_ENUM(NSInteger, DateViewMode) {
    DateViewModeDate = 0,           //年/月/日            default
    DateViewModeTime = 1,           //年/月/日 /时/分/秒
    DateViewModeMonthTimeHms = 2,   //月/日 /时/分/秒
    DateViewModeMonthTimeHm = 3,    //月/日 /时/分
    DateViewModeMonthTimeH = 4,     //月/日 /时
    DateViewModeMonthDay = 5,       //月/日
    DateViewModeYearMonth = 6,      //年/月
    DateViewModeYear = 7,           //年
};
typedef NS_ENUM(NSInteger, TimeMode) {
    TimeMode12 = 0,
    TimeMode24 = 1
};
typedef void(^CustomDateViewConfirmBlock)(NSDate * date);

@interface YXCustomDateView : RootCustomView

@property(strong,nonatomic,readonly) UIPickerView * customDatePickerView;
@property (strong,nonatomic,readonly) NSDate * customDatePickerSelectedDate;

@property(strong,nonatomic)UIColor* confirmBtnTextColor;
@property(strong,nonatomic)UIColor* bottomViewBackgroundColor;

@property(assign,nonatomic,readonly) DateViewStatus dateViewStatusStatus;
@property(assign,nonatomic) DateViewMode dateViewMode;
@property(assign,nonatomic) TimeMode timeMode;
@property(strong,nonatomic) NSDate * minDate;
@property(strong,nonatomic) NSDate * maxDate;
@property(strong,nonatomic) NSDate * defaultShowDate;

-(void)showDateViewAnimation:(BOOL)isAnimation;
-(void)hiddenDateViewAnimation:(BOOL)isAnimation;

+(YXCustomDateView*)customDateView;
+ (id)loadFromXibForFrameWork;
-(void)refreshDataWithConfirmBlock:(CustomDateViewConfirmBlock)confirmBlock;

@end



typedef NS_ENUM(NSInteger, CustomDateViewItemModelType) {
    CustomDateViewItemModelTypeYear = 0,
    CustomDateViewItemModelTypeMonth = 1,
    CustomDateViewItemModelTypeDay = 2,
    CustomDateViewItemModelTypeHour = 3,
    CustomDateViewItemModelTypeMinutes = 4,
    CustomDateViewItemModelTypeSecond =5
};

@interface YXCustomDateViewItemModel : RootModel
@property (copy,nonatomic) NSString * title;
@property (copy,nonatomic) NSString * detailTitle;
@property (assign,nonatomic) CustomDateViewItemModelType modelType;


+(NSArray*)calculateYearArrayWithMinDate:(NSDate*)minDate MaxDate:(NSDate*)maxDate;
+(NSArray*)calculateMonthArray;
+(NSArray*)calculateDayArrayWithYear:(NSString*)yearStr Month:(NSString*)monthStr;
+(NSArray*)calculateHourArrayWithTimeMode:(TimeMode)timeMode;
+(NSArray*)calculateMinutesArray;
+(NSArray*)calculateSecondArray;
@end
