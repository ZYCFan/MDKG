//
//  UserCenter.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/27.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "UserCenter.h"

static NSString *const USER_DATA = @"p2pUser.data";
@implementation UserCenter
IMP_SINGLETON(UserCenter);

#pragma mark - public method

- (NSString *)takeUserAccount {
    return [[[SAMKeychain accountsForService:SERVICE_NAME] lastObject] valueForKey:@"acct"];
}

- (NSString *)takeUserPassword {
    NSString *account = [[[SAMKeychain accountsForService:SERVICE_NAME] lastObject] valueForKey:@"acct"];
    return [SAMKeychain passwordForService:SERVICE_NAME account:account];
}

- (void)savePasswordAndAccount {
    NSString *account = [[[SAMKeychain accountsForService:SERVICE_NAME] lastObject] valueForKey:@"acct"];
    if (account) {
        [SAMKeychain deletePasswordForService:SERVICE_NAME account:account];
    }
    if (self.userInfo) {
        BOOL success = [SAMKeychain setPassword:self.userInfo.userPassword forService:SERVICE_NAME account:self.userInfo.userName];
        if (success) {
            
        } else {
            NSAssert(success, @"保存用户名和密码失败!");
        }
    }
}

- (void)deletePasswordAndAccount {
    NSString *account = [[[SAMKeychain accountsForService:SERVICE_NAME] lastObject] valueForKey:@"acct"];
    BOOL success = [SAMKeychain deletePasswordForService:SERVICE_NAME account:account];
    if (!success) {
        NSAssert(success, @"删除用户名和密码失败!");
    }
}

- (void)deleteUserInfoWhenLoginOut {
    [self deletePasswordAndAccount];
    [[ZYCArchiveHelper sharedInstance] deleteArchiveFileWithFileName:USER_DATA];
}

- (UserInfoDTO *)loadSavedUserInfo {
    UserInfoDTO *userData = [[ZYCArchiveHelper sharedInstance] unArchiveObjectWithFileName:USER_DATA];
    return userData ? userData : nil;
}

- (void)replaceUserHeadImageUrl:(NSString *)url {
    UserInfoDTO *userData = [[ZYCArchiveHelper sharedInstance] unArchiveObjectWithFileName:USER_DATA];
    if (userData) {
        userData.userHeadUrl = url;
        [[ZYCArchiveHelper sharedInstance] deleteArchiveFileWithFileName:USER_DATA];
        [[ZYCArchiveHelper sharedInstance] archiveObject:userData fileName:USER_DATA];
    }
}

#pragma mark - setter
- (void)setUserInfo:(UserInfoDTO *)userInfo {
    _userInfo = userInfo;
    if (userInfo) {
       [[ZYCArchiveHelper sharedInstance] archiveObject:userInfo fileName:USER_DATA];
    }
}


#pragma mark - getter
- (BOOL)isLogined {
    if ([self loadSavedUserInfo]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)userId {
    UserInfoDTO *currentUser = [self loadSavedUserInfo];
    return currentUser ? currentUser.userId : nil;
}

- (NSString *)classId {
    UserInfoDTO *currentUser = [self loadSavedUserInfo];
    return currentUser ? currentUser.classId : nil;
}

- (NSString *)headImageUrl {
    UserInfoDTO *currentUser = [self loadSavedUserInfo];
    return currentUser ? currentUser.userHeadUrl : nil;
}

- (NSString *)token {
    UserInfoDTO *currentUser = [self loadSavedUserInfo];
    return currentUser ? currentUser.userToken : nil;
}

@end
