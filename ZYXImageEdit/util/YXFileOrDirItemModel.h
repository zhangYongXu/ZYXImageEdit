//
//  YXFileOrDirItemModel.h
//  FileManager
//
//  Created by BZBY on 15/5/13.
//  Copyright (c) 2015年 BZBY. All rights reserved.
//
static NSString * YXDocumentDir;
@interface YXFileOrDirItemModel : RootModel
@property (copy,nonatomic) NSString * serial;
@property (copy,nonatomic) NSString * name;
@property (copy,nonatomic) NSString * suffix;
@property (copy,nonatomic) NSString * createTime;
@property (copy,nonatomic) NSString * modifyTime;
@property (copy,nonatomic) NSString * fullPath;
@property (copy,nonatomic) NSString * shortPath;
@property (assign,nonatomic)NSNumber * size;
@property (assign,nonatomic)BOOL isDir;
@property (copy,nonatomic) NSString * lrcFullPath;
@property (assign,nonatomic) BOOL isMyFavorite;

@property (assign,nonatomic) BOOL isUsedHandle;



+ (YXFileOrDirItemModel*)fileOrDirItemModelWithPath:(NSString*)fullPath;
+ (NSArray<YXFileOrDirItemModel*>*)scanDirectory:(NSString*)path;
#pragma mark 递归读取path目录下的所有文件
+(NSArray<YXFileOrDirItemModel*> *)getAllFilesInPath:(NSString*)path;
+ (NSArray<YXFileOrDirItemModel*>*)getAllFilesInUserHomeDir;
+ (NSArray*)getMusicFileInUserHomeDir;
+ (NSArray*)getVideoFileInUserHomeDir;
+ (NSArray*)getShortVideoFileInUserHomeDir;

@end
