//
//  JiaMenRootCustomView.h
//  JiaMen
//
//  Created by 极客天地 on 16/6/8.
//  Copyright © 2016年 极客天地. All rights reserved.
//

#import <ZYXCommon/RootCustomView.h>

@interface GWRootCustomView : RootCustomView

@end


@protocol GWRootCustomViewProtocol <NSObject>

@required;
-(void)hiddenViewWithAnimation:(BOOL)animation;

@end
