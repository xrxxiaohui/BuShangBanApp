//
//  KVStoreManager.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <YTKKeyValueStore/YTKKeyValueStore.h>

@interface KVStoreManager : YTKKeyValueStore

+(instancetype)sharedInstance;

// 通用存储方法
-(void)saveObj:(id)obj forKey:(NSString *)key;
// 通用获取方法
-(id)getObjWithKey:(NSString *)key;
// 删除
-(void)deleteObjWithKey:(NSString *)key;

// 加入最近搜索
-(void)updateSearchHistoryWithString:(NSString *)searchString;
// 获取最新搜索
-(NSArray *)getSearchHistoryList;
// 删除历史记录
-(void)deleteSearchHistory;

// 加入缓存
-(void)cacheRespondString:(NSString *)resString withRequestUrl:(NSString *)reqUrl withParams:(NSDictionary *)params;
// 获取缓存
-(NSString *)getCacheRespondStringWithUrl:(NSString *)reqUrl withParams:(NSDictionary *)params;
// 删除缓存
-(void)deleteCacheData;

// 存储用户信息
-(void)saveAccountWithUserInfo:(NSDictionary *)userInfo withUid:(NSString *)userId;
// 获取用户信息
-(NSDictionary *)getAccountInfoWithUid:(NSString *)userId;
//// 获取当前用户信息
//-(NSDictionary *)getCurrentUserInfo;
// 获取当前用户uid
-(NSString *)getCurrentUid;
// 删除用户信息
-(void)deleteAccountInfoWithUid:(NSString *)userId;
// 删除全部用户信息
-(void)deleteAllUserInfo;

// 存储用户token
-(void)saveToken:(NSString *)token withUid:(NSString *)userId;
// 获取用户token
-(NSString *)getTokenWithUid:(NSString *)userId;
//// 获取当前用户的token
//-(NSString *)getCurrentToken;


@end
