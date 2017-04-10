//
//  ZYXCutPathView.m
//  TourNote
//
//  Created by 极客天地 on 2017/2/22.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "ZYXCutPathView.h"
@interface ZYXCutPathView()

@end
@implementation ZYXCutPathView

-(void)drawRect:(CGRect)rect{
    //[super drawRect:rect];
    [self.color setStroke];
    [self.path stroke];
}

@end
