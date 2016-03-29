//
//  UserAccountManager.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "UserAccountManager.h"
#import "KVStoreManager.h"

static id _userAccountInstance;

@implementation UserAccountManager

// 单例
+ (instancetype)sharedInstance {

    static dispatch_once_t onceDispatch;

    dispatch_once(&onceDispatch, ^{
        _userAccountInstance = [[UserAccountManager alloc] init];
    });

    return _userAccountInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //onceToken是GCD用来记录是否执行过 ，如果已经执行过就不再执行(保证执行一次）
        _userAccountInstance = [super allocWithZone:zone];
    });
    return _userAccountInstance;
}

- (id)copyWithZone:(NSZone *)zone {

    return _userAccountInstance;
}

#pragma mark - action

// 获取当前用户信息
- (NSDictionary *)getCurrentUserInfo {

    KVStoreManager *_kvStoreManger = [KVStoreManager sharedInstance];

    return [_kvStoreManger getAccountInfoWithUid:[_kvStoreManger getCurrentUid]];
}

// 获取当前用户的token
- (NSString *)getCurrentToken {

    KVStoreManager *_kvStoreManger = [KVStoreManager sharedInstance];

    return [_kvStoreManger getTokenWithUid:[_kvStoreManger getCurrentUid]];
}

//判断当前用户是不是顾问
- (BOOL)isGuWenSelf {

    KVStoreManager *_kvStoreManager = [KVStoreManager sharedInstance];

    NSString *userId = [_kvStoreManager getCurrentUid];
    NSDictionary *infoDic = [_kvStoreManager getAccountInfoWithUid:userId];
    NSString *user_type = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"user_type"]];
    return [self isGuWen:user_type];
}

//根据userId判断是不是顾问
- (BOOL)isAdvisorWithUserId:(NSString *)uid {

    KVStoreManager *_kvStoreManager = [KVStoreManager sharedInstance];

    NSDictionary *infoDic = [_kvStoreManager getAccountInfoWithUid:uid];
    NSString *user_type = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"user_type"]];
    return [self isGuWen:user_type];
}

//根据userType判断是不是顾问
- (BOOL)isGuWen:(NSString *)userType {

    if ( [userType isEqualToString:@"顾问"] )
        return YES;
    return NO;
}

- (BOOL)checkLogin {

    NSString *token = [self getCurrentToken];
    if ( [token isBlankString] ) {

        return NO;
    }
    else {

        return YES;
    }
}

@end
