//
//  SSLXBaseRequest.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SSLXBaseRequest.h"
#import "SysDeviceManager.h"

@implementation SSLXBaseRequest

// 全部请求都用Post请求
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

-(void)setIsNeedCacheRespond:(BOOL)isNeedCacheRespond {

    _isNeedCacheRespond = isNeedCacheRespond;
    
    if (self.isNeedCacheRespond) {
        NSString *respondString = [[KVStoreManager sharedInstance] getCacheRespondStringWithUrl:self.requestUrl withParams:self.requestArgument];
        [self setCacheRespondString:respondString];
    }
}

- (id)requestArgument {
    
    return [SysDeviceManager sharedInstance].baseSysDeviceInfo;
}

//- (NSInteger)cacheTimeInSeconds {
//    // n sec内请求会缓存
//    return 5.0f;
//}

@end
