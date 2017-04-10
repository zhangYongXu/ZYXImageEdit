//
//  UIImageView+URL.h
//  bzbyParents
//
//  Created by BZBY on 15/5/5.
//  Copyright (c) 2015年 bzby. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ImageDownloadComplete)(UIImage* image);
@interface UIImageView (URL)
/**
 *  为UIImageView设置网络图片
 *
 *  @param url 图片url
 */
- (void)setImageWithUrl:(NSURL*)url;
/**
 *  为UIImageView设置网络图片
 *
 *  @param url         图片url
 *  @param placeholder 默认图片
 */
- (void)setImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)placeholder;
/**
 *  为UIImageView设置网络图片
 *
 *  @param url                   图片url
 *  @param imageDownloadComplete 图片下载完成回调
 */
- (void)setImageWithUrl:(NSURL*)url ImageDownloadComplete:(ImageDownloadComplete)imageDownloadComplete;
/**
 *  为UIImageView设置网络图片
 *
 *  @param url                   图片url
 *  @param placeholder           默认图片
 *  @param imageDownloadComplete 图片下载完成回调
 */
- (void)setImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)placeholder ImageDownloadComplete:(ImageDownloadComplete)imageDownloadComplete;
/**
 *  根据url缓存图片
 *
 *  @param image 图片
 *  @param url   图片url
 */
+(void)cacheNetImage:(UIImage*)image WithUrl:(NSURL*)url;
/**
 *  根据url获取对应缓存图片
 *
 *  @param url 图片url
 *
 *  @return 图片
 */
+(UIImage*)getCacheImageWithUrl:(NSURL*)url;
/**
 *  设置清除缓存间隔时间
 *
 *  @param timeIntervalDays 清除缓存间隔时间
 */
+(void)setClearCacheTimeIntervalDays:(NSInteger)timeIntervalDays;
@end
