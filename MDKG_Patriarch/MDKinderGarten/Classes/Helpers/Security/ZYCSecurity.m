//
//  ZYCSecurity.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/26.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "ZYCSecurity.h"
#import "CustomSecurity.h"
#import "AESCrypt.h"
#import <CommonCrypto/CommonDigest.h>

static NSString *const DEFAULT_TOKEN = @"default_token";
/**
 *  加密方式 和后台统一
 */
static NSString *const ENCRYPT_TYPE = @"aes";
/**
 *  网络传递参数，字段根据需要修改
 */
static NSString *const PARAMS_USERID = @"userid";
static NSString *const PARAMS_SIGNATURE = @"signature";
static NSString *const PARAMS_NONCE = @"nonce";
static NSString *const PARAMS_TIMESTAMP = @"timestamp";
static NSString *const PARAMS_DATA = @"parameters";
static NSString *const PARAMS_SECRET = @"secret";
/**
 *  网络返回数据，字段根据后台返回数据修改
 */
static NSString *const RETURN_CODE = @"code";
static NSString *const RETURN_MESSAGE = @"message";
static NSString *const RETURN_DATA = @"data";
static NSString *const RETURN_SECRET = @"key";
static NSString *const RETURN_TIMESTAMP = @"timestamp";
static NSString *const RETURN_NONCE = @"nonce";
static NSString *const RETURN_SIGNATURE = @"signature";
static NSString *const RETURN_ENCRYPT = @"encrypttype";

#define CC_MD5_DIGEST_LENGTH    16
@interface ZYCSecurity ()
/**
 *  随机数
 */
@property (copy, nonatomic) NSString *nonce;
/**
 *  时间戳
 */
@property (assign, nonatomic) NSInteger timestamp;

@end

@implementation ZYCSecurity

- (NSMutableDictionary *)encryptParams:(NSMutableDictionary *)params encryptType:(NSString *)type {
    if (!params) {
        params = [NSMutableDictionary dictionary];
    }
    NSMutableDictionary *transParams = [NSMutableDictionary dictionary];
    if (type && [type isEqualToString:ENCRYPT_TYPE]) {//需要加密
        NSString *jsonString = [self dataToJsonString:params];
        //生成key值
        NSString *aesKey = [self generateRandomKey];
        NSString *rasEncryptKey = [CustomSecurity rasEncrypt:aesKey];
        
        //加密json字符串
        NSString *encryptJson = [AESCrypt encrypt:jsonString password:aesKey];
        [transParams setObject:encryptJson forKey:PARAMS_DATA];
        [transParams setObject:rasEncryptKey forKey:PARAMS_SECRET];
    } else { //不需要加密 直接赋参数
        [transParams setObject:params forKey:PARAMS_DATA];
    }
    
    NSString *userId = [self generateUserId];
    NSString *signature = [self generateSignature];
    [transParams setObject:userId forKey:PARAMS_USERID];
    [transParams setObject:signature forKey:PARAMS_SIGNATURE];
    [transParams setObject:self.nonce forKey:PARAMS_NONCE];
    [transParams setObject:[@(self.timestamp) stringValue] forKey:PARAMS_TIMESTAMP];
    
    return transParams;
}

- (NSMutableDictionary *)decryptObject:(NSDictionary *)responseObject {
    NSString *signature = responseObject[RETURN_SIGNATURE];
    NSString *timestamp = responseObject[RETURN_TIMESTAMP];
    NSString *nonce = responseObject[RETURN_NONCE];
    BOOL verifySuccess = [self verifySignatureWithTimestamp:timestamp nonce:nonce originSignature:signature];
    //验证签名成功
    if (verifySuccess) {
        NSString *encryptType = responseObject[RETURN_ENCRYPT];
        //需要解密
        if (encryptType && [encryptType isEqualToString:ENCRYPT_TYPE]) {
            NSString *rasKey = responseObject[RETURN_SECRET];
            NSString *data =  responseObject[RETURN_DATA];
            
            NSString *aesKey = [CustomSecurity rasDectypt:rasKey];
            NSString *aesDecryptData = [AESCrypt decrypt:data password:aesKey];
            if (aesDecryptData) {
                NSData *data = [aesDecryptData dataUsingEncoding:NSUTF8StringEncoding];
                return [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            } else {
                return nil;
            }
        } else {
            //不需要解密
            NSDictionary *data = responseObject[RETURN_DATA];
            return [data mutableCopy];
        }
    } else {
        //验证签名失败
        return nil;
    }
}

#pragma mark -
/**
 *  字典转字符串
 *
 *  @param object 参数字典
 *
 *  @return 返回转换的字符串
 */
- (NSString *)dataToJsonString:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        return @"";
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
/**
 *  生成随机AES秘钥
 *
 *  @return 返回生成的秘钥
 */
- (NSString *)generateRandomKey {
    char data[32];
    for (int x = 0; x < 32; data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc]initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}
/**
 *  生成12位随机字符串
 *
 *  @return 返回随机生成的字符串
 */
- (NSString *)generateRandomString {
    NSString *strRandom = @"";
    for (int i = 0; i < 12; i++) {
        strRandom = [strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    return strRandom;
}
/**
 *  生成Token
 *
 *  @return 返回Token
 */
- (NSString *)generateToken {
    NSString *userToken = [UserCenter sharedInstance].token;
    return userToken ? userToken : DEFAULT_TOKEN;
}
/**
 *  生成用户ID
 *
 *  @return 返回生成的用户Id
 */
- (NSString *)generateUserId {
    NSString *userId = [UserCenter sharedInstance].userId;
    return userId ? userId : @"";
}
/**
 *  生成签名
 *
 *  @return 返回生成的签名
 */
- (NSString *)generateSignature {
    NSString *token = [self generateToken];
    self.nonce = [self generateRandomString];
    self.timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *signature = [NSString stringWithFormat:@"%@%ld%@",token,(long)self.timestamp,self.nonce];
    return [self md5WithStr:signature];
}
/**
 *  MD5加密
 *
 *  @param str 机密字符串
 *
 *  @return 返回加密字符串
 */
- (NSString *)md5WithStr:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    if (cStr) {
        CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
        return [[NSString stringWithFormat:
                 @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                 result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                 result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
                 ] lowercaseString];
    }
    else {
        return nil;
    }
}

#pragma mark - 
- (BOOL)verifySignatureWithTimestamp:(NSString *)timestamp nonce:(NSString *)nonce originSignature:(NSString *)originSignature {
    NSString *token = [self generateToken];
    NSString *signatureStr = [NSString stringWithFormat:@"%@%@%@",token,timestamp,nonce];
    NSString *md5Str = [self md5WithStr:signatureStr];
    return [originSignature isEqualToString:md5Str];
}

@end
