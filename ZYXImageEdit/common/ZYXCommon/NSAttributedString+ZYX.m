//
//  NSAttributedString+ZYX.m
//  AllPeopleReading
//
//  Created by 极客天地 on 17/1/5.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "NSAttributedString+ZYX.h"

@implementation NSAttributedString (ZYX)
-(CGFloat)heightWithLineWidth:(NSInteger)lineWidth{
    CGSize size = CGSizeZero;
    CGSize rSize = CGSizeMake(lineWidth, NSUIntegerMax);

    CGRect rect = [self boundingRectWithSize:rSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    size = rect.size;

    return size.height;
}
-(CGFloat)widthWithLineHeight:(NSInteger)lineHeight{
    CGSize size = CGSizeZero;
    CGSize rSize = CGSizeMake(NSUIntegerMax, lineHeight);

    CGRect rect = [self boundingRectWithSize:rSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    size = rect.size;

    return size.width;
}
@end
