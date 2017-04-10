//
//  RootModel.h
//  bzbyParents
//
//  Created by bzby on 15/3/12.
//  Copyright (c) 2015年 bzby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootModel : NSObject
//数据字典转成模型
/**
 *  用数据字典初始化
 *
 *  @param dictionary 数据字典
 *
 *  @return 模型实例
 */
-(instancetype)initWithDictionary:(NSDictionary*)dictionary;
/**
 *  用数据字典给模型赋值
 *
 *  @param dictionary 数据字典
 */
-(void)setPartAttributes:(NSDictionary*)dictionary;
/*
 *
 *
 * @return 数据字典key与模型属性key映射 如： @{
                                            @"数据字典key1"   : @"模型属性key1",
                                            @"数据字典key2" : @"模型属性key2"
                                         }
 */
//子类具体实现
//模型属性与字典key映射
- (NSDictionary*)propertyKeyMappingDictionary;

/**
 *  获取归档数据
 *
 *  @return 归档数据
 */
- (NSData*)getArchivedData;
/**
 *  解挡数据
 *
 *  @param data 数据
 *
 *  @return 模型
 */
- (instancetype)modelObjcetFromArchiveData:(NSData*)data;
/**
 *  自定义描述
 *
 *  @return 描述字符串
 */
- (NSString *)customDescription;
/**
 *  获得当前对象的所有属性列表，包括父类的属性 depth；父类深度
 *
 *  @param isIncludeValue 是否包含属性对应的值
 *  @param depth          父类层级深度
 *
 *  @return 属性列表字典
 */
- (NSDictionary *)propertyList:(BOOL)isIncludeValue depth:(NSInteger)depth;
/**
 *  获取属性列表
 *
 *  @param isIncludeValue 是否包含属性对应的值
 *
 *  @return 属性列表字典
 */
- (NSDictionary *)propertyList:(BOOL)isIncludeValue;

/**
 *  数据字典数组转模型数组
 *
 *  @param dictArray 数据字典数组
 *
 *  @return 模型数组
 */
+ (NSMutableArray*)modelArrayFromDictArray:(NSArray*)dictArray;

/**
 *  根据模型的属性值将一维数组转化成二位数组
 *
 *  @param oringalArray  原模型一维数组
 *  @param keyPath       属性值keyPath
 *  @param completeBlock 转换完成回调
 */
+ (void)convertModelArrayTo2DArrayWithOringalArray:(NSArray<RootModel*>*)oringalArray ForKeyPath:(NSString*)keyPath CompleteBlock:(void (^)(NSArray * data2DArray,NSArray * keyPathValueArray))completeBlock;
@end
