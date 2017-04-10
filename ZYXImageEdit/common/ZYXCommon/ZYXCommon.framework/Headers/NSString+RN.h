//
//  NSString+RN.h
//  bzbyTeacher
//
//  Created by BZBY on 15/4/8.
//  Copyright (c) 2015年 bzby. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FileSuffixType) {
    FileSuffixTypeNuknow = -1,
    FileSuffixTypeVideo = 0,
    FileSuffixTypeAudio = 1,
    FileSuffixTypePicture = 2,
    FileSuffixTypeDocument =3
    
};


@interface NSString (RN)
+(NSString*)randomName;
+(NSString*)randomPhoneNumber;
+(NSDate*)randomDateWithStartDate:(NSDate*)startDate WithEndDate:(NSDate*)endDate;
+(NSString*)randomDigitalLetter;
+(NSString*)randomStr;
+(NSString*)randomStrWithMaxLength:(NSInteger)maxLength;
+(NSString*)randomImageUrl;
-(FileSuffixType)getFileType;

@end
