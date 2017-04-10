//
//  GWRootNavigationViewController.h
//  AllPeopleReading
//
//  Created by 极客天地 on 16/11/28.
//  Copyright © 2016年 极客天地. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWRootNavigationViewController : UINavigationController
+(NSMutableArray*)navitionVCArray;
@end
@interface GWRootNavigationViewControllerManager : NSObject

@property(strong,nonatomic)NSMutableArray * navigationVCArray;
+(GWRootNavigationViewControllerManager *)shareInstance;
@end
