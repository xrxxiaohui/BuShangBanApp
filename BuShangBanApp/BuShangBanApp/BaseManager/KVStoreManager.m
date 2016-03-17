//
//  KVStoreManager.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "KVStoreManager.h"

#define kMaxSearchHistoryCount 10

#define kStoreDBName @"shunshun.db"
#define kSearchHistoryTableName @"SearchHistoryTable"
#define kCommonObjTableName @"CommonObjTable"
#define kCacheObjTableName @"CacheObjTable"

#define kAccountObjTableName @"AccountObjTable"
#define kTokenObjTableName @"TokenObjTable"

static id _storeInstance;

@implementation KVStoreManager
// 单例
+(instancetype)sharedInstance {
    
    static dispatch_once_t onceDispatch;
    
    dispatch_once(&onceDispatch, ^{
        _storeInstance = [[KVStoreManager alloc] initDBWithName:@"shunshun.db"];
        
        // 通用存储列表
        [_storeInstance createTableWithName:kCommonObjTableName];
        
        // 搜索历史列表
        [_storeInstance createTableWithName:kSearchHistoryTableName];
        
        // 网络请求缓存
        [_storeInstance createTableWithName:kCacheObjTableName];
        
        // 用户信息存储
        [_storeInstance createTableWithName:kAccountObjTableName];
        
        // 用户token
        [_storeInstance createTableWithName:kTokenObjTableName];
    });
    
    return _storeInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //onceToken是GCD用来记录是否执行过 ，如果已经执行过就不再执行(保证执行一次）
        _storeInstance = [super allocWithZone:zone];
    });
    return _storeInstance;
}

-(id)copyWithZone:(NSZone *)zone {
    
    return _storeInstance;
}

#pragma mark - Common Method

// 通用存储方法
-(void)saveObj:(id)obj forKey:(NSString *)key {
    
    if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]) {
        
        if (!key) {
            
            NSLog(@"save to store, key is nil");
            
            return;
        }
        
        // 本地插表
        [_storeInstance putObject:obj withId:key intoTable:kCommonObjTableName];
        
        NSLog(@"saveToStore obj: %@",obj);
    }
    else {
    
        NSLog(@"saveToStore Error obj: %@，obj class: %@",obj,[obj class]);
    }
    
}
// 通用获取方法
-(id)getObjWithKey:(NSString *)key {
    
    if (!key) {
        
        NSLog(@"getObjWithKey , key is nil");
        
        return nil;
    }
    
    id _obj = [_storeInstance getObjectById:key fromTable:kCommonObjTableName];

    return _obj;
}

-(void)deleteObjWithKey:(NSString *)key {

    if (!key) {
        
        NSLog(@"delete ObjWithKey , key is nil");
        
        return ;
    }
    [_storeInstance deleteObjectById:key fromTable:kCommonObjTableName];
}



#pragma mark -- Search History

// 加入最近搜索
-(void)updateSearchHistoryWithString:(NSString *)searchString {
    
    KVStoreManager *_kvStoreManger = [KVStoreManager sharedInstance];
    // 检查 阀值
    NSArray *_tempArr = [_kvStoreManger getAllItemsFromTable:kSearchHistoryTableName];
    
    // 排重
    if ([_tempArr containsObject:searchString]) {
        NSMutableArray *_mutableArr = [_tempArr mutableCopy];
        [_mutableArr removeObject:searchString];
        _tempArr = [_mutableArr copy];
    }
    
    if ([_tempArr count] >= kMaxSearchHistoryCount) {
        YTKKeyValueItem *_firstItem = [_tempArr firstObject];
        [_kvStoreManger deleteObjectById:_firstItem.itemId fromTable:kSearchHistoryTableName];
    }
    // 本地插表
    [_kvStoreManger putObject:@{@"searchString":searchString} withId:searchString intoTable:kSearchHistoryTableName];
}
// 获取最新搜索
-(NSArray *)getSearchHistoryList {

    NSArray *_tempArr = [[KVStoreManager sharedInstance] getAllItemsFromTable:kSearchHistoryTableName];
    
    return [[[_tempArr valueForKey:@"itemObject"] reverseObjectEnumerator] allObjects];
}
// 删除历史记录
-(void)deleteSearchHistory {

    [[KVStoreManager sharedInstance] clearTable:kSearchHistoryTableName];
}

#pragma mark -- Cache Respond

// 加入缓存
-(void)cacheRespondString:(NSString *)resString withRequestUrl:(NSString *)reqUrl withParams:(NSDictionary *)params {
    
    if (!reqUrl) {
        
        NSLog(@"get cache error, reqUrl = ni");
        return ;
    }
    
    if (!resString) {
        
        NSLog(@"get cache error, resString = ni");
        return ;
    }
    
    // 本地插表
    KVStoreManager *_kvStoreManger = [KVStoreManager sharedInstance];
    
    [_kvStoreManger putObject:@{@"respondString":resString} withId:reqUrl intoTable:kCacheObjTableName];
}
// 获取缓存
-(NSString *)getCacheRespondStringWithUrl:(NSString *)reqUrl withParams:(NSDictionary *)params {
    
    if (!reqUrl) {
        NSLog(@"get cache error, reqUrl = ni");
    
        return nil;
    }
    
    KVStoreManager *_kvStoreManger = [KVStoreManager sharedInstance];
    NSDictionary *_respondInfo = [_kvStoreManger getObjectById:reqUrl fromTable:kCacheObjTableName];
    NSString *_respondString = [_respondInfo objectForKey:@"respondString"];
    
    return _respondString;
}
// 删除缓存
-(void)deleteCacheData {

    [[KVStoreManager sharedInstance] clearTable:kCacheObjTableName];
}

#pragma mark -- User Account

// 存储用户信息
-(void)saveAccountWithUserInfo:(NSDictionary *)userInfo withUid:(NSString *)userId {

    if (!userInfo) {
        
        NSLog(@"save account error, userInfo = ni");
        return ;
    }
    
    if (!userId) {
        
        NSLog(@"save account error, userId = ni");
        return ;
    }
    
    KVStoreManager *_kvStoreManger = [KVStoreManager sharedInstance];
    // 本地插表
    [_kvStoreManger putObject:@{@"uid":userId} withId:@"currentUserId" intoTable:kAccountObjTableName];
    [_kvStoreManger putObject:userInfo withId:userId intoTable:kAccountObjTableName];
}
// 获取用户信息
-(NSDictionary *)getAccountInfoWithUid:(NSString *)userId {
    
    if (!userId) {
        NSLog(@"get account info error, uid = nil");
        
        return @{};
    }
    
    KVStoreManager *_kvStoreManger = [KVStoreManager sharedInstance];
    NSDictionary *_respondInfo = [_kvStoreManger getObjectById:userId fromTable:kAccountObjTableName];

    return _respondInfo;
}
//// 获取当前用户信息
//-(NSDictionary *)getCurrentUserInfo {
//
//    KVStoreManager *_kvStoreManger = [KVStoreManager sharedInstance];
//    
//    return [self getAccountInfoWithUid:[_kvStoreManger getCurrentUid]];
//}
// 获取当前用户uid
-(NSString *)getCurrentUid {

    KVStoreManager *_kvStoreManger = [KVStoreManager sharedInstance];
    
    NSDictionary *_currentUserInfo = [_kvStoreManger getObjectById:@"currentUserId" fromTable:kAccountObjTableName];
    NSString *_currentUid = [_currentUserInfo objectForKey:@"uid"];
    
    return _currentUid;
}
// 删除用户信息
-(void)deleteAccountInfoWithUid:(NSString *)userId {

    [[KVStoreManager sharedInstance] deleteObjectById:userId fromTable:kAccountObjTableName];
    [[KVStoreManager sharedInstance] deleteObjectById:userId fromTable:kTokenObjTableName];
}
// 删除全部用户信息
-(void)deleteAllUserInfo {

    [[KVStoreManager sharedInstance] clearTable:kAccountObjTableName];
    [[KVStoreManager sharedInstance] clearTable:kTokenObjTableName];
}

#pragma mark -- User Token

// 存储用户token
-(void)saveToken:(NSString *)token withUid:(NSString *)userId; {
    
    if (!userId) {
        
        NSLog(@"save token error, userId = nil");
        return ;
    }
    
    KVStoreManager *_kvStoreManger = [KVStoreManager sharedInstance];
    // 本地插表
    [_kvStoreManger putObject:@{@"token":token} withId:userId intoTable:kTokenObjTableName];
}
// 获取用户token
-(NSString *)getTokenWithUid:(NSString *)userId {

    if (!userId) {
        NSLog(@"get token error, uid = nil");
        
        return @"";
    }
    
    KVStoreManager *_kvStoreManger = [KVStoreManager sharedInstance];
    NSDictionary *_tokenInfo = [_kvStoreManger getObjectById:userId fromTable:kTokenObjTableName];
    NSString *_token = [_tokenInfo objectForKey:@"token"];
    
    return _token;
}
//// 获取当前用户的token
//-(NSString *)getCurrentToken {
//
//    KVStoreManager *_kvStoreManger = [KVStoreManager sharedInstance];
//    
//    return [self getTokenWithUid:[_kvStoreManger getCurrentUid]];
//}

@end
