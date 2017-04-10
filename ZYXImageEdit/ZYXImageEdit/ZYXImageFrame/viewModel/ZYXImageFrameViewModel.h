//
//  ZYXImageFrameViewModel.h
//  TourNote
//
//  Created by 极客天地 on 2017/3/7.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "GWRootViewModel.h"
#import "ZYXImageFrameModel.h"
@interface ZYXImageFrameViewModel : GWRootViewModel
@property(strong,nonatomic) NSMutableArray<ZYXImageFrameModel*> * simpleImageFrameModelArray;
@property(strong,nonatomic) NSMutableArray<ZYXImageFrameModel*> * goodImageFrameModelArray;
@end
