//
//  UILabel+WordClick.h
//  PPLabel
//
//  Created by BZBY on 15/8/21.
//  Copyright (c) 2015年 Petr Pavlik. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^WordClickBlock)(UITapGestureRecognizer* tapGeture,NSInteger index,NSString * word);
typedef void(^HandleBlock)(UILongPressGestureRecognizer * longPressGeture,NSInteger index,NSString * word);
@interface UILabel (WordClick)
@property (strong,nonatomic) UIColor * highLightedColor;
@property (copy,nonatomic) NSString * separatedString;
-(void)addWordClickWithWordClickBlock:(WordClickBlock)wordClickBlock;
-(void)addWordLongPressHandleBlock:(HandleBlock)longPressHandleblock;

- (void)removeHighlight;

@end

@interface WordClickManager : NSObject
@property (copy,nonatomic) WordClickBlock wordClickBlock;
@property (copy,nonatomic) HandleBlock longPressHandleblock;
@property (copy,nonatomic) NSString * separatedString;
@property (strong,nonatomic) UIColor * highLightedColor;


@property(assign,nonatomic) NSRange highlightedRange;
@end
