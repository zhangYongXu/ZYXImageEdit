//
//  UIAlertView+Block.h
//  BoBo
//
//  Created by BZBY on 15/8/31.
//  Copyright (c) 2015年 bzby. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ButtonHandleBlock)();

@interface UIAlertView (Block)

@property (strong,nonatomic,readonly)NSArray * handleBlockArray;

+(UIAlertView*)alertViewWithTitle:(NSString *) alertTitle message:(NSString *) message cancelButtonTitle:title handleBlock:(ButtonHandleBlock)handleBlock;

-(instancetype)initWithTitle:(NSString *) alertTitle message:(NSString *) message cancelButtonTitle:title handleBlock:(ButtonHandleBlock)handleBlock;

- (void)addButtonWithTitle:(NSString *)title handleBlock:(ButtonHandleBlock) handleBlock;

- (void)dismiss;



@end
@interface AlertViewBlockManager : NSObject
@property (nonatomic,strong) NSMutableArray* handleBlockArray;
@end

@interface AlertViewManager : NSObject
@property (strong,nonatomic) NSMutableArray * alertViewArray;

+(AlertViewManager*)sharedAlertViewManager;
@end
