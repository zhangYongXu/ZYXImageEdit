//
//  UIColor+ZYX.h
//  TourNote
//
//  Created by 极客天地 on 17/1/19.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZYX)
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (NSString*) changeToHexStringWithUIColor:(UIColor *)color;
@end
