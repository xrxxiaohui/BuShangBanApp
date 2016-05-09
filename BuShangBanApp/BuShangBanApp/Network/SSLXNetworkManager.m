//
//  SSLXNetworkManager.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SSLXNetworkManager.h"
#import <YTKNetworkConfig.h>

// 正式服务器
//#define kBaseUrl @"http://api.shunshunliuxue.com" // api

//#define kBaseStatUrl @"http://123.57.64.181:8086/"

//#define kBaseUrl @"http://apitemp.shunshunliuxue.com" // apitemp

#warning -  警告！警告！！危险！！危险！！！ 用的是测试地址
//#define kBaseUrl @"https://leancloud.cn:443/1.1/classes/" // apitest
#define kBaseUrl @"" // apitest

static id _instance;

@interface SSLXNetworkManager ()

@end    

@implementation SSLXNetworkManager

// 单例
+(instancetype)sharedInstance {
    
    static dispatch_once_t onceDispatch;
    
    dispatch_once(&onceDispatch, ^{
        _instance = [[SSLXNetworkManager alloc] init];
        
        // 配置网络
        YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
        config.baseUrl = kBaseUrl;
        //    config.cdnUrl = @"http://fen.bi";
    });
    
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{   //onceToken是GCD用来记录是否执行过 ，如果已经执行过就不再执行(保证执行一次）
        _instance = [super allocWithZone:zone];
        
        // 配置网络
        YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
        config.baseUrl = kBaseUrl;
        //    config.cdnUrl = @"http://fen.bi";
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone {

    return _instance;
}

#pragma mark -- Actions

-(void)startApiWithRequest:(SSLXBaseRequest *)baseRequest successBlock:(void (^)(SSLXResultRequest *request))successResult failureBlock:(void (^)(SSLXResultRequest *request))failureResult {
    
//    if ([baseRequest cacheJson]) {
//        NSDictionary *json = [baseRequest cacheJson];
//        NSLog(@"cache json = %@", json);
//        // show cached data
//    }

    [baseRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *successRequest){
    
        NSDictionary *_nsDic  = [successRequest.responseString objectFromJSONString];//[super parseJsonRequest:request];
        // 保证是字典类型
//        if (_nsDic && [_nsDic isKindOfClass:[NSDictionary class]] && [[_nsDic valueForKeyPath:@"result.status"] isKindOfClass:[NSString class]])
        if (_nsDic && [_nsDic isKindOfClass:[NSDictionary class]] ){
            
//            if ([[_nsDic valueForKeyPath:@"result.status"] isEqualToString:@"01"]) {
                if (successResult) {
                    
                    successResult((SSLXResultRequest *)successRequest);
                    
                    if (baseRequest.isNeedCacheRespond) {
                        // 缓存数据
                        [[KVStoreManager sharedInstance] cacheRespondString:successRequest.responseString withRequestUrl:baseRequest.requestUrl withParams:baseRequest.requestArgument];
                    }
//                }
            }
//            else if ([[_nsDic valueForKeyPath:@"result.status"] isEqualToString:@"00"]) {
//                
//                if ([[UserAccountManager sharedInstance] checkLogin]) {
//                    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginOutNotification object:nil];
//                }
//                
//            }
            else {
            
                if (failureResult) {
                    failureResult((SSLXResultRequest *)successRequest);
                }
            }
            
        }
        
    } failure:^(YTKBaseRequest *failRequest){
    
        NSDictionary *_nsDic  = [failRequest.responseString objectFromJSONString];
//         保证是字典类型
        if (_nsDic && [_nsDic isKindOfClass:[NSDictionary class]]) {
        
            if (failureResult) {
                failureResult((SSLXResultRequest *)failRequest);
            }
//            [MBProgressHUD showError:[NSString stringWithFormat:@"%@",[_nsDic objectForKey:@"error"]]];
        }
        
        
    }];
}

@end
