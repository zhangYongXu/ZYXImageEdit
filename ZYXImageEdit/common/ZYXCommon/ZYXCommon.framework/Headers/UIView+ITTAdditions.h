//
//  UIView+ITTAdditions.h
//  iTotemFrame
//
//  Created by jack 廉洁 on 3/15/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^ITTViewSingleTapGetureBlock)(UITapGestureRecognizer * tapGeture);
typedef void(^ITTViewUnvisibleButtonBlock)(UIButton * button);

typedef NS_ENUM(NSInteger,BorderLinePositions) {
    BorderLinePositionTop = 0,
    BorderLinePositionLeft = 1,
    BorderLinePositionBottom = 2,
    BorderLinePositionRight = 3
};


@interface UIView (ITTAdditions)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationHeight;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 * Calculates the offset of this view from another view in screen coordinates.
 *
 * otherView should be a parent view of this view.
 */
- (CGPoint)offsetFromView:(UIView*)otherView;

- (void)halfSize;

- (UIViewController*)viewController;
+ (UIView*)findFirstResponderInView:(UIView*)topView;
+ (CGPoint)converPointWithSuperView:(UIView*)superView view:(UIView*)view point:(CGPoint)point;
- (UIView*)subviewWithClass:(Class)sClass;
/*
 
 */
-(void)addTapGetureWithBlock:(ITTViewSingleTapGetureBlock)singleTapGetureBlock;
-(void)addUnvisibleButtonWithFrame:(CGRect)frame UnvisibleButtonBlock:(ITTViewUnvisibleButtonBlock)unvisibleButtonBlock;



- (void)startRotationWithDuration:(CGFloat)duration;
- (void)endRotation;


/**
 *  给视图上下左右四个方向边框实线
 *
 *  @param position 上下左右位置
 *  @param color    颜色
 *  @param width    线宽
 */
- (void)drawBorderSolidLineWithPosition:(BorderLinePositions)position Color:(UIColor*)color Width:(CGFloat)width;
/**
 *  给视图上下左右四个方向边框虚线
 *
 *  @param position 上下左右位置
 *  @param color    颜色
 *  @param width    线宽
 *  @param dotWidth 虚线段宽度
 *  @param dotSpace 虚线段间隙
 */
- (void)drawBorderDottedLineWithPosition:(BorderLinePositions)position Color:(UIColor*)color Width:(CGFloat)width DotWidth:(CGFloat)dotWidth DotSpace:(CGFloat)dotSpace;

/**
 *  根据俩个起止点画实线
 *
 *  @param startPoint   起始点
 *  @param endPoint     截止点
 *  @param color        颜色
 *  @param width        线宽
 */
-(void)drawSolidLineWithStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint Color:(UIColor *)color Width:(CGFloat)width;
/**
 *  根据俩个起止点画虚线
 *
 *  @param startPoint   起始点
 *  @param endPoint     截止点
 *  @param color        颜色
 *  @param width        线宽
 *  @param dotWidth 虚线段宽度
 *  @param dotSpace 虚线段间隙
 */
-(void)drawDottedLineWithStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint Color:(UIColor *)color Width:(CGFloat)width DotWidth:(CGFloat)dotWidth DotSpace:(CGFloat)dotSpace;

@end
@interface ITTViewManager : NSObject
@property (copy,nonatomic) ITTViewSingleTapGetureBlock singleTapGetureBlock;
@property (copy,nonatomic) ITTViewUnvisibleButtonBlock unvisibleButtonBlock;

@property(strong,nonatomic) NSMutableDictionary * borderLineLayerDict;
@end
