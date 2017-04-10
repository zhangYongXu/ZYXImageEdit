//
//  NSString+ITTAdditions.h
//
//  Created by Jack on 11-9-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (ITTAdditions)

- (CGFloat)heightWithFont:(UIFont*)font
            withLineWidth:(NSInteger)lineWidth;
- (CGFloat)widthWithFont:(UIFont*)font
            withLineHeight:(NSInteger)lineHeight;

- (NSString*)stringByAddingURLQuery:(NSDictionary*)query;
- (BOOL)isBlank;
- (BOOL)isNum ;
/**
 *  @author zhipeng, 15-04-01 11:04:11
 *
 *  将字典转成json字符串
 *
 *  @param dictionary 字典对象
 *
 *  @return json字符串
 */
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
/**
 *  @author zhipeng, 15-04-01 12:04:46
 *
 *  将数组转成字符串
 *
 *  @param array 数组对象
 *
 *  @return json字符串
 */
+(NSString *) jsonStringWithArray:(NSArray *)array;
- (NSString *) md5;
- (NSString *) sha1;
-(NSString*)encodeString;
- (NSDictionary *) dictionaryWithDictionaryString;
/**
 *  @author zhipeng, 15-03-19 14:03:27
 *
 *  判断手机号码是否正确
 *
 *  @param mobileNum 手机号码
 *
 *  @return 是否正确
 */
+(BOOL)validateMobile:(NSString *)mobileNum;
/**
 *  对maskSring标记颜色和字体 返回属性字符串
 *
 *  @param maskString 需要标记的字符串
 *  @param color      字符串颜色
 *  @param maskColor  标记字符串颜色
 *  @param font       字符串字体
 *  @param maskFont   标记字符串字体
 *
 *  @return 属性字符串
 */
-(NSAttributedString*)attributedStringWithMaskString:(NSString*)maskString Color:(UIColor*)color  MaskColor:(UIColor*)maskColor  Font:(UIFont*)font MaskFont:(UIFont*)maskFont;

-(bool)isContainChinese;

-(BOOL)isValidateEmail ;

- (BOOL)isValidateMobileNumber;

+(NSString *)filterHTML:(NSString *)html;
@end

