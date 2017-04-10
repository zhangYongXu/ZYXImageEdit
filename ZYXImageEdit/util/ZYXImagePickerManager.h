//
//  ZYXImagePickerManager.h
//  TourNote
//
//  Created by 极客天地 on 2017/3/8.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^ZYXImagePickerCompleteBlock) (UIImage * image);
@interface ZYXImagePickerManager : NSObject
+(void)showImagePickerWithSorceType:(UIImagePickerControllerSourceType)sourceType CompleteBlock:(ZYXImagePickerCompleteBlock)completeBlock;
@end
