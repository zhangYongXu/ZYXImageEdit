//
//  CommonTypeDef.h
//  LuNengHotel
//
//  Created by 极客天地 on 16/3/28.
//  Copyright © 2016年 极客天地. All rights reserved.
//

#ifndef CommonTypeDef_h
#define CommonTypeDef_h


#endif /* CommonTypeDef_h */


#define STR_IS_NIL(key) (([@"<null>" isEqualToString:(key)] || [@"" isEqualToString:(key)] || key == nil || [key isKindOfClass:[NSNull class]]) ? 1: 0)

#define ARRAY_IS_EMPTY(array) ((!array || [array isKindOfClass:[NSNull class]] ||[array count] == 0)? 1: 0)
#define DICTIONARY_IS_EMPTY(dictionary) ((!dictionary || [dictionary isKindOfClass:[NSNull class]] ||[dictionary count] == 0 )? 1: 0)

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_WIDTH_TO375_PROPERTION (SCREEN_WIDTH/375.0)

#define SCREEN_SCALE [UIScreen mainScreen].scale
#define SCREEN_HEIGHT_PX ([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale)
#define SCREEN_WIDTH_PX  ([UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale)

#ifndef __OPTIMIZE__
//#define NSLog(format, ...) NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d]" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#define NSLog(format, ...) NSLog((format @" -->line:%d fun:%s"  ),##__VA_ARGS__,__LINE__, __FUNCTION__  )
#else
#define NSLog(...){}
#endif


typedef NS_ENUM(NSInteger,CommonEnumSexTypes) {
    CommonEnumSexTypeMale = 1, //男
    CommonEnumSexTypeFemale = 2 //女
};

#define APPDelegate ((AppDelegate*)[[UIApplication sharedApplication]delegate])

#define AppBaseBackgroundColor 0xE4564A
//#define APPNetImageDowningPlaceHolder @"noImage"
#define APPNetImageDowningPlaceHolder @"network_image_default"

#define AppViewCommonColor 0xffbc44

#define AppViewBottomLineColor 0x999999
#define AppViewBottomLineWidth 0.3f
/**
 *  自定义通知
 *
 */
//app进入前台/后台
#define Notification_Name_AppEnterForeground @"Notification_Name_AppEnterForeground"
#define Notification_Name_AppEnterBackground @"Notification_Name_AppEnterBackground"
//用户登录/退出
#define Notification_Name_UserLogin @"Notification_Name_UserLogin"
#define Notification_Name_UserLogout @"Notification_Name_UserLogout"
//用户修改密码/修改手机号/基本信息
#define Notification_Name_UserChangePassword @"Notification_Name_UserChangePassword"
#define Notification_Name_UserChangeMobile @"Notification_Name_UserChangeMobile"
#define Notification_Name_UserChangeBaseInfo @"Notification_Name_UserChangeBaseInfo"

//手动添加书成功
#define Notification_Name_InputAddBookSuccess @"Notification_Name_InputAddBookSuccess"
//Appdelegate获取地理位置成功通知
#define Notification_Name_AppDelegeteGetlocationSuccess @"Notification_Name_AppDelegeteGetlocationSuccess"
//圈子发布补丁成功通知
#define Notification_Name_PatchSendSuccess @"Notification_Name_PatchSendSuccess"
//圈子添加评论成功通知
#define Notification_Name_PatchAddCommentSuccess @"Notification_Name_PatchAddCommentSuccess"
//添加书友成功通知
#define Notification_Name_AddBookFriendSuccess @"Notification_Name_AddBookFriendSuccess"
//加入书友会成功通知
#define Notification_Name_AttendBookClubSuccess @"Notification_Name_AttendBookClubSuccess"

//环信 聊天会话改变
#define Notification_Name_ChatConversationChanged @"Notification_Name_ChatConversationChanged"

//消息 用户通知消息改变
#define Notification_Name_UserNoticeChanged @"Notification_Name_UserNoticeChanged"

//消息 用户通知消息请求数据完成
#define Notification_Name_UserNoticeRequestFinish @"Notification_Name_UserNoticeRequestFinish"

//消息 个推收到远程通知
#define Notification_Name_GeTuiRemoteNotification @"Notification_Name_GeTuiRemoteNotification"

//消息 加入群成功
#define Notification_Name_AddGroupSuccess @"Notification_Name_AddGroupSuccess"

//群组活动 用户已查看群组活动
#define Notification_Name_GroupEventNoticeSuccess @"Notification_Name_GroupEventNoticeSuccess"

#define UseTestData 1

/**
 *  服务器地址
 *
 */
//测试
#define APPBaseURL @"http:"




