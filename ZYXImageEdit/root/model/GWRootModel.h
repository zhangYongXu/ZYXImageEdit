//
//  GWRootModel.h
//  AllPeopleReading
//
//  Created by 极客天地 on 16/8/3.
//  Copyright © 2016年 极客天地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZYXCommon/RootModel.h>
@interface GWRootModel : RootModel
+(NSArray<NSDictionary*> *)propertyListArrayWithModelArray:(NSArray<GWRootModel*>*)modelArray IsIncludeValue:(BOOL)isIncludeValue;
@end
