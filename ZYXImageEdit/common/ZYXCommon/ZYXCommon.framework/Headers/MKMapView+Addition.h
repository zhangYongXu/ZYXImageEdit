//
//  MKMapView+Addition.h
//  LuNengHotel
//
//  Created by 拓之林 on 16/4/11.
//  Copyright © 2016年 拓之林. All rights reserved.
//

#import <MapKit/MapKit.h>
typedef void (^SuccessGetLocationBlock)(CLLocation * location,CLPlacemark * placemark);
typedef void (^FaildGetLocationBlock)(NSError * error);
@interface MKMapView (Addition)
/**
 *  百度地图坐标转火星坐标
 *
 *  @param coordinate 百度地图坐标
 *
 *  @return 火星坐标
 */
+ (CLLocationCoordinate2D)locationMarsFromBaidu:(CLLocationCoordinate2D)coordinate;
/**
 *  火星坐标转百度地图坐标
 *
 *  @param coordinate 火星坐标
 *
 *  @return 百度地图坐标
 */
+ (CLLocationCoordinate2D)locationBaiduFromMars:(CLLocationCoordinate2D)coordinate;
/**
 *  获取当前位置
 *
 *  @param successBlock 成功回调
 *  @param faildBlock   失败回调
 */
+(void)getLocationWithSuccessBlock:(SuccessGetLocationBlock)successBlock FaildBlock:(FaildGetLocationBlock)faildBlock;
@end

@interface MapViewCategoryManager : NSObject
@property (strong, nonatomic)  MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager * locationManager;

@property (copy,nonatomic)SuccessGetLocationBlock successBlock;
@property (copy,nonatomic)FaildGetLocationBlock faildBlock;
@end
