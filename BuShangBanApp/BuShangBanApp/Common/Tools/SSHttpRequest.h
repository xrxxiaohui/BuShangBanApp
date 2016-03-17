//
//  SSHttpRequest.h
//  ShunShunLiuXue
//
//  Created by AndyJerry on 15/9/16.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//  底层网络库封装

#import <Foundation/Foundation.h>

@interface SSHttpRequest : NSObject
/**
 *  get请求
 *
 *  @param url     url
 *  @param params  参数
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  post请求
 *
 *  @param url     url
 *  @param params  参数
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+ (NSString *)token;
@end
