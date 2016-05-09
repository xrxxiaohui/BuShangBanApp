//
//  SSLXBaseRequest.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <YTKRequest.h>
#import "SSLXResultRequest.h"

@interface SSLXBaseRequest : YTKRequest

@property (nonatomic, assign) BOOL isNeedCacheRespond;
@property (nonatomic, copy) NSString *cacheRespondString;
@property (nonatomic, assign) YTKRequestMethod requestMethod;


@end
