//
//  SystemRightMonitor.m
//  AllPeopleReading
//
//  Created by 极客天地 on 17/1/11.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "ZYXSystemRightMonitor.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface ZYXSystemRightMonitor()

@end
@implementation ZYXSystemRightMonitor
/**
 *  当app进入前台时监听
 *
 */
+ (NSString*)udKeyWithType:(ZYXSystemRightTypes)type{
    NSString * key = nil;
    switch (type) {
        case ZYXSystemRightTypeGetLocation:
            key = @"ZYXSystemRightTypeGetLocation";
            break;
        case ZYXSystemRightTypeCamera:
            key = @"ZYXSystemRightTypeCamera";
            break;
        case ZYXSystemRightTypePhotos:
            key = @"ZYXSystemRightTypePhotos";
            break;
            
        default:
            break;
    }
    return key;
}
+ (BOOL)getSystemRightWithType:(ZYXSystemRightTypes)type{
    BOOL isRight = NO;
    switch (type) {
        case ZYXSystemRightTypeGetLocation:
            isRight = [self judgeGeLoctionRight];
            break;
        case ZYXSystemRightTypeCamera:
            isRight = [self judgeCameraRight];
            break;
        case ZYXSystemRightTypePhotos:
            isRight = [self judgePhotosRight];
            break;
            
        default:
            break;
    }
    return isRight;
}
//根据类型获取是否拥有该权限
+ (NSString*)getLocalIsRightStrWithType:(ZYXSystemRightTypes)type{
    NSUserDefaults * UD = [NSUserDefaults standardUserDefaults];
    NSString* isRightStr = [UD objectForKey:[self udKeyWithType:type]];
    return isRightStr;
}
//根据类型保存是否拥有该权限
+ (void)saveIsRightToLocalWithType:(ZYXSystemRightTypes)type IsRight:(BOOL)isRight{
    NSUserDefaults * UD = [NSUserDefaults standardUserDefaults];
    NSString * isRightStr = [NSString stringWithFormat:@"%i",isRight];
    NSString * key = [self udKeyWithType:type];
    [UD setObject:isRightStr forKey:key];
    [UD synchronize];
}
/**
 *  当app进入前台时监听判断不同类型权限改变状态 权限状态改变后发通知ZYXSystemRightChangedNotificationName
 *
 */
+ (void)monitoringSystemRightChangeWhenApplicationDidBecomeActive:(UIApplication *)application{

    for(ZYXSystemRightTypes type = ZYXSystemRightTypeGetLocation; type < ZYXSystemRightTypePhotos; type++ ){
        BOOL isRight = [self getSystemRightWithType:type];
        NSString* localIsRightStr = [self getLocalIsRightStrWithType:type];
        BOOL isRightChanged = NO;
        if(STR_IS_NIL(localIsRightStr)){
            //isRightChanged = YES;
        }else{
            if(isRight && [localIsRightStr boolValue] != isRight){
                isRightChanged = YES;
            }
        }
        [self saveIsRightToLocalWithType:type IsRight:isRight];
        if(isRightChanged){
            [[NSNotificationCenter defaultCenter] postNotificationName:ZYXSystemRightChangedNotificationName    object:@(type)];
        }
    }
}

/**
 *  判断app是否拥有相机权限
 *
 *  @return 是否拥有权限
 */
+ (BOOL)judgeCameraRight{
    BOOL isRight = YES;
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSLog(@"相机权限受限");
        isRight = NO;
    }
    return isRight;
}
/**
 *  判断app是否拥有相机权限 弹出提示
 *
 *  @return 是否拥有权限
 */
+ (BOOL)judgeCameraRightAndShowTipAlert{
    BOOL isRight = [self judgeCameraRight];
    NSString* localIsRightStr = [self getLocalIsRightStrWithType:ZYXSystemRightTypeCamera];
    if(!isRight && !STR_IS_NIL(localIsRightStr)){
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        CFShow((__bridge CFTypeRef)(infoDictionary));
        // app名称
        NSString *appName = [infoDictionary objectForKey:@"CFBundleName"];
        
        NSString * tipMsg = [NSString stringWithFormat:@"为了更好的体验,请到设置->隐私->相机服务中开启!【%@APP】相机服务,已便使用!",appName];
        
        UIAlertView * alert = [UIAlertView alertViewWithTitle:@"温馨提示" message:tipMsg cancelButtonTitle:@"开启" handleBlock:^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [alert addButtonWithTitle:@"以后" handleBlock:^{
            
        }];
        [alert show];
    }else{
        if(STR_IS_NIL(localIsRightStr)){
            [self saveIsRightToLocalWithType:ZYXSystemRightTypeCamera IsRight:isRight];
        }
    }
    return isRight;
}
/**
 *  判断app是否拥有相册权限
 *
 *  @return 是否拥有权限
 */
+ (BOOL)judgePhotosRight {
    BOOL isRight = YES;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied) {
            //无权限
            isRight = NO;
        }
    }else{
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
            //无权限
            isRight = NO;
        }
    }
    return isRight;
}
/**
 *  判断app是否拥有相册权限 弹出提示
 *
 *  @return 是否拥有权限
 */
+ (BOOL)judgePhotosRightAndShowTipAlert {
    BOOL isRight = [self judgePhotosRight];
    NSString* localIsRightStr = [self getLocalIsRightStrWithType:ZYXSystemRightTypePhotos];
    if(!isRight && !STR_IS_NIL(localIsRightStr)){
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        CFShow((__bridge CFTypeRef)(infoDictionary));
        // app名称
        NSString *appName = [infoDictionary objectForKey:@"CFBundleName"];
        NSString * tipMsg = [NSString stringWithFormat:@"为了更好的体验,请到设置->隐私->相册服务中开启!【%@APP】相册服务,已便使用!",appName];
        
        UIAlertView * alert = [UIAlertView alertViewWithTitle:@"温馨提示" message:tipMsg cancelButtonTitle:@"开启" handleBlock:^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [alert addButtonWithTitle:@"以后" handleBlock:^{
            
        }];
        [alert show];
    }else{
        if(STR_IS_NIL(localIsRightStr)){
            [self saveIsRightToLocalWithType:ZYXSystemRightTypePhotos IsRight:isRight];
        }
    }
    return isRight;
}

/**
 *  判断app是否拥有定位权限
 *
 *  @return 是否拥有权限
 */
+ (BOOL)judgeGeLoctionRight{
    BOOL isRight = YES;
    //请开启定位服务
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status){
        isRight = NO;
    }
    return isRight;
}
/**
 *  判断app是否拥有定位权限
 *
 *  @return 是否拥有权限
 */
+ (BOOL)judgeGeLoctionRightAndShowTipAlert{
    BOOL isRight = [self judgeGeLoctionRight];
    NSString* localIsRightStr = [self getLocalIsRightStrWithType:ZYXSystemRightTypeGetLocation];
    if(!isRight && !STR_IS_NIL(localIsRightStr)){
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        CFShow((__bridge CFTypeRef)(infoDictionary));
        // app名称
        NSString *appName = [infoDictionary objectForKey:@"CFBundleName"];
        NSString * tipMsg = [NSString stringWithFormat:@"为了更好的体验,请到设置->隐私->定位服务中开启!【%@APP】定位服务,已便获取附近信息!",appName];
        
        UIAlertView * alert = [UIAlertView alertViewWithTitle:@"温馨提示" message:tipMsg cancelButtonTitle:@"开启" handleBlock:^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [alert addButtonWithTitle:@"以后" handleBlock:^{
            
        }];
        [alert show];
    }else{
        if(STR_IS_NIL(localIsRightStr)){
            [self saveIsRightToLocalWithType:ZYXSystemRightTypeGetLocation IsRight:isRight];
        }
    }
    return isRight;
}
@end
