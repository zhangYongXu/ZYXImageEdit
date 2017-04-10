//
//  RootViewModel.h
//  LuNengHotel
//
//  Created by 拓之林 on 16/3/28.
//  Copyright © 2016年 拓之林. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^YXSuccessBlock)(id object);
typedef void(^YXFaildBlock)(id object);


@interface RootViewModel : NSObject
-(void)initData;
@end
