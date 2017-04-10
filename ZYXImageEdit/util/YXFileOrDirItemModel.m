//
//  YXFileOrDirItemModel.m
//  FileManager
//
//  Created by BZBY on 15/5/13.
//  Copyright (c) 2015年 BZBY. All rights reserved.
//

#import "YXFileOrDirItemModel.h"




@implementation YXFileOrDirItemModel
+(void)load{
    [super load];
}
+(void)initialize{
    [super initialize];
    [self documentDir];
}
+(NSString *)documentDir{
    if(STR_IS_NIL(YXDocumentDir)){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDir = [paths objectAtIndex:0];
        YXDocumentDir = documentDir;
    }
    return YXDocumentDir;
}
-(instancetype)init{
    if(self = [super init]){
        self.isUsedHandle = NO;
        self.isMyFavorite = NO;
    }
    return self;
}


+ (YXFileOrDirItemModel *)fileOrDirItemModelWithPath:(NSString *)fullPath{
    YXFileOrDirItemModel * model = nil;
    NSFileManager * FM = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL isExist = [FM fileExistsAtPath:fullPath isDirectory:&isDir];
    if (isExist){
        model = [[YXFileOrDirItemModel alloc] init];
        model.name = [[fullPath lastPathComponent] stringByDeletingPathExtension];
        model.suffix = [fullPath pathExtension];
        model.shortPath = [[fullPath componentsSeparatedByString:@"/Documents"] lastObject];
        model.fullPath = fullPath;
        NSError * aError;
        NSDictionary * fileAttributeDic=[FM attributesOfItemAtPath:fullPath error:&aError];
        if(aError){
            NSLog(@"读取路径属性错误：%@",aError);
        }else{
            //NSLog(@"fileAttriButeDic is %@",fileAttributeDic);
        }
        model.size = [fileAttributeDic objectForKey:NSFileSize];
//        model.createTime = [[[[fileAttributeDic objectForKey:NSFileCreationDate] description] componentsSeparatedByString:@"+"] firstObject];
//        model.modifyTime = [[[[fileAttributeDic objectForKey:NSFileModificationDate] description] componentsSeparatedByString:@"+"] firstObject];
        model.createTime = [[fileAttributeDic objectForKey:NSFileCreationDate] description];
        model.modifyTime =[[fileAttributeDic objectForKey:NSFileModificationDate] description];
        
        if(isDir){
            model.isDir = YES;
        }else{
            model.isDir = NO;
        }
    }else{
        NSLog(@"路径不正确:%@",fullPath);
    }
    return model;
}
#pragma mark 扫描目录
+ (NSArray<YXFileOrDirItemModel*>*)scanDirectory:(NSString*)path{
    NSFileManager * FM = [NSFileManager defaultManager];
    NSError * error = nil;
    NSString * appDocDir = path;
    NSArray *contentOfFolder = [FM contentsOfDirectoryAtPath:appDocDir error:&error];
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for (NSString *aPath in contentOfFolder) {
        //NSLog(@"apath: %@", aPath);
        NSString * fullPath = [appDocDir stringByAppendingPathComponent:aPath];
        
        BOOL isDir;
        BOOL isExist = [FM fileExistsAtPath:fullPath isDirectory:&isDir];
        if (isExist){
            YXFileOrDirItemModel * model = [[YXFileOrDirItemModel alloc] init];
            model.name = [aPath stringByDeletingPathExtension];
            model.suffix = [aPath pathExtension];
            model.fullPath = fullPath;
            
            NSError * aError;
            NSDictionary * fileAttributeDic=[FM attributesOfItemAtPath:fullPath error:&aError];
            if(aError){
                NSLog(@"读取路径属性错误：%@",aError);
            }else{
                //NSLog(@"fileAttriButeDic is %@",fileAttributeDic);
            }
            model.size = [fileAttributeDic objectForKey:NSFileSize];

            model.createTime = [[fileAttributeDic objectForKey:NSFileCreationDate] description];
            model.modifyTime =[[fileAttributeDic objectForKey:NSFileModificationDate] description];
            
            if(isDir){
                model.isDir = YES;
                [array insertObject:model atIndex:0];
            }else{
                model.isDir = NO;
                [array addObject:model];
            }
            
        }else{
            NSLog(@"路径不正确:%@",fullPath);
        }
    }
    return array;
}
#pragma mark 递归读取path目录下的所有文件
+(NSArray<YXFileOrDirItemModel*> *)getAllFilesInPath:(NSString*)path{
    NSFileManager * FM = [NSFileManager defaultManager];
    NSError * error = nil;
    NSString * appDocDir = path;
    NSArray *contentOfFolder = [FM contentsOfDirectoryAtPath:appDocDir error:&error];
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for (NSString *aPath in contentOfFolder) {
        //NSLog(@"apath: %@", aPath);
        NSString * fullPath = [appDocDir stringByAppendingPathComponent:aPath];
        
        BOOL isDir;
        BOOL isExist = [FM fileExistsAtPath:fullPath isDirectory:&isDir];
        if (isExist){
            NSError * aError;
            NSDictionary * fileAttributeDic=[FM attributesOfItemAtPath:fullPath error:&aError];
            if(aError){
                NSLog(@"读取路径属性错误：%@",aError);
            }else{
                //NSLog(@"fileAttriButeDic is %@",fileAttributeDic);
            }
        
            if(isDir){
                NSArray * a = [self getAllFilesInPath:fullPath];
                [array addObjectsFromArray:a];
            }else{
                YXFileOrDirItemModel * model = [[YXFileOrDirItemModel alloc] init];
                model.name = [aPath stringByDeletingPathExtension];
                model.suffix = [aPath pathExtension];
                model.fullPath = fullPath;
                model.size = [fileAttributeDic objectForKey:NSFileSize];

                model.createTime = [[fileAttributeDic objectForKey:NSFileCreationDate] description];
                model.modifyTime =[[fileAttributeDic objectForKey:NSFileModificationDate] description];
                model.isDir = NO;
                [array addObject:model];
            }
            
        }else{
            NSLog(@"路径不正确:%@",fullPath);
        }
    }
    return array;
}

+(NSArray *)getAllFilesInUserHomeDir{
    NSString * userHomePath = YXDocumentDir;
    return [self getAllFilesInPath:userHomePath];
}
+(NSArray *)getMusicFileInUserHomeDir{
    NSString * userHomePath = YXDocumentDir;
    NSArray * array = [self getAllFilesInPath:userHomePath];
    NSMutableArray * a = [[NSMutableArray alloc] init];
    for(YXFileOrDirItemModel * m in array){
        if(FileSuffixTypeAudio == [m.suffix getFileType]){
            [a addObject:m];
        }
    }
    return a;
}
+(NSArray *)getVideoFileInUserHomeDir{
    NSString * userHomePath = YXDocumentDir;
    NSArray * array = [self getAllFilesInPath:userHomePath];
    NSMutableArray * a = [[NSMutableArray alloc] init];
    for(YXFileOrDirItemModel * m in array){
        if(FileSuffixTypeVideo == [m.suffix getFileType]){
            [a addObject:m];
        }
    }
    return a;
}
+(NSArray *)getShortVideoFileInUserHomeDir{
    NSString * userHomePath = YXDocumentDir;
    NSArray * array = [self getAllFilesInPath:userHomePath];
    NSMutableArray * a = [[NSMutableArray alloc] init];
    for(YXFileOrDirItemModel * m in array){
        if(FileSuffixTypeVideo == [m.suffix getFileType] && [[m.suffix lowercaseString] isEqualToString:@"mp4"]){
            [a addObject:m];
        }
    }
    return a;
}


@end
