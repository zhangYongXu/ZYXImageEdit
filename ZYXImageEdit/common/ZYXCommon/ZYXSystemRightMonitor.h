//
//  SystemRightMonitor.h
//  AllPeopleReading
//
//  Created by 极客天地 on 17/1/11.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,ZYXSystemRightTypes) {
    ZYXSystemRightTypeGetLocation = 1,
    ZYXSystemRightTypeCamera  = 2,
    ZYXSystemRightTypePhotos  = 3
};
#define ZYXSystemRightChangedNotificationName @"ZYXSystemRightChangedNotificationName"
@interface ZYXSystemRightMonitor : NSObject
/**
 *  当app进入前台时监听判断不同类型权限改变状态 权限状态改变为可用后发通知ZYXSystemRightChangedNotificationName
 *
 */
+ (void)monitoringSystemRightChangeWhenApplicationDidBecomeActive:(UIApplication *)application;


/**
 *  判断app是否拥有相机权限
 *
 *  @return 是否拥有权限
 */
+ (BOOL)judgeCameraRight;
/**
 *  判断app是否拥有相机权限 弹出提示
 *
 *  @return 是否拥有权限
 */
+ (BOOL)judgeCameraRightAndShowTipAlert;


/**
 *  判断app是否拥有相册权限
 *
 *  @return 是否拥有权限
 */
+ (BOOL)judgePhotosRight;
/**
 *  判断app是否拥有相册权限 弹出提示
 *
 *  @return 是否拥有权限
 */
+ (BOOL)judgePhotosRightAndShowTipAlert;


/**
 *  判断app是否拥有定位权限
 *
 *  @return 是否拥有权限
 */
+ (BOOL)judgeGeLoctionRight;
/**
 *  判断app是否拥有定位权限
 *
 *  @return 是否拥有权限
 */
+ (BOOL)judgeGeLoctionRightAndShowTipAlert;
@end
