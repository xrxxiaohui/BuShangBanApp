//
//  SSLXUrlParamsRequest.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SSLXBaseRequest.h"

@interface SSLXUrlParamsRequest : SSLXBaseRequest

@property (nonatomic, strong) NSDictionary *paramsDict;
@property (nonatomic, copy) NSString *urlString;

+(void)postStatReqWithUrl:(NSString *)url;

@end
