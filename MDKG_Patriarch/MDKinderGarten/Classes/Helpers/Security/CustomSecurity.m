//
//  MCCustomSecurity.m
//  MovieCircle
//
//  Created by zhouyongchao on 15/12/23.
//  Copyright (c) 2015年 dzy. All rights reserved.
//

#import "CustomSecurity.h"
#import "RSAEncryptor.h"

@implementation CustomSecurity

+ (NSString *)rasDectypt:(NSString *)encryptText
{
    RSAEncryptor *rsa = [[RSAEncryptor alloc] init];
    [rsa loadPrivateKeyFromFile:[[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"] password:@"Dao1234"];
    NSString *decryptedString = [rsa rsaDecryptString:encryptText];
    return decryptedString;
}

+ (NSString *)rasEncrypt:(NSString *)plainText
{
    RSAEncryptor *rsa = [[RSAEncryptor alloc] init];
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    [rsa loadPublicKeyFromFile:publicKeyPath];
    NSString *encryptedString = [rsa rsaEncryptString:plainText];
    return encryptedString;
}

@end
