//
//  GWRootModel.m
//  AllPeopleReading
//
//  Created by 极客天地 on 16/8/3.
//  Copyright © 2016年 极客天地. All rights reserved.
//

#import "GWRootModel.h"

@implementation GWRootModel
+(NSArray<NSDictionary *> *)propertyListArrayWithModelArray:(NSArray<GWRootModel *> *)modelArray IsIncludeValue:(BOOL)isIncludeValue{
    NSMutableArray * dictArray = [[NSMutableArray alloc] init];
    for(GWRootModel * model in modelArray){
        NSDictionary * dict = [model propertyList:isIncludeValue];
        [dictArray addObject:dict];
    }
    return dictArray;
}
@end
