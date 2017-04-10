//
//  RootTabBarViewController.h
//  TEST
//
//  Created by 拓之林 on 16/2/24.
//  Copyright © 2016年 拓之林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootModel.h"

@interface RootTabBarViewController : UITabBarController
@property (nonatomic,strong) UIColor * tabBarBackgroundColor;
@property (nonatomic,strong) UIColor * tabBarTitleNormalColor;
@property (nonatomic,strong) UIColor * tabBarTitleSelectedColor;
#pragma mark 根据tabBar配置文件创建控制器
/**
 *  根据配置文件加载TabBar上各模块sb文件
 *
 *  @param tabBarConfigFileName 配置文件名字
 *
 *  @return 控制器数组
 */
- (NSArray*)viewControllersArrayWithTabBarConfigFileName:(NSString*)tabBarConfigFileName;
@end

@interface RootTabBarConfigModel : RootModel
@property (copy,nonatomic) NSString *storyBoardName;
@property (copy,nonatomic) NSString *VC_SBID;
@property (copy,nonatomic) NSString *VC_Title;
@property (copy,nonatomic) NSString *VC_ImageName;
@property (copy,nonatomic) NSString *VC_SelectedImageName;
@end
