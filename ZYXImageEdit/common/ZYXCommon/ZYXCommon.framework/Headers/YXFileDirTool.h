//
//  FlieDirTool.h
//  YXebookReader
//
//  Created by BZBY on 15/11/27.
//  Copyright (c) 2015年 BZBY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXFileDirTool : NSObject
/**
 *  获取沙河目录
 *
 *  @return 沙河目录
 */
+(NSString*)getHomeDoumentsPath;
/**
 *  获取沙河目录下的目录
 *
 *  @param path 相对沙河目录的路径
 *
 *  @return 沙河目录下目录完整路径
 */
+(NSString*)getDirctoryInHomeDocumentsWithPath:(NSString*)path;
/**
 *  获取沙河目录下的文件完整路径
 *
 *  @param fileName 文件名
 *
 *  @return 文件完整路径
 */
+(NSString*)getFilePathInHomeDocumentsWithFileName:(NSString*)fileName;
/**
 *  获取某个目录下的文件完整路径 ，如果目录不存在就创建目录
 *
 *  @param fileName 文件名
 *  @param dirctory 目录完整路径
 *
 *  @return 文件完整路径
 */
+(NSString*)getFilePathWithFileName:(NSString*)fileName InDirctory:(NSString*)dirctory;
@end
