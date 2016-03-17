//
//  SSHttpRequest.m
//  ShunShunLiuXue
//
//  Created by AndyJerry on 15/9/16.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "SSHttpRequest.h"
#import "AFNetworking.h"
@implementation SSHttpRequest

/**
 *  get请求
 *
 *  @param url     url
 *  @param params  参数
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

    // 2.发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  post请求
 *
 *  @param url     url
 *  @param params  参数
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    [MBProgressHUD showMessage:@"请求网络中"];
    // 2.发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
//            [MBProgressHUD hideHUDForView];
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
//            [MBProgressHUD hideHUDForView];
//            [MBProgressHUD showError:@"网络异常"];
            failure(error);
        }
    }];
}

+ (NSString *)token {
    
   return [[UserAccountManager sharedInstance] getCurrentToken];
    
//    NSString *plistPath = [self fileTextPath:@"token.plist"];
//    NSMutableArray *listArray = [[NSMutableArray alloc ] initWithContentsOfFile:plistPath];
//    if([listArray count]==0){
//        listArray = nil;
//        return nil;
//    }
//    return [listArray objectAtIndex:0];
}

+ (NSString *)fileTextPath:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirctory = [paths objectAtIndex:0];
    return [docDirctory stringByAppendingPathComponent:fileName];
}

@end
