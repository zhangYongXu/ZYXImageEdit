//
//  ZYXImageFrameViewModel.m
//  TourNote
//
//  Created by 极客天地 on 2017/3/7.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "ZYXImageFrameViewModel.h"

#import "YXFileOrDirItemModel.h"

@implementation ZYXImageFrameViewModel
-(void)initData{
    [self testData];
}
-(void)testData{
    self.simpleImageFrameModelArray = [self imageFrameModelArrayWithDirName:@"简单相框"];
    self.goodImageFrameModelArray = [self imageFrameModelArrayWithDirName:@"精美相框"];
}

-(NSString*)createImageFramePathWithDir:(NSString*)dir{
    NSString * bundlePath = [NSBundle mainBundle].bundlePath;
    NSString * pathTemp = [NSString stringWithFormat:@"elementSelect/imagefame/%@",dir];
    return [bundlePath stringByAppendingPathComponent:pathTemp];
}
-(NSMutableArray<ZYXImageFrameModel*>*)imageFrameModelArrayWithDirName:(NSString*)dirName{
    NSString * dirPath = [self createImageFramePathWithDir:dirName];
    
    NSMutableArray<ZYXImageFrameModel*> * imageFrameModelArray = [[NSMutableArray alloc] init];
    NSArray<YXFileOrDirItemModel*>* fileModelArray = [YXFileOrDirItemModel getAllFilesInPath:dirPath];
    for(YXFileOrDirItemModel * fileModel in fileModelArray){
        ZYXImageFrameModel * imageFrameModel = [[ZYXImageFrameModel alloc] init];
        imageFrameModel.imageLocalPath = fileModel.fullPath;
        [imageFrameModelArray addObject:imageFrameModel];
    }
    
    return imageFrameModelArray;
}
@end
