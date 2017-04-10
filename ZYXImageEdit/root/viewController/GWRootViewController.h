//
//  JiaMenRootViewController.h
//  JiaMen
//
//  Created by 极客天地 on 16/6/8.
//  Copyright © 2016年 极客天地. All rights reserved.
//

#import <ZYXCommon/RootViewController.h>

@interface GWRootViewController : RootViewController

-(UIButton*)createLeftItemWithTitle:(NSString *)title FontSize:(NSInteger)fontSize;
-(UIButton*)createMiddleItemWithTitle:(NSString *)title FontSize:(NSInteger)fontSize;
-(UIButton*)createRightItemWithWithTitle:(NSString *)title FontSize:(NSInteger)fontSize;
-(void)clickedHandleStyleWithButton:(UIButton*)button;

-(void)middleBtnItemClicked:(UIBarButtonItem*)sender;
@end
