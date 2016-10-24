//
//  GTLoginDTO.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTLoginParams : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password;

@end

@interface GTLoginUserInfo : NSObject

@property (nonatomic, copy) NSString *student_id;
@property (nonatomic, copy) NSString *student_name;
@property (nonatomic, copy) NSString *class_id;
@property (nonatomic, copy) NSString *class_name;
@property (nonatomic, copy) NSString *student_head;
@property (nonatomic, copy) NSString *student_sex;

@end

@interface GTLoginDTO : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, strong) GTLoginUserInfo *data;

@end
