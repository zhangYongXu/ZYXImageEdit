//
//  NSAttributedString+ZYX.h
//  AllPeopleReading
//
//  Created by 极客天地 on 17/1/5.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (ZYX)
-(CGFloat)heightWithLineWidth:(NSInteger)lineWidth;
-(CGFloat)widthWithLineHeight:(NSInteger)lineHeight;
@end
