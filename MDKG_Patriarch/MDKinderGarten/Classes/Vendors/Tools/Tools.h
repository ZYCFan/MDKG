//
//  MCTools.h
//  MovieCircle
//
//  Created by 孙宇强 on 15/6/28.
//  Copyright (c) 2015年 dzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
DEF_SINGLETON(Tools)

+ (UIColor *)colorWithHex:(NSInteger)rgbValue;
+ (NSString *)base64forData:(NSData *)theData;
+ (NSString *)urlBase64forData:(NSData *)theData;
+ (BOOL)checkPassword:(NSString *)text;
+ (BOOL)checkMobileNumber:(NSString *)mobileNum;
+ (BOOL)isEmailAddress:(NSString *)email;
+ (NSString *)countDownWithEndDate:(NSString *)endDateStr;
+ (NSDateComponents *)coutDownWithDate:(NSString *)endDateStr;
+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
/**
 *  16进制颜色(html颜色值)字符串转为UIColor
 *
 *  @param stringToConvert 16进制颜色(html颜色值)
 *
 *  @return UIColor
 */
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;
+ (UIImage *)createImageWithColor:(UIColor *)color;
@end

