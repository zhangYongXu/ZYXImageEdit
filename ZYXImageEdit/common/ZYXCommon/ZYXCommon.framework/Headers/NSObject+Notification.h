//
//  NSObject+Notification.h
//  BoBo
//
//  Created by BZBY on 15/8/17.
//  Copyright (c) 2015年 bzby. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^NotificationBlock) (NSString*name,id object);
@interface NSObject (Notification)
-(void)addNotificationWithName:(NSString*)name NotificationBlock:(NotificationBlock)notificationBlock;
-(void)postNotificationWithName:(NSString*)name Object:(id)object;
-(void)removeNotificationWithName:(NSString*)name;
-(void)removeAllNotification;
@end


@interface NotificationManager : NSObject
@property (strong,nonatomic) NSMutableDictionary* receiverDict;

+(NotificationManager*)notificationManager;

@end

@interface NotificationReceiver : NSObject
@property (copy,nonatomic) NotificationBlock notificationBlock;
@end

